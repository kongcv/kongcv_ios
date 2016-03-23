//
//  RouteViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/8.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "RouteViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <iflyMSC/IFlySpeechSynthesizer.h>
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>
#import <AudioToolbox/AudioToolbox.h>

#import "KongCVViewController.h"

#import "DetailInfoModel.h"

#import "RouteTableViewCell.h"

#import "CommentTableViewCell.h"

#import "DVSwitch.h"

#import "RouteCommentModel.h"

#import "ZHXDataCenter.h"

#import "CommentViewController.h"

#import "PaymentViewController.h"


#define kGap4s     8.9
#define kGap6       10.8
#define kGap6p    11.5
#define kWidth4s   32.6
#define kWidth6     39.3
#define kWidth6p  42.3

@interface RouteViewController () <IFlySpeechSynthesizerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
//导航管理类
@property (nonatomic,strong) AMapNaviViewController *naviViewController;
@property (nonatomic,strong) MAMapView *mapView;
//导航坐标点
@property (nonatomic,strong) AMapNaviPoint *startPoint;
@property (nonatomic,strong) AMapNaviPoint *endPoint;
//语音播报类
@property (nonatomic,strong) IFlySpeechSynthesizer *iflySpeechSynthesizer;
//导航栏view
@property (nonatomic,strong) UIView *naView;
//网络请求
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) KongCVHttpRequest *comRequest;
//道路数据
@property (nonatomic,strong) NSMutableArray *dataArray;
//评论数据
@property (nonatomic,strong) NSMutableArray *commentDataArray;
//评论cell数组
@property (nonatomic,strong) NSMutableArray *commentCellArray;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UITableView *commentTableView;

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIView *commentView;


@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) NSNumber *skipNum;

@property (nonatomic,assign) int skip;

//导航按钮
@property (nonatomic,strong) UIButton *navBtn;
//判断显示道路详情  评论
@property (nonatomic,copy)   NSString *detailOrComment;


@end

@implementation RouteViewController


-(instancetype)init{
    
    if (self = [super init]) {
        _mapView = [[MAMapView alloc]init];
        _mapView.delegate = self;
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"SixPage"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCommentTableView) name:@"comment" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(confirm:) name:@"zhifu" object:nil];
    
}

//通知刷新评论列表
- (void)reloadCommentTableView{
    
    self.detailOrComment = @"comment";
    
    [self downloadComment];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"SixPage"];

}

- (void)addNavButton{
    //导航
    if (frameX == 320.0) {
        _navBtn = [ UIButton buttonWithFrame:CGRectMake(frameX -77,25,53,26) type:UIButtonTypeCustom title:nil target:self action:@selector(btn:)];
    }else if (frameX == 375.0 || frameX == 414.0){
        _navBtn = [ UIButton buttonWithFrame:CGRectMake(frameX -90,21,75,36) type:UIButtonTypeCustom title:nil target:self action:@selector(btn:)];
    }
    [_navBtn setBackgroundImage:[UIImage imageNamed:@"icon_dh_default"] forState:UIControlStateNormal];
    [_navBtn setBackgroundImage:[UIImage imageNamed:@"icon_dh_pressed"] forState:UIControlStateSelected];
    [self.view addSubview:_navBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.detailOrComment = @"detail";
    
    //设置导航条
    _naView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 64)];
    
    _naView.backgroundColor = RGB(254, 156, 0);
    
    [self.view addSubview:_naView];

    //导航坐标
    _endPoint = [AMapNaviPoint locationWithLatitude:_endLa longitude:_endLo];
    
    _startPoint = [AMapNaviPoint locationWithLatitude:_startLa longitude:_startLo];
    
    if (!self.pushMessage) {

        [self addNavButton];
    }
    
    UIView *view = [[UIView alloc]init];
    if (frameX == 320.0) {
        view.frame = CGRectMake(59,24,192,27);
        view.layer.cornerRadius = 12.0;
    }else if (frameX == 375.0){
        view.frame = CGRectMake(61,24,228,32.4);
        view.layer.cornerRadius = 16.0;
    }else if (frameX == 414.0){
        view.frame = CGRectMake(57.5,24,285.3,32.4);
        view.layer.cornerRadius = 17.0;
    }
    view.layer.masksToBounds = YES;
    view.layer.borderColor = RGB(255, 255, 255).CGColor;
    view.layer.borderWidth = 2;
    [self.view addSubview:view];
    
    DVSwitch *switc = [[DVSwitch alloc]initWithStringsArray:@[@"详情",@"评论"]];
    if (frameX == 320.0) {
        switc.frame = CGRectMake(60, 25,190,25);
    }else if (frameX == 375.0){
        switc.frame = CGRectMake(62.5,25,225,30.4);
    }else if (frameX == 414.0){
        switc.frame = CGRectMake(58.5,25,283.3,30.4);
    }
    switc.backgroundColor = [UIColor colorWithRed:254/255.0 green:156/255.0 blue:0 alpha:1.0];
    
    [switc setPressedHandler:^(NSUInteger index) {
        
        if (index == 0) {
            if (!self.pushMessage) {
                //导航
                [self addNavButton];
            }
            
            self.detailOrComment = @"detail";
            
            UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            self.tableView.tableHeaderView = headerView;
            
            [self.tableView reloadData];
            
            self.tabBarController.tabBar.hidden = NO;
            
        }else{
            
            [self.navBtn removeFromSuperview];

            self.tabBarController.tabBar.hidden = YES;
            
            self.detailOrComment = @"comment";
            
            [self.tableView reloadData];
            
            //下拉刷新
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
                _skip = 0;
            
                _skipNum = [NSNumber numberWithInt:_skip];
            
                [self downloadComment];
            
            }];
            
            //上拉加载
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
                _skip += 10;
                    
                _skipNum = [NSNumber numberWithInt:_skip];
                    
                [self downloadComment];
            
            }];
            
            [self addHaderView];
            
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, frameY - 40, frameX, 40)];
            view.backgroundColor = RGB(247,247,247);
            [self.view addSubview:view];
            
            _textField = [[UITextField alloc]init];
           
            _textField.frame = CGRectMake(20,4, frameX - 40,32);
            
            _textField.delegate = self;
            
            _textField.placeholder = @"写评论......";
            
            _textField.borderStyle = UITextBorderStyleRoundedRect;
            
            [view addSubview:_textField];
            
        }
        
    }];
    
    [self.view addSubview:switc];
    
    UIButton *button = [UIButton buttonWithFrame:CGRectMake(10,15,75,45) type:UIButtonTypeCustom title:nil target:self action:@selector(leftItem)];
    
    [button setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    //初始化语音播报对象
    [self initIFlySpeech];
    
    //初始化地图控制器
    [self initNaviViewController];
    
    //初始化UITableView
    [self initTableView];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        [self download];
    });
    dispatch_async(queue, ^{
        [self downloadComment];
    });
    
    //初始化数组
     _dataArray = [NSMutableArray array];
    //初始化评论数据数组
    _commentDataArray = [NSMutableArray array];
    //初始化cell数组
    _commentCellArray    = [NSMutableArray array];
    
    _skip = 0;
    
    _skipNum = [NSNumber numberWithInt:_skip];
    
}



#pragma mark ---  UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [_textField resignFirstResponder];
    
    CommentViewController *commentController = [[CommentViewController alloc]init];
    
    commentController.parkId = self.park_id;
    
    commentController.mode = self.mode;
    
    [self.navigationController pushViewController:commentController animated:YES];
    
 }

//下载数据
- (void)download{

    if (self.park_id && self.mode) {
        
        NSDictionary *dictionary = @{@"park_id":self.park_id,@"mode":self.mode};
        
        _request = [[KongCVHttpRequest alloc]initWithRequests:kDetailInfoUrl sessionToken:nil dictionary:dictionary andBlock:^(NSDictionary *data) {
            
            NSDictionary *dic = data[@"result"];
            
            DetailInfoModel *model = [DetailInfoModel modelWithDic:dic];
            
            [_dataArray addObject:model];
            
            [self.tableView reloadData];
            
        }];
    }
    
}
//下载评论数据
- (void)downloadComment{
    
    
    if (self.park_id && self.mode && _skipNum) {
        
        NSDictionary *dic = @{@"park_id" : self.park_id, @"skip":_skipNum, @"limit":@10, @"mode" :self.mode};
        
        _comRequest = [[KongCVHttpRequest alloc]initWithRequests:kCommentUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
            
            NSArray *array = data[@"result"];
            
            if (array.count != 0  ) {
                
                [_commentCellArray removeAllObjects];
                
                [_commentDataArray removeAllObjects];
                
                for (NSDictionary *dic in data[@"result"]) {
                    
                    RouteCommentModel *model = [RouteCommentModel modelWithDictionary:dic];
                    
                    [_commentDataArray addObject:model];
                    
                    CommentTableViewCell *cell = [[CommentTableViewCell alloc]init];
                    
                    [_commentCellArray addObject:cell];
                    
                }
                
                [self.tableView reloadData];
            }
            
            [self.tableView.mj_footer    endRefreshing];
            
            [self.tableView.mj_header  endRefreshing];
            
        }];

        
    }

    }


- (void)leftItem{
    
    self.tabBarController.tabBar.hidden = NO;
  
    [self.navigationController popViewControllerAnimated:YES];

}

//初始化UITableView
- (void)initTableView{
    
    //初始化详情UITableVIew
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_naView.frame), frameX, frameY-64) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
}

- (void)addHaderView{

    //评论头视图
    UIView *view = [[UIView alloc]init];
    if (frameX == 320.0) {
        view.frame = CGRectMake(0,0, frameX, 33);
    }else if (frameX == 375.0){
        view.frame = CGRectMake(0,0, frameX, 40);
    }else if (frameX == 414.0){
        view.frame = CGRectMake(0,0, frameX, 43);
    }
    self.tableView.tableHeaderView = view;
    
    //评论尾视图
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 100)];
    self.tableView.tableFooterView = footerView;
    
    //透视图上文字
    _label = [[UILabel alloc]init];
    if (frameX == 320.0) {
        _label.font = UIFont(19);
        _label.frame = CGRectMake(kGap4s,0, frameX-kGap4s, 33);
    }else if (frameX == 375.0){
        _label.font = UIFont(22);
        _label.frame = CGRectMake(kGap6,0, frameX-kGap6,40);
    }else if (frameX == 414.0){
        _label.font = UIFont(23);
        _label.frame = CGRectMake(kGap6p,0, frameX-kGap6p, 43);
    }
    _label.text = @"评论";
    _label.textColor = RGB(95, 95, 95);
    [view addSubview:_label];
    
    //头视图下label
    UILabel *lab = [[UILabel alloc]init];
    lab.backgroundColor = RGB(254, 156, 0);
    if (frameX == 320.0) {
        lab.frame = CGRectMake(kGap4s - 4,CGRectGetMaxY(_label.frame),45,1.5);
    }else if (frameX == 375.0){
        lab.frame = CGRectMake(kGap6 - 6, CGRectGetMaxY(_label.frame),55, 2);
    }else if (frameX == 414.0){
        lab.frame = CGRectMake(kGap6p - 6, CGRectGetMaxY(_label.frame),58, 2);
    }
    [view addSubview:lab];
    
    //横线
    UIImageView *imageViewLine = [[UIImageView alloc]init];
    if(frameX == 320.0){
        imageViewLine.frame = CGRectMake(0, CGRectGetMaxY(lab.frame), frameX, 1);
    }else if (frameX == 375.0){
        imageViewLine.frame = CGRectMake(0, CGRectGetMaxY(lab.frame), frameX, 1);
    }else if (frameX == 414.0){
        imageViewLine.frame = CGRectMake(0, CGRectGetMaxY(lab.frame), frameX, 1);
    }
    imageViewLine.image = [UIImage imageNamed:@"720@2x"];
    [view addSubview:imageViewLine];
}


#pragma mark ---- UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count;
    
    if ([self.detailOrComment isEqualToString:@"detail"]) {
        
        count = _dataArray.count;
        
    }else if ([self.detailOrComment isEqualToString:@"comment"]){
        
        count = _commentDataArray.count;
        
    }
    
    return count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.detailOrComment isEqualToString:@"detail"]) {
        
        static NSString *Ident = @"ident";
        
        RouteTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:Ident];

        if (!cell) {
            
            cell = [[RouteTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Ident];
            
            cell.park_id = self.park_id;
            
            cell.mode = self.mode;
            
            cell.hire_method_id = self.hire_method_id;
            
            cell.listprice = self.price;
            
            cell.ruleStr = self.ruleStr;
            
        }
        
        DetailInfoModel *model = _dataArray[indexPath.row];
        
        cell.model = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    static NSString *Ident = @"commentIdent";
    
    CommentTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:Ident];
    
    if (!cells) {
        
        cells = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Ident];
        
    }
    
    RouteCommentModel *model = _commentDataArray[indexPath.row];
    
    cells.routeModel = model;
    
    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cells;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat length;
    
    if ([self.detailOrComment isEqualToString:@"detail"]) {
        
        if (frameX == 320.0) {
            
            length = 720;
            
        }else if(frameX == 375.0){
            
            length = 750;
            
        }else{
            
            length = 900;
            
        }
        
    }else if ([self.detailOrComment isEqual:@"comment"]){
        
        CommentTableViewCell *cell = _commentCellArray[indexPath.row];
        
        cell.model = _commentDataArray[indexPath.row];
        
        length = cell.cellHeight+16.6;
        
    }
    
    return length;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


//支付
- (void)confirm:(NSNotification *)info{
    
    NSDictionary *dic = info.userInfo;
    
    PaymentViewController *paymentViewController = [[PaymentViewController alloc]init];
    
    paymentViewController.mode = self.mode;
    
    paymentViewController.hire_methold_id = dic[@"hire_method_id"];
    
    paymentViewController.park_id = self.park_id;
    
    paymentViewController.priceNum = dic[@"price"];
    
    [paymentViewController setHidesBottomBarWhenPushed:YES];
    
    [self presentViewController:paymentViewController animated:YES completion:nil];
    
}

//初始化语音播报对象
- (void)initIFlySpeech{
    
    if (self.iflySpeechSynthesizer == nil) {
        
        _iflySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
        
    }
    
    _iflySpeechSynthesizer.delegate = self;
    
}
//初始化地图控制器
- (void)initNaviViewController{
    
    if (_naviViewController == nil) {
        
        _naviViewController = [[AMapNaviViewController alloc]initWithDelegate:self];
        
    }
    
}
//导航按钮
- (void)btn:(UIButton *)bt{
    
    if (self.startLa && self.startLo && _endLa && _endLo) {
        
        NSArray *startPoints = @[_startPoint];
        
        NSArray *endPoints = @[_endPoint];
        
        [self.naviManger calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints:nil drivingStrategy:0];
        
    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您没有开启持续定位功能" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    
}
#pragma mark - naviMangerDelegate
//计算路径时调用方法
- (void)naviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager{
    
    [super naviManagerOnCalculateRouteSuccess:naviManager];
    
    [self.naviManger presentNaviViewController:self.naviViewController animated:YES];
    
}

//进入导航界面
- (void)naviManager:(AMapNaviManager *)naviManager didPresentNaviViewController:(UIViewController *)naviViewController{
    
    [super naviManager:naviManager didPresentNaviViewController:naviViewController];
    
    //开始导航
    [self.naviManger startGPSNavi];
    
}

//语音播报
- (void)naviManager:(AMapNaviManager *)naviManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType{
    
    if (soundStringType == AMapNaviSoundTypePassedReminder) {
        
        AudioServicesPlaySystemSound(1009);
        
    }else{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            [_iflySpeechSynthesizer startSpeaking:soundString];
            
        });
    }
}

//点击结束导航按钮执行的方法
- (void)naviViewControllerCloseButtonClicked:(AMapNaviViewController *)naviViewController{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        [self.iflySpeechSynthesizer stopSpeaking];
        
    });
    
    [self.naviManger stopNavi];
    
    [self.naviManger dismissNaviViewControllerAnimated:YES];
    
}

//右下角的按钮
- (void)naviViewControllerMoreButtonClicked:(AMapNaviViewController *)naviViewController{
    
    if (self.naviViewController.viewShowMode == AMapNaviViewShowModeCarNorthDirection) {
        
        self.naviViewController.viewShowMode = AMapNaviViewShowModeCarNorthDirection;
        
    }else{
        
        self.naviViewController.viewShowMode = AMapNaviViewShowModeCarNorthDirection;
        
    }
    
}

//右上角的转向按钮
- (void)naviViewControllerTurnIndicatorViewTapped:(AMapNaviViewController *)naviViewController{
    
    [self.naviManger readNaviInfoManual];
    
}

//语音合成结束后，回调方法
- (void)onCompleted:(IFlySpeechError *)error{
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [_textField resignFirstResponder];
}

@end
