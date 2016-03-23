//
//  KongCVViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/10/14.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "KongCVViewController.h"

#import "PicturesModel.h"

#import "PicViewController.h"

#import "SearchViewController.h"

#import "UIImageView+WebCache.h"

#import "ZHXDataCache.h"

#import "AFNetworking.h"

#import "GDScrollBanner.h"

@interface KongCVViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) UIView *navView;

@property (nonatomic,strong) KongCVHttpRequest *request;

@property (nonatomic,strong) NSMutableArray *array;

@property (nonatomic,strong) NSMutableArray *parkTypeArray;

@property (nonatomic,strong) NSMutableArray *comArray;

@property (nonatomic,strong) NSMutableArray *routArray;

@property (nonatomic,strong) NSDictionary *dictionary;

@property (nonatomic,strong) PicturesModel *model;

@property (nonatomic,strong) PicturesModel *hireModel;

@property (nonatomic,copy)   NSString *method;                                //租用方式

@property (nonatomic,strong) NSString *type;                                       //租用类型

@property (nonatomic,strong) ZHXDataCache *dataCache;         //缓存

@property (nonatomic,strong) NSNumber *ruleStr;                              //规则

@property (nonatomic,strong) NSMutableArray *pictureArray;                         //录播图数组

@property (nonatomic,strong) GDScrollBanner *net;                                           //轮播图

@property (nonatomic,strong) UIScrollView    *bgPublicScrollView;                 //商业租用方式

@property (nonatomic,strong) UIScrollView    *bgPersonalScrollView;            //个人租用方式

@property (nonatomic,strong) UIImageView  *methodImage;                        //停车位

@property (nonatomic,strong) UIImageView  *publicImage;                           //公共停车位

@property (nonatomic,strong) UIImageView  *personalImage;                      //私人停车位

@property (nonatomic,strong) UIView               *bgPubView;

@property (nonatomic,strong) UIView               *bgPerView;

@property (nonatomic,strong) KongCVHttpRequest *perRequest;

@end

@implementation KongCVViewController

- (NSMutableArray *)array{
    if (_array == nil) {
        self.array = [NSMutableArray array];
    }
    return _array;
}


-(NSMutableArray *)parkTypeArray{
    
    if (_parkTypeArray == nil) {
        
        self.parkTypeArray = [NSMutableArray array];
        
    }
    
    return _parkTypeArray;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"OnePage"];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"OnePage"];
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(247, 247, 247);
    
    self.navigationController.navigationBarHidden = YES;
    
    //自定义导航条
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 64)];
    
    _navView.backgroundColor = RGB(255,156, 0);
    
    [self.view addSubview:_navView];
    
    //设置导航标题
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frameX/2.0 - 25, 25, 60, 30)];
    
    label.text = @"空车位";
    
    label.font = [UIFont boldSystemFontOfSize:18];
    
    [_navView addSubview:label];
    
    //初始化缓存
    _dataCache = [ZHXDataCache sharedCache];
    
    //初始化数组,盛装轮播图
    _pictureArray =  [NSMutableArray array];
    
    //网络监控
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //当网络状态发生变化时会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                [self downData];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                [self downData];
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
                [self downData];
                
                break;
            case AFNetworkReachabilityStatusUnknown:
                
                [self downData];
                
                break;
                
            default:
                
                break;
                
        }
        
    }];
    
    [manager startMonitoring];

}

-(void)downData{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_sync(queue, ^{
        
        [self childqqqThread];
        
    });
    
    dispatch_sync(queue, ^{
        [self downloadData];
    });
    
    
}

//轮播图片数据
- (void)childqqqThread{
    
    NSDictionary *dic = [_dataCache getDataWithStringName:@"Carouselfigure"];
    
    if (dic) {
        NSArray *array = dic[@"result"];
        
        [self.array removeAllObjects];
        
        for (NSDictionary *dic in array) {
            
            self.model = [PicturesModel addWithDic:dic];
            
            [self.array addObject:_model];
            
        }
        //在主线程更新UI
        [self performSelectorOnMainThread:@selector(createUI) withObject:nil waitUntilDone:YES];
        
    }else{
        self.request = [[KongCVHttpRequest alloc]initWithRequests:kPictureUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:nil andBlock:^(NSDictionary *data) {
            
            //缓存轮播图
            [_dataCache saveDataWithData:data andStringName:@"Carouselfigure"];
            
            NSArray *array = data[@"result"];
            
            [self.array removeAllObjects];
            
            for (NSDictionary *dic in array) {
                
                self.model = [PicturesModel addWithDic:dic];
                
                [self.array addObject:_model];
            }
            //在主线程更新UI
            [self performSelectorOnMainThread:@selector(createUI) withObject:nil waitUntilDone:YES];
        }];
    }
}

//创建UI网络轮播图
- (void)createUI{

    //获取图片链接
    [_pictureArray removeAllObjects];
    if (frameX == 320.0 && frameY == 480.0) {
        for (PicturesModel *url in _array) {
            [_pictureArray addObject:url.picture[@"url"]];
        }
    }else{
        for (PicturesModel *url in _array) {
            [_pictureArray addObject:url.picture2[@"url"]];
        }
    }

    //网络图片
    if (frameX == 320.0 && frameY == 480.0) {
        _net = [[GDScrollBanner alloc] initWithFrame:CGRectMake(0,64,frameX,180) WithNetImages:_pictureArray];
    }else if (frameX == 320.0 && frameY == 568.0){
        _net = [[GDScrollBanner alloc] initWithFrame:CGRectMake(0,64,frameX,235) WithNetImages:_pictureArray];
    }else{
        _net = [[GDScrollBanner alloc] initWithFrame:CGRectMake(0,64,frameX,310) WithNetImages:_pictureArray];
    }

    _net.AutoScrollDelay = 3;
    
    
    __block  NSArray *picArray = [NSArray arrayWithArray:_array];
    
    KongCVViewController * __weak weakSelf = self;
    
    //点击广告图片
    [_net setSmartImgdidSelectAtIndex:^(NSInteger index) {
        
        PicturesModel *model = picArray[index];
        
        if (model.picture_url.length != 0) {
            
            PicViewController *picViewController = [[PicViewController alloc]init];
            
            picViewController.urlString = model.picture_url;
            
            [weakSelf.navigationController pushViewController:picViewController animated: YES];
        }
        
    }];
    [self.view addSubview:_net];
}

//商业道路数据
- (void)downloadData{
    
    NSDictionary *dic = [self.dataCache getDataWithStringName:@"communityImage"];

    if (dic) {
     
        NSArray *array = dic[@"result"];
        
        for (NSDictionary *dictionary in array) {
            
            self.model = [PicturesModel addWithDic:dictionary];
            
            [self.parkTypeArray addObject:self.model];
            
        }
        
        [self performSelectorOnMainThread:@selector(parktypeUI) withObject:nil waitUntilDone:YES];
        
    }else{
        self.request = [[KongCVHttpRequest alloc]initWithRequests:kParkTypeUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:nil andBlock:^(NSDictionary *data) {
            
            //缓存道路图片
            [_dataCache saveDataWithData:data andStringName:@"communityImage"];
            
            NSArray *array = data[@"result"];

            for (NSDictionary *dictionary in array) {
                
                self.model = [PicturesModel addWithDic:dictionary];
                
                [self.parkTypeArray addObject:self.model];
                
            }
            
            [self performSelectorOnMainThread:@selector(parktypeUI) withObject:nil waitUntilDone:YES];
            
        }];
    }
}

//出租方式
- (void)parktypeUI{
    
    PicturesModel *ruleModel = _parkTypeArray[0];
    
    _ruleStr = ruleModel.rule;
    
    for (int i = 0; i<_parkTypeArray.count; i++) {
        
        PicturesModel *model = _parkTypeArray[i];
        
        NSString *string = model.picture_small[@"url"];
    
        _methodImage = [[UIImageView alloc]init];
        
        if (frameX == 320.0 && frameY == 480.0) {
            
            _methodImage.frame = CGRectMake(frameX/2.0 * i ,180+65,frameX/2.0,106/2.0);
            
        }else if (frameX == 320.0 && frameY == 568.0){
            
            _methodImage.frame = CGRectMake(frameX/2.0 * i ,235+65,frameX/2.0,106/2.0*frameY/568.0);
        
        }else{
 
            _methodImage.frame = CGRectMake(frameX/2.0 * i ,310+65 ,frameX/2.0,106/2.0*frameY/568.0);
        }
        
        [_methodImage sd_setImageWithURL:[NSURL URLWithString:string]];
    
        [self.view addSubview:_methodImage];
        
        //添加手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(methodTapClick:)];
        
        [_methodImage addGestureRecognizer:tapGesture];
        
        _methodImage.userInteractionEnabled = YES;
        
        _methodImage.tag = 100+i;
        
    }
   
    
    _comArray = [NSMutableArray array];
    
    PicturesModel *model = _parkTypeArray[0];
    
    _type = model.name;
    
    NSDictionary *dict= @{@"park_type_id":model.objectId};
    
    NSDictionary *dic = [self.dataCache getDataWithStringName:@"publish"];
    
    if (dic) {
        
        NSArray *array = dic[@"result"];
        
        [_comArray removeAllObjects];
        
        for (NSDictionary *dic in array) {
            
            self.model = [PicturesModel addWithDic:dic];
            
            [_comArray addObject:self.model];
            
        }
        
        [self performSelectorOnMainThread:@selector(firComClick) withObject:nil waitUntilDone:YES];
        
   }else{
       
        self.request = [[KongCVHttpRequest alloc]initWithRequests:kHireMethodUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dict andBlock:^(NSDictionary *data) {

            [_dataCache saveDataWithData:data andStringName:@"publish"];
            
            [_comArray removeAllObjects];
            
            NSArray *array = data[@"result"];
 
            for (NSDictionary *dic in array) {
                
                self.model = [PicturesModel addWithDic:dic];
                
                [_comArray addObject:self.model];
                
            }
            
            [self performSelectorOnMainThread:@selector(firComClick) withObject:nil waitUntilDone:YES];
        }];
       
      }

    
    PicturesModel *pModel = _parkTypeArray[1];
    
    NSDictionary *diction= @{@"park_type_id":pModel.objectId};
    
    self.perRequest = [[KongCVHttpRequest alloc]initWithRequests:kHireMethodUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:diction andBlock:^(NSDictionary *data) {
        
        [_dataCache saveDataWithData:data andStringName:@"public"];
 
    }];
    
  }

#pragma mark --- tapClick
- (void)methodTapClick:(UITapGestureRecognizer *)tap{
    
    switch (tap.view.tag - 100) {
        case 0:
        {
            //商业车位
            [self publicMethod:tap];
            
        }
            break;
        case 1:
        {
            //私人车位
            [self personalMethod:tap];
        }
            break;
            
        default:
            break;
    }
}

//商业车位加载
-(void)firComClick{
    
    //滑动
    _bgPublicScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_methodImage.frame),frameX,300)];
    
    _bgPublicScrollView.showsHorizontalScrollIndicator = NO;
    
    _bgPublicScrollView.showsVerticalScrollIndicator = NO;
    
    _bgPublicScrollView.bounces = YES;
    
    [self.view addSubview:_bgPublicScrollView];
    
    
    int totalloc = 4;
    
    CGFloat height = frameX/4;
    
    CGFloat weight = frameX/4;
    
    
    for (int i = 0; i<12; i++) {
        int row = i/totalloc;
        
        int loc  = i%totalloc;
        
        CGFloat viewX = (height+1) * loc;
        
        CGFloat viewY = (weight+1) * row;
        
        //背景
        _bgPubView = [[UIView alloc]init];
        
        _bgPubView.frame = CGRectMake(viewX, viewY, height, weight);
        
        _bgPubView.backgroundColor = [UIColor whiteColor];
        
        [_bgPublicScrollView addSubview:_bgPubView];
    }
    
    for (int i = 0; i<_comArray.count; i++) {
        
        PicturesModel *model = _comArray[i];
        
        NSString *urlStr = model.picture_curb[@"url"];
        
        int row = i/totalloc;
        
        int loc  = i%totalloc;
        
        CGFloat viewX = (height+1) * loc;
        
        CGFloat viewY = (weight+1) * row;
        
        //图片
        _publicImage = [[UIImageView alloc]init];
        
        _publicImage.frame = CGRectMake(viewX, viewY, height, weight);
        
        [_publicImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        
        [_bgPublicScrollView addSubview:_publicImage];
        
        //添加手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(publicTapClick:)];
        
        [_publicImage addGestureRecognizer:tapGesture];
        
        _publicImage.userInteractionEnabled = YES;
        
        _publicImage.tag = 100+i;

    }
    
    if (frameX == 320.0 && frameY == 480.0) {
        _bgPublicScrollView.contentSize = CGSizeMake(0,390);
    }else if (frameX == 320.0 && frameY == 568.0){
        _bgPublicScrollView.contentSize = CGSizeMake(0,380);
    }else{
        _bgPublicScrollView.contentSize = CGSizeMake(0,410);
    }
    
    
    
    
}

#pragma mark -- 商业车位出租方式
- (void)publicMethod:(UITapGestureRecognizer *)tap{
    
    [_bgPublicScrollView removeFromSuperview];
    
    [_bgPersonalScrollView removeFromSuperview];
  
    _routArray = [NSMutableArray array];
    
    PicturesModel *model = _parkTypeArray[tap.view.tag - 100];
    
    _type = model.name;
    
    _ruleStr = model.rule; //规则
    
    NSDictionary *dict= @{@"park_type_id":model.objectId};
    
    NSDictionary *dic = [self.dataCache getDataWithStringName:@"publish"];
    
    if (dic) {
        
        NSArray *array = dic[@"result"];
        
        [_comArray removeAllObjects];
        
        for (NSDictionary *dic in array) {
            
            self.model = [PicturesModel addWithDic:dic];
            
            [_comArray addObject:self.model];
            
        }
        
        [self performSelectorOnMainThread:@selector(firComClick) withObject:nil waitUntilDone:YES];
        
    }else{
        
        self.request = [[KongCVHttpRequest alloc]initWithRequests:kHireMethodUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dict andBlock:^(NSDictionary *data) {
            
            NSArray *array = data[@"result"];
            
            [_comArray removeAllObjects];
            
            for (NSDictionary *dic in array) {
                
                self.model = [PicturesModel addWithDic:dic];
                
                [_comArray addObject:self.model];
                
            }
            
            [self performSelectorOnMainThread:@selector(firComClick) withObject:nil waitUntilDone:YES];
            
        }];
    }
}

#pragma mark -- 个人车位出租方式
- (void)personalMethod:(UITapGestureRecognizer *)tap{
    
    _routArray = [NSMutableArray array];
    
    PicturesModel *model = _parkTypeArray[tap.view.tag - 100];
    
    _type = model.name;
    
    _ruleStr = model.rule; //规则
    
    NSDictionary *dict= @{@"park_type_id":model.objectId};
    
    NSDictionary *dic = [_dataCache getDataWithStringName:@"public"];
    
    if (dic) {
        
        NSArray *array = dic[@"result"];
        
        [_routArray removeAllObjects];
        
        for (NSDictionary *dic in array) {
            
            self.model = [PicturesModel addWithDic:dic];
            
            [_routArray addObject:self.model];
            
        }
        
        [self performSelectorOnMainThread:@selector(personalClick) withObject:nil waitUntilDone:YES];
        
    }else{
        
        self.request = [[KongCVHttpRequest alloc]initWithRequests:kHireMethodUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dict andBlock:^(NSDictionary *data) {
            
            
            [_dataCache saveDataWithData:data andStringName:@"public"];
            
            NSArray *array = data[@"result"];
            
            [_routArray removeAllObjects];
            
            for (NSDictionary *dic in array) {
                
                self.model = [PicturesModel addWithDic:dic];
                
                [_routArray addObject:self.model];
                
            }
            
            [self performSelectorOnMainThread:@selector(personalClick) withObject:nil waitUntilDone:YES];
            
        }];
    }
}


//私人出租方式
- (void)personalClick{
    
    [_bgPublicScrollView removeFromSuperview];
    
    [_bgPersonalScrollView removeFromSuperview];
    
    //滑动
    _bgPersonalScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_methodImage.frame),frameX,300)];
    
    _bgPersonalScrollView.showsHorizontalScrollIndicator = NO;
    
    _bgPersonalScrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_bgPersonalScrollView];
    
    int totalloc = 4;
    
    CGFloat height = frameX/4;
    
    CGFloat weight = frameX/4;
    
    for (int i = 0; i<12; i++) {
        int row = i/totalloc;
        
        int loc  = i%totalloc;
        
        CGFloat viewX = (height+1) * loc;
        
        CGFloat viewY = (weight +1)* row;
        
        //背景
        _bgPerView = [[UIView alloc]init];
        
        _bgPerView.frame = CGRectMake(viewX, viewY, height, weight);
        
        _bgPerView.backgroundColor = [UIColor whiteColor];
        
        [_bgPersonalScrollView addSubview:_bgPerView];
    }
    
    
    for (int i = 0; i<_routArray.count; i++) {
        
        PicturesModel *model = _routArray[i];
        
        NSString *urlStr = model.picture_community[@"url"];
        
        int row = i/totalloc;
        
        int loc  = i%totalloc;
        
        CGFloat viewX = (height+1) * loc;
        
        CGFloat viewY = (weight +1)* row;
        
        //图片
        _personalImage = [[UIImageView alloc]init];
        
        _personalImage.frame = CGRectMake(viewX, viewY, height, weight);
        
        [_personalImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        
        [_bgPersonalScrollView addSubview:_personalImage];
        
        //添加手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personalTapClick:)];
        
        [_personalImage addGestureRecognizer:tapGesture];
        
        _personalImage.userInteractionEnabled = YES;
        
        _personalImage.tag = 200+i;
        
    }
    
    if (frameX == 320.0 && frameY == 480.0) {
        _bgPersonalScrollView.contentSize = CGSizeMake(0,400);
    }else if (frameX == 320.0 && frameY == 568.0){
        _bgPersonalScrollView.contentSize = CGSizeMake(0,380);
    }else{
        _bgPersonalScrollView.contentSize = CGSizeMake(0,380);
    }
    
    
    

}

- (void)publicTapClick:(UITapGestureRecognizer *)tap{
    
    switch (tap.view.tag - 100) {
        case 0:
        {
            [self skipController:tap];
        }
            break;
        case 1:
        {

            [self skipController:tap];
        }
            break;
        case 2:
        {
            [self skipController:tap];
            
        }
            break;
        case 3:
        {
            
            [self skipController:tap];
            
        }
            break;
            
        case 4:
        {

            [self skipController:tap];
            
        }
            break;
        case 5:
        {

            [self skipController:tap];
            
        }
            break;
        case 6:
        {
            
            [self skipController:tap];
            
        }
            break;
        case 7:
        {
            
            [self skipController:tap];
            
        }
            break;
        case 8:
        {
            
            [self skipController:tap];
            
        }
            break;
        case 9:
        {
            
            [self skipController:tap];
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)personalTapClick:(UITapGestureRecognizer *)tap{

    switch (tap.view.tag - 200) {
        case 0:
        {
            [self skipRoute:tap];
        }
            break;
        case 1:
        {
            [self skipRoute:tap];
        }
            break;
        case 2:
        {
           [self skipRoute:tap];
        }
            break;
        case 3:
        {
           [self skipRoute:tap];
        }
            break;
            
        case 4:
        {
           [self skipRoute:tap];
        }
            break;
        case 5:
        {

          [self skipRoute:tap];
        
        }
            break;

        case 6:
        {

           [self skipRoute:tap];
            
        }
            break;
        case 7:
        {
            
            [self skipRoute:tap];
            
        }
            break;
        case 8:
        {
            
            [self skipRoute:tap];
            
        }
            break;
            
        default:
            break;
    }
}

//公共出租方式页面跳转
- (void)skipController:(UITapGestureRecognizer *)tap{
    
    SearchViewController *controller = [[SearchViewController alloc]init];
    
    PicturesModel *model = _comArray[tap.view.tag - 100];
    
    controller.mode = _type;
    
    controller.hire_method_id = model.objectId;
    
    controller.hire_field = model.field;
    
    controller.hire_type = model.hire_type;
    
    controller.ruleStr = _ruleStr;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

//私人出租方式页面跳转
- (void)skipRoute:(UITapGestureRecognizer *)tap{
    
    SearchViewController *controller = [[SearchViewController alloc]init];
    
    PicturesModel *model = _routArray[tap.view.tag - 200];
    
    controller.mode = _type;
    
    controller.hire_method_id = model.objectId;
    
    controller.hire_field = model.field;
    
    controller.hire_type = model.hire_type;
    
    controller.ruleStr = _ruleStr;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}


@end

