//
//  MapListViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/11/9.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "MapListViewController.h"

#import <AMapNaviKit/AMapNaviKit.h>

#import "SearchModel.h"

#import "SearchTableViewCell.h"

#import "NaviPointAnnotation.h"

//自定义的大头针
#import "MyPointAnnotation.h"

#import "DetailViewController.h"

#import "RouteViewController.h"

#import <AMapLocationKit/AMapLocationKit.h>

#define kRowHeight 50*frameY/480.0*3

#define kMapHeight  frameY - kRowHeight-65

@interface MapListViewController ()<UITableViewDataSource,UITableViewDelegate,MAMapViewDelegate,AMapLocationManagerDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) MAMapView *mapView;

@property (nonatomic,strong) MAMapView *map;

@property (nonatomic,strong) KongCVHttpRequest *request;

//大头针数组
@property (nonatomic,strong) NSMutableArray *pointArray;

@property (nonatomic,strong) NaviPointAnnotation *ann;//定位

@property (nonatomic,strong) NaviPointAnnotation *point;

@property (nonatomic,strong) NaviPointAnnotation *annotation;

@property (nonatomic,strong) UIView   *listView;

@property (nonatomic,strong) UIButton *button; //返回按钮

@property (nonatomic,strong) NSNumber *skipNum;
@property (nonatomic,assign) int skip;

@property (nonatomic,strong) AMapLocationManager *locationManger;

@property (nonatomic,assign) CGFloat locationLa;
@property (nonatomic,assign) CGFloat locationLo;

//按距离或按价格排序
@property (nonatomic,copy)   NSString *sort;

//是否开启持续定位
@property (nonatomic,copy)   NSString *locationStr;

@end

@implementation MapListViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"FourPage"];
    
    [AMapLocationServices sharedServices].apiKey = amapAppKey;
    
    self.locationStr = [StringChangeJson getValueForKey:@"isLoaction"];
    
    if ([self.locationStr isEqualToString:@"no"]) {
        
        [self.mapView removeAnnotation:_ann];
    
        [self.locationManger stopUpdatingLocation];
        
    }else if([self.locationStr isEqualToString:@"yes"]){
    
        [self.locationManger startUpdatingLocation];
        
    }
    
}

-(AMapLocationManager *)locationManger{

    if (_locationManger == nil) {
        
        _locationManger = [[AMapLocationManager alloc]init];
        
        _locationManger.delegate = self;
        
    }
    
    return _locationManger;
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [self.mapView removeAnnotation:_ann];

    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"fourPage"];
    
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    //初始化定位管理类
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"isLoaction"];
    
    self.locationStr = [StringChangeJson getValueForKey:@"isLoaction"];
    
    if (![self.locationStr isEqualToString:@"no"]) {
        
        static dispatch_once_t onceToken;dispatch_once(&onceToken, ^{
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"空车位提示" message:@"空车位会开启你的位置信息,并在后台持续更新,确定立即开启该功能吗?" delegate:self cancelButtonTitle:@"暂不开启" otherButtonTitles:@"确定", nil];
            
            [alertView show];
            
        });
        
        [self.locationManger startUpdatingLocation];
        
    }
    
    
    //初始化地图
    [self initMap];
    
    //初始化tableView
    [self initTableView];
    
    _dataArray = [NSMutableArray array];
    
    //返回按钮
    _button = [UIButton buttonWithFrame:CGRectMake(-5,10,85,70) type:UIButtonTypeCustom title:nil target:self action:@selector(leftItem)];
    
    [_button setBackgroundImage:[UIImage imageNamed:@"fh"] forState:UIControlStateNormal];
    
    [self.view addSubview:_button];
    
    self.sort = @"";
    
    _skip = 0;
    
    _skipNum = [NSNumber numberWithInt:_skip];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        
        [self downloadData];
        
    });
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"isLoaction"];
        
        [self.locationManger stopUpdatingLocation];
        
        [self.mapView removeAnnotation:_ann];
        
        self.locationLa = 0;
        
        self.locationLo = 0;
        
    }else if (buttonIndex == 1){
        
         [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"isLoaction"];
        
        [self.locationManger startUpdatingLocation];
        
    }
    
}


- (void)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----  AMapLocationManagerDelegate
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    
    self.locationLa = location.coordinate.latitude;
    
    self.locationLo = location.coordinate.longitude;
    
    //定位大头针
    [self.mapView removeAnnotation:_ann];
    
    _ann = [[NaviPointAnnotation alloc]init];
    
    _ann.navPointType = NavPointAnnotationLocation;
    
    NSString *latitude = [NSString stringWithFormat:@"%f",self.locationLa];
    
    NSString *longTitude = [NSString stringWithFormat:@"%f",self.locationLo];
    
    float lat = [latitude floatValue];
    
    float longitude = [longTitude floatValue];
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, longitude);
    
    _ann.coordinate = coord;
    
    [_mapView addAnnotation:_ann];
}

//初始化UITableView
- (void)initTableView{

    _listView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.mapView.frame), frameX,kRowHeight)];
    
    [self.view addSubview:_listView];

    //上下调节地图大小按钮
    UIButton *button = [UIButton buttonWithFrame:CGRectMake(frameX/2-55/2.0,0,55,30) type:UIButtonTypeCustom title:nil target:self action:@selector(listClick:)];
    
    [button setBackgroundImage:[UIImage imageNamed:@"xjt"] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:@"sjt"] forState:UIControlStateSelected];
    
    button.selected = NO;
    
    [_listView addSubview:button];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10,2,100,30)];
    
    label.text = @"排序";
    
    label.font = UIFont(15);
    
    [self.listView addSubview:label];
    
    //排序
    UIButton *sortBtn = [UIButton buttonWithFrame:CGRectMake(frameX - 60,2,60, 30) type:UIButtonTypeCustom title:@"" target:self action:@selector(sortBtn:)];
    
    [sortBtn setTitle:@"按价格" forState:UIControlStateNormal];
    
    [sortBtn setTitle:@"按距离" forState:UIControlStateSelected];
    
    sortBtn.titleLabel.font = UIFont(15);
    
    sortBtn.selected = NO;
    
    if (![self.hire_field isEqualToString:@"parking"]) {
     
            [self.listView addSubview:sortBtn];
        
    }
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,30, frameX,kRowHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,frameX,100)];
    
    self.tableView.tableFooterView = footerView;
    
    [self.listView addSubview:_tableView];
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _skip = 0;
        
        _skipNum = [NSNumber numberWithInt:_skip];
        
        [self downloadData];
        
    }];
    
    //[self.tableView.mj_header beginRefreshing];
    
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _skip += 10;
        
        _skipNum = [NSNumber numberWithInt:_skip];
        
        [self downloadData];
        
    }];
    
}

//排序
- (void)sortBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        
        self.sort  = @"price_asc";
        
        [self downloadData];
        
    }else{
        
         self.sort = @"";
        
        [self downloadData];
        
    }
}


//改变地图大小
- (void)listClick:(UIButton *)button{
    
    button.selected = !button.selected ;
    
    if (button.selected == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            if (frameX == 320.0 && frameY == 480.0) {
                _mapView.frame =  CGRectMake(0, 0, frameX,kMapHeight+50*2-17);
                _listView.frame = CGRectMake(0, CGRectGetMaxY(self.mapView.frame), frameX, kRowHeight-50*2);
            }else if (frameX == 375.0){
                _mapView.frame =  CGRectMake(0, 0, frameX,kMapHeight+3*50-8);
                _listView.frame = CGRectMake(0,CGRectGetMaxY(_mapView.frame),frameX,kRowHeight-50*3);
            }else if (frameX == 414.0){
                _mapView.frame =  CGRectMake(0, 0, frameX,kMapHeight+3*50+12);
                _listView.frame = CGRectMake(0,CGRectGetMaxY(_mapView.frame),frameX, kRowHeight-3*50);
            }else{
                _mapView.frame =  CGRectMake(0, 0, frameX,kMapHeight+50*2*frameY/480.0);
                _listView.center = CGPointMake(frameX/2,525);
                
            }
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            if (frameX == 320.0 && frameY == 480.0 ) {
                _mapView.frame = CGRectMake(0,0, frameX,kMapHeight-18);
                _listView.frame = CGRectMake(0,CGRectGetMaxY(_mapView.frame),frameX, kRowHeight);
                
            }else if (frameX == 375.0){
                _mapView.frame = CGRectMake(0,0, frameX,kMapHeight-8);
                _listView.frame = CGRectMake(0,CGRectGetMaxY(self.mapView.frame),frameX, kRowHeight);
            }else if (frameX == 414.0){
                _mapView.frame = CGRectMake(0,0, frameX,kMapHeight+12);
                _listView.frame = CGRectMake(0, CGRectGetMaxY(_mapView.frame), frameX,kRowHeight);
            }else{
                _mapView.frame = CGRectMake(0,0, frameX,kMapHeight+10);
                _listView.frame   = CGRectMake(0, CGRectGetMaxY(_mapView.frame), frameX, kRowHeight);
            }
        } completion:nil];
    }
}

//初始化地图
- (void)initMap{
    
    if (_mapView == nil) {
        if (frameX == 320 && frameY == 480.0) {
            _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0,0, frameX,kMapHeight-18)];
        }else if (frameX == 375.0){
            _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0,0, frameX,kMapHeight-8)];
        }else if (frameX == 414.0){
            _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0,0, frameX,kMapHeight+12)];
        }else{
            _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0,0, frameX,kMapHeight+10)];
        }
        
        _mapView.delegate = self;
    }
    
    _mapView.showsCompass = NO;//罗盘
    
    _mapView.showsScale = NO;//比例尺
    
    [self.mapView setZoomLevel:14.0 animated:YES];
    
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(self.latitude,self.longitude)];
    
    [self.view addSubview:_mapView];

}

- (void)downloadData{
    
    NSNumber *latitude = [NSNumber numberWithFloat:self.latitude];
    
    NSNumber *longitude = [NSNumber numberWithFloat:self.longitude];
    
    NSDictionary *dictionary;

    if ([[NSString stringWithFormat:@"%@",self.hire_type] isEqualToString:@"2"]) {
        dictionary = @{
                                     @"address":self.name,
                                     @"location_info":@{@"latitude":latitude ,@"longitude":longitude},
                                     @"hire_method_id":@"",
                                     @"skip":_skipNum,
                                     @"limit":@10,
                                     @"mode":self.mode,
                                     @"sort":self.sort,
                                     @"hire_field":self.hire_field} ;
    }else{
        dictionary = @{
                                      @"address":self.name,
                                      @"location_info":@{@"latitude":latitude ,@"longitude":longitude},
                                      @"hire_method_id":self.hire_method_id,
                                      @"skip":_skipNum,
                                      @"limit":@10,
                                      @"mode":self.mode,
                                      @"sort":self.sort,
                                      @"hire_field":self.hire_field} ;
    }
    
    _request = [[KongCVHttpRequest alloc]initWithRequests:kFindUrl sessionToken:nil dictionary:dictionary andBlock:^(NSDictionary *data) {
        
        NSArray *arrayss = data[@"result"];
        
       if (arrayss.count != 0) {
            
            [_dataArray removeAllObjects];
            
            for (NSDictionary *dictionary in arrayss) {
                
                SearchModel *model = [SearchModel modelWithDictionary:dictionary];
                
                [self.dataArray addObject:model];
                
            }
           
           [self.tableView reloadData];

       }
        
        if (self.dataArray.count == 0) {
            
            UILabel *label  = [UILabel labelWithFrame:CGRectMake(frameX/2.0 - 50,80, 100, 30) text:@"暂时没有数据" Color:nil Font:UIFont(16)];
            
            label.textColor = [UIColor blackColor];
            
            [self.tableView addSubview:label];
            
        }
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView.mj_footer endRefreshing];
        
        //添加大头针
        [self performSelectorOnMainThread:@selector(addPinMap) withObject:nil waitUntilDone:YES];
        
    }];
}

// 添加地图大头针
- (void)addPinMap{
    
    [self.mapView removeAnnotations:_pointArray];
    
    _pointArray = [NSMutableArray array];
    
    for (int i = 0; i<_dataArray.count; i++) {
        
        SearchModel *model = _dataArray[i];
        
        _point = [[NaviPointAnnotation alloc]init];
        
        _point.navPointType = NavPointAnnotation;

        _point.title = model.address;
        
        float lat = [model.location[@"latitude"] floatValue];
        
        float longitude = [model.location[@"longitude"]floatValue];
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, longitude);
        
        _point.coordinate = coord;
        
        [_pointArray addObject:_point];
    }
    [_mapView addAnnotations:_pointArray];
}

#pragma mark -- mapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    
    if ([annotation isKindOfClass:[NaviPointAnnotation class]]) {
        
        static NSString *annotationId = @"ann";
        
        MyPointAnnotation *pointAnnotationView = (MyPointAnnotation *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationId];
        
        if (pointAnnotationView == nil) {
            
            pointAnnotationView = [[MyPointAnnotation alloc]initWithAnnotation:annotation reuseIdentifier:annotationId];
        }
        
        pointAnnotationView.draggable = NO;
        
        NaviPointAnnotation *navAnnotation = (NaviPointAnnotation*)annotation;
        
        //定位
        if (navAnnotation.navPointType == NavPointAnnotation) {
                
            pointAnnotationView.image = [UIImage imageNamed:@"icon_tingchewei"];
                
        }else if (navAnnotation.navPointType == NavPointAnnotationLocation){
                
            pointAnnotationView.image = [UIImage imageNamed:@"icon_dangqianweizhi"];
                
        }
        
        return pointAnnotationView;
    }
    
    return nil;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ident = @"ident";
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (cell == nil) {
        
        cell = [[SearchTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        
        //根据租用objectid 获取对应的价格
        cell.hire_method_id = self.hire_method_id;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    SearchModel *model = _dataArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SearchModel *model = _dataArray[indexPath.row];

    float lat = [model.location[@"latitude"] floatValue];
    
    float longitude = [model.location[@"longitude"]floatValue];
    
    if ([self.mode isEqualToString:@"community"]) {
        
        DetailViewController *deailController = [[DetailViewController alloc]init];
        
        deailController.endLa = lat;
        
        deailController.endLo = longitude;
        
        deailController.park_id = model.objectId;
        
        deailController.mode = self.mode;
        
        deailController.hire_method_id = self.hire_method_id;
        
        deailController.startLa = self.locationLa;
        
        deailController.startLo = self.locationLo;
        
        deailController.ruleStr = self.ruleStr;
        
        deailController.park_space = [NSString stringWithFormat:@"%@",model.park_space];
        
        [self.navigationController pushViewController:deailController animated:YES];
        
    }else if ([self.mode isEqualToString:@"curb"]){
        
        RouteViewController *deailController = [[RouteViewController alloc]init];
        
        deailController.endLa = lat;
        
        deailController.endLo = longitude;
        
        deailController.park_id = model.objectId;
        
        deailController.mode = self.mode;
        
        deailController.hire_method_id = self.hire_method_id;
        
        deailController.startLa = self.locationLa;
        
        deailController.startLo = self.locationLo;
        
        deailController.ruleStr = self.ruleStr;
        
        deailController.price = @"price";
        
        [self.navigationController pushViewController:deailController animated:YES];
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
    
}


-(void)viewDidDisappear:(BOOL)animated{
    
    _ann = nil;
    
    _point = nil;
    
}



@end