//
//  CurbNotificationViewController.m
//  kongcv
//
//  Created by 空车位 on 16/1/16.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "CurbNotificationViewController.h"
#import "RouteTableViewCell.h"
#import "RouteCommentModel.h"
#import "CommentTableViewCell.h"
#import "DetailInfoModel.h"
#import "NotiTableViewCell.h"
#import "DVSwitch.h"
#import "PaymentViewController.h"

#import <AMapNaviKit/AMapNaviKit.h>
#import <iflyMSC/IFlySpeechSynthesizer.h>
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>
#import <AudioToolbox/AudioToolbox.h>
#define kGap4s     8.9
#define kGap6       10.8
#define kGap6p    11.5
#define kWidth4s   32.6
#define kWidth6     39.3
#define kWidth6p  42.3
@interface CurbNotificationViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,IFlySpeechSynthesizerDelegate>
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) KongCVHttpRequest *commentRequest;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *commentArray;
@property (nonatomic,strong) NSMutableArray *commentCellArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *commentTableView;
@property (nonatomic,strong) UIView *naView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIButton *navBtn;
@property (nonatomic,strong) DetailInfoModel *modelss;
@property (nonatomic,strong) NSNumber *skipNum;
@property (nonatomic,assign) int skip;
@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) AMapNaviViewController *naviViewController;
@property (nonatomic,strong) IFlySpeechSynthesizer *iflySpeechSynthesizer;
@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) AMapNaviPoint *endPoint;
@property (nonatomic,strong) AMapNaviPoint *strartPoint;
@end

@implementation CurbNotificationViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payButtonClick:) name:@"payButtonClicksss" object:nil];
    
    [MobClick beginLogPageView:@"NinePage"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"payButtonClick" object:nil];
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"NinePage"];
}


-(instancetype)init{
    
    if (self = [super init]) {
        _mapView = [[MAMapView alloc]init];
        _mapView.delegate = self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = RGB(254, 254, 254);
    self.view.backgroundColor = [UIColor whiteColor];
    _naView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 64)];
    _naView.backgroundColor = RGB(254, 156, 0);
    [self.view addSubview:_naView];
    
    //初始化数据数组
    _commentArray = [NSMutableArray array];
    //初始化cell数组
    _commentCellArray = [NSMutableArray array];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self downLoad];
    });
    dispatch_async(queue, ^{
        [self downloadCommentData];
    });
    
    [self initTableView];
    [self initIFlySpeech];
    [self initNaviViewController];
    
//    _endPoint = [AMapNaviPoint locationWithLatitude:39.933177 longitude:116.435203];
//    
//    _strartPoint = [AMapNaviPoint locationWithLatitude:_endLa longitude:_endLo];
    
    //布局UI
    [self layoutUI];
 
}


- (void)payButtonClick:(NSNotification *)info{

    NSDictionary *dictionary = info.userInfo;
    //NSArray *strartArr;
    //NSArray *endArra;
    NSString *startTimeStr;
    NSString *endTimeStr;
    if ([self.mode isEqualToString:@"curb"]) {
        if ([dictionary[@"hire_field"] isEqualToString:@"hour_meter"]) {
            startTimeStr = @"";
            endTimeStr = @"";
        }else{
            if (self.hire_end && self.hire_start) {
//                NSLog(@"%@----%@",self.hire_end,self.hire_start);
//                strartArr = [self.hire_start componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
//                endArra = [self.hire_end componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
//            
//                startTimeStr = [NSString stringWithFormat:@"%@-%@-%@ 00:00:00",strartArr[0],strartArr[1],strartArr[2]];
//                endTimeStr = [NSString stringWithFormat:@"%@-%@-%@ 00:00:00",endArra[0],endArra[1],endArra[2]];
                startTimeStr = self.hire_start;
                endTimeStr = self.hire_end;
                
            }
        }
    }

    PaymentViewController *payController = [[PaymentViewController alloc]init];
    payController.priceNum = [NSNumber numberWithFloat:[self.price floatValue]];
    payController.mode = self.mode;
    payController.hire_methold_id = self.hire_method_id;
    payController.extra_flag = dictionary[@"day"];
    payController.park_id = self.park_id;
    payController.start_time = startTimeStr;
    payController.end_time = endTimeStr;
    payController.hirer_id = dictionary[@"hirer_id"];
    payController.pay_types = self.pay_type;
    payController.trade_id = self.trade_id;
    payController.pay_tool = self.pay_tool;
    payController.device_token = dictionary[@"token"];
    payController.device_type = dictionary[@"type"];
    payController.mobile = dictionary[@"mobile"];
    payController.unit_price = dictionary[@"unitPrice"];
    payController.curb_rate = dictionary[@"curb_rate"];
    payController.hire_field = dictionary[@"hire_field"];

    
    [self presentViewController:payController animated:YES completion:nil];
    
}

-(void)layoutUI{
    UIView *view = [[UIView alloc]init];
    if (frameX == 320.0) {
        view.frame = CGRectMake(64,24,192,27);
    }else if (frameX == 375.0){
        view.frame = CGRectMake(76,24,228,32.4);
    }else if (frameX == 414.0){
        view.frame = CGRectMake(82.5,24,245.3,32.4);
    }
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 12.0;
    view.layer.borderColor = RGB(255, 255, 255).CGColor;
    view.layer.borderWidth = 2;
    [self.view addSubview:view];
    
    //导航
    if (frameX == 320.0) {
        _navBtn = [ UIButton buttonWithFrame:CGRectMake(frameX -80,15,75,40) type:UIButtonTypeCustom title:nil target:self action:@selector(navBtnClick:)];
    }else if (frameX == 375.0 || frameX == 414.0){
        _navBtn = [ UIButton buttonWithFrame:CGRectMake(frameX -125,17,115,40) type:UIButtonTypeCustom title:nil target:self action:@selector(navBtnClick:)];
    }
    [_navBtn setBackgroundImage:[UIImage imageNamed:@"icon_pressed_dh"] forState:UIControlStateNormal];
    [self.view addSubview:_navBtn];
    
    
    DVSwitch *switc = [[DVSwitch alloc]initWithStringsArray:@[@"详情",@"评论"]];
    if (frameX == 320.0) {
        switc.frame = CGRectMake(65, 25,190,25);
    }else if (frameX == 375.0){
        switc.frame = CGRectMake(77.5,25,225,30.4);
    }else if (frameX == 414.0){
        switc.frame = CGRectMake(83.5,25,243.3,30.4);
    }
    switc.backgroundColor = [UIColor colorWithRed:254/255.0 green:156/255.0 blue:0 alpha:1.0];
    [switc setPressedHandler:^(NSUInteger index) {
        if (index == 0) {
            //导航
            if (frameX == 320.0) {
                _navBtn = [ UIButton buttonWithFrame:CGRectMake(frameX -80,15,75,40) type:UIButtonTypeCustom title:nil target:self action:@selector(navBtnClick:)];
            }else if (frameX == 375.0 || frameX == 414.0){
                _navBtn = [ UIButton buttonWithFrame:CGRectMake(frameX -85,17,75,40) type:UIButtonTypeCustom title:nil target:self action:@selector(navBtnClick:)];
            }
            [_navBtn setBackgroundImage:[UIImage imageNamed:@"icon_pressed_dh"] forState:UIControlStateNormal];
            [self.view addSubview:_navBtn];
            [self.view bringSubviewToFront:_tableView];
            self.tabBarController.tabBar.hidden = NO;
        }else{
            
            [_navBtn removeFromSuperview];
            [self.view bringSubviewToFront:_commentTableView];
            self.tabBarController.tabBar.hidden = YES;
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, frameY - 40, frameX, 40)];
            view.backgroundColor = RGB(247, 247, 247);
            [self.view addSubview:view];
            
            _textField = [[UITextField alloc]init];
            if (frameX == 320.0) {
                _textField.frame = CGRectMake(20, 5, frameX - 40, 30);
            }else if (frameX == 375.0){
                _textField.frame = CGRectMake(20, 2, frameX - 40, 36);
            }else if (frameX == 414.0){
                _textField.frame = CGRectMake(20, 2, frameX-40, 36);
            }
            _textField.delegate = self;
            _textField.placeholder = @"写评论......";
            _textField.borderStyle = UITextBorderStyleRoundedRect;
            [view addSubview:_textField];
        }
    }];
    [self.view addSubview:switc];
    
    UIButton *button = [UIButton buttonWithFrame:CGRectMake(15,15,75,45) type:UIButtonTypeCustom title:nil target:self action:@selector(leftItem)];
    [button setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    [self.view addSubview:button];

}

- (void)leftItem{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//初始化UItableView
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, frameX, frameY - 64 ) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_naView.frame), frameX, frameY - 64) style:UITableViewStylePlain];
    _commentTableView.dataSource = self;
    _commentTableView.delegate = self;
    [self.view addSubview:_commentTableView];
    [self.view addSubview:_tableView];
    
    self.commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self downloadCommentData];
    }];
    [self.commentTableView.mj_header beginRefreshing];
    
    self.commentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footerDownloadCommentData];
    }];
    
    //评论头视图
    UIView *view = [[UIView alloc]init];
    if (frameX == 320.0) {
        view.frame = CGRectMake(0,0, frameX, 33);
    }else if (frameX == 375.0){
        view.frame = CGRectMake(0,0, frameX, 40);
    }else if (frameX == 414.0){
        view.frame = CGRectMake(0,0, frameX, 43);
    }
    _commentTableView.tableHeaderView = view;
    
    //评论尾视图
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 100)];
    _commentTableView.tableFooterView = footerView;
    
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
//下载道路数据
- (void)downLoad{
  
    NSDictionary *dictionary = @{@"park_id":self.park_id,@"mode":self.mode};
    
    //NSLog(@"%@",dictionary);
    
    _dataArray = [NSMutableArray array];
    
    _request = [[KongCVHttpRequest alloc]initWithRequests:kDetailInfoUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {
        
        NSDictionary *dic = data[@"result"];
        
        if (dic) {
            _modelss = [DetailInfoModel modelWithDic:dic];
            [_dataArray addObject:_modelss];
            [self.tableView reloadData];
            [self performSelectorOnMainThread:@selector(getLaAndLo) withObject:nil waitUntilDone:YES];
        }
        
    }];
    
}

- (void)getLaAndLo{
    DetailInfoModel *model = [_dataArray firstObject];
    _endPoint = [AMapNaviPoint locationWithLatitude:[model.location[@"latitude"] floatValue] longitude:[model.location[@"longitude"]floatValue]];
    _strartPoint = [AMapNaviPoint locationWithLatitude:[[StringChangeJson getValueForKey:@"la"] floatValue] longitude:[[StringChangeJson getValueForKey:@"lo"] floatValue]];
}
//下载评论数据
- (void)downloadCommentData{
    
    _skip = 0;
    
    _skipNum = [NSNumber numberWithInt:_skip];
    
    NSDictionary *dic = @{@"park_id" : self.park_id, @"skip":_skipNum, @"limit":@10, @"mode" :self.mode};
    
    _commentRequest = [[KongCVHttpRequest alloc]initWithRequests:kCommentUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
        
        [_commentCellArray removeAllObjects];
        
        [_commentArray removeAllObjects];
        
        for (NSDictionary *dic in data[@"result"]) {
            
            CommentModel *model = [CommentModel modelWithDictionary:dic];
            [_commentArray addObject:model];
            
            CommentTableViewCell *cell = [[CommentTableViewCell alloc]init];
            [_commentCellArray addObject:cell];
            
        }
        
        [self.commentTableView reloadData];
        
        [self.commentTableView.mj_footer endRefreshing];
        
        [self.commentTableView.mj_header endRefreshing];
        
    }];
    
}

- (void)footerDownloadCommentData{
    
//    //初始化数据数组
//    _commentArray = [NSMutableArray array];
//    
//    //初始化cell数组
//    _commentCellArray   = [NSMutableArray array];
    
    _skip += 10;
    
    _skipNum = [NSNumber numberWithInt:_skip];
    
    NSDictionary *dic = @{@"user_id" :[StringChangeJson getValueForKey:kUser_id], @"park_id" : self.park_id, @"skip":_skipNum, @"limit":@10, @"mode" :self.mode};
    
    _commentRequest = [[KongCVHttpRequest alloc]initWithRequests:kCommentUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
        
        [_commentArray removeAllObjects];
        
        [_commentCellArray removeAllObjects];
        
        for (NSDictionary *dic in data[@"result"]) {
            
            CommentModel *model = [CommentModel modelWithDictionary:dic];
            
            [_commentArray addObject:model];
            
            CommentTableViewCell *cell = [[CommentTableViewCell alloc]init];
            
            [_commentCellArray addObject:cell];
            
        }
        [self.commentTableView reloadData];
        
        [self.commentTableView.mj_header endRefreshing];
        
        [self.commentTableView.mj_footer endRefreshing];
        
    }];
    
}

#pragma mark ---- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count;
    
    if ([tableView isEqual:_tableView]) {
        count = _dataArray.count;
    }else if ([tableView isEqual:_commentTableView]){
        count = _commentArray.count;
    }
    return count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_tableView]) {
        static NSString *Ident = @"ident";
        RouteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Ident];
        if (!cell) {
            cell = [[RouteTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Ident];
            cell.push_type = self.push_type;
            cell.park_id   =  self.park_id;
            cell.mode = self.mode;
            cell.hire_method_id = self.hire_method_id;
            cell.hire_start = self.hire_start;
            cell.hire_end = self.hire_end;
            cell.price = self.price;
            cell.hire_fields =self.hire_field;
        }
        DetailInfoModel *model = _dataArray[indexPath.row];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    static NSString *Ident = @"commentIdent";
    CommentTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:Ident];
    if (!cells) {
        cells = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Ident];
    }
    
    CommentModel *model = _commentArray[indexPath.row];
    cells.model = model;
    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cells;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat length;
    if ([tableView isEqual:_tableView]) {
        if (frameX == 320.0) {
            length = 780;
        }else if(frameX == 375.0){
            length = 800;
        }else{
            length = 880;
        }
    }else if ([tableView isEqual:_commentTableView]){
        
        CommentTableViewCell *cell = _commentCellArray[indexPath.row];
        cell.model = _commentArray[indexPath.row];
        length = cell.cellHeight+16.6;
        
    }
    return length;
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

//导航
- (void)navBtnClick:(UIButton *)btn{
    NSArray *startPoints = @[_strartPoint];
    NSArray *endPoints = @[_endPoint];
    [self.naviManger calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints:nil drivingStrategy:0];
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

@end
