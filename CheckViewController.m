//
//  CheckViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/15.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "CheckViewController.h"

#import "ZHPickView.h"

#import "CheckModel.h"

#import "CheckTableViewCell.h"

#import "CurbModel.h"

@interface CheckViewController ()<UITableViewDataSource,UITableViewDelegate,ZHPickViewDelegate>

@property (nonatomic,strong) UIButton *hireBtn;

@property (nonatomic,strong) UIButton *letBtn;

@property (nonatomic,strong) KongCVHttpRequest *hireRequest;

@property (nonatomic,strong) KongCVHttpRequest *letRequest;

@property (nonatomic,strong) UITableView *hireTableView;

@property (nonatomic,strong) UITableView *letTableView;

@property (nonatomic,strong) NSMutableArray *hireArray;

@property (nonatomic,strong) NSMutableArray *letArray;

@property (nonatomic,strong) ZHPickView *datePicker;

@property (nonatomic,strong) UIButton *monthBtn;

@property (nonatomic,strong) UILabel *yearLabel;

@property (nonatomic,strong) NSString *query_month;


@property (nonatomic,strong) NSNumber *skipNum;
@property (nonatomic,assign) int skip;

//判断是租用还是出租
@property (nonatomic,copy)   NSString *isLetOrhire;
//判断是社区还是道路
@property (nonatomic,copy)   NSString *isCommOrCurb;
//时间
@property (nonatomic,strong) NSArray *timeArray;
//分段控制器
@property (nonatomic,strong) UISegmentedControl *segmentControl;

@end

@implementation CheckViewController

-(NSMutableArray *)letArray{

    if (_letArray == nil) {
        
        _letArray = [NSMutableArray array];
        
    }
    
    return _letArray;
}

-(NSMutableArray *)hireArray{

    if (_hireArray == nil) {
        
        _hireArray = [NSMutableArray array];
        
    }
    
    return _hireArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = YES;

    [self getNowDayTime];
    
    _skip = 0;
    
    _skipNum = [NSNumber numberWithInt:_skip];
    
    _isCommOrCurb = @"curb";
    
    _isLetOrhire = @"customer";
    
    [self layoutUI];
    
}

//获取当前年月日
- (void)getNowDayTime{
    
    NSDate *date = [NSDate date];
    
    NSString *string = [NSString stringWithFormat:@"%@",date];
    
    NSArray *array = [string componentsSeparatedByString:@" "];
    
    self.timeArray = [[array firstObject] componentsSeparatedByString:@"-"];
    
    self.yearLabel.text = [self.timeArray firstObject];
    
    [self.monthBtn setTitle:[self.timeArray objectAtIndex:1] forState:UIControlStateNormal];
    

}

- (void)layoutUI{
    
    //背景图
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 171*frameY/480.0)];
    view.backgroundColor = RGB(247, 157, 0);
    [self.view addSubview:view];
    
    //账单
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(frameX/2 -15, 20, 100, 40) text:@"账单" Color:nil Font:UIFont(19)];
    [view addSubview:titleLabel];
    

    //返回按钮
    UIButton *backBtn = [UIButton buttonWithFrame:CGRectMake(5, 8,85,75) font:nil bgColor:nil textColor:nil title:nil bgImage:[UIImage imageNamed:@"fh"]  target:self action:@selector(backBtnClick:)];
    [view addSubview:backBtn];
    

    //日期
    self.yearLabel = [UILabel labelWithFrame:CGRectMake(23,85,80,25) text:[self.timeArray firstObject] Color:RGB(247, 157, 0) Font:nil];
    self.yearLabel.textColor = RGB(146, 102, 0);
    self.yearLabel.font = [UIFont systemFontOfSize:22];
    [view addSubview:self.yearLabel];
    
    //月
    self.monthBtn = [UIButton buttonWithFrame:CGRectMake(13*frameX/320.0, CGRectGetMaxY(self.yearLabel.frame)+10,50, 30) font:UIFont(35) bgColor:nil textColor:nil title:[NSString stringWithFormat:@"%@",self.timeArray[1]] bgImage:nil target:self action:@selector(monthBtnClick:)];
    
    self.monthBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [view addSubview:self.monthBtn];
    
    //月份
    UILabel *monthLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(self.monthBtn.frame)+3,CGRectGetMaxY(self.yearLabel.frame)+16,27,22) text:@"月" Color:nil Font:UIFont(17)];
    monthLabel.textColor = [UIColor whiteColor];
    [view addSubview:monthLabel];
    
    //分割线
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(CGRectGetMaxX(self.yearLabel.frame),90, 5,60);
    if (frameX == 414.0) {
         imageView.frame = CGRectMake(CGRectGetMaxX(self.yearLabel.frame)+10,85, 5,60);
    }
    imageView.image = [UIImage imageNamed:@"icon_yuan"];
    [view addSubview:imageView];
    
    //租用
    _hireBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _hireBtn.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+18,100,75,35);
    [_hireBtn setTitle:@"租用" forState:UIControlStateNormal];
    [_hireBtn addTarget:self action:@selector(hireBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (frameX == 375.0) {
        _hireBtn.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+28,100,85,35);
        _hireBtn.titleLabel.font = UIFont(24);
        _hireBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -105);
    }else if (frameX == 414.0){
        _hireBtn.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+35,100,100,40);
        _hireBtn.titleLabel.font = UIFont(30);
        _hireBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -105);
        _hireBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        _hireBtn.titleLabel.font = [UIFont systemFontOfSize:21];
    }
    [_hireBtn setImage:[UIImage imageNamed:@"icon_youjiantou"] forState:UIControlStateNormal];
    [_hireBtn setImage:[UIImage imageNamed:@"icon_xiajiantou"] forState:UIControlStateSelected];
    _hireBtn.selected = NO;
    [_hireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _hireBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
    _hireBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,3, -95);
    _hireBtn.titleLabel.font = UIFont(21);
    _hireBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [view addSubview:_hireBtn];
    
    //出租
    _letBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _letBtn.frame = CGRectMake(CGRectGetMaxX(_hireBtn.frame)+18,100,75,35);
    [_letBtn setTitle:@"出租" forState:UIControlStateNormal];
    [_letBtn addTarget:self action:@selector(letBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (frameX == 375.0) {
        _letBtn.frame = CGRectMake(CGRectGetMaxX(_hireBtn.frame)+28,100,85,35);
        _letBtn.titleLabel.font = UIFont(24);
        _letBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -105);
    }else if (frameX == 414.0){
        _letBtn.frame = CGRectMake(CGRectGetMaxX(_hireBtn.frame)+35,100,100,40);
        _letBtn.titleLabel.font = UIFont(30);
        _letBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -105);
        _letBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        _letBtn.titleLabel.font = [UIFont systemFontOfSize:21];
    }
    _letBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
    [_letBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_letBtn setImage:[UIImage imageNamed:@"icon_xiajiantou"] forState:UIControlStateNormal];
    [_letBtn setImage:[UIImage imageNamed:@"icon_youjiantou"] forState:UIControlStateSelected];
    _letBtn.selected = NO;
    _letBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -95);
    _letBtn.titleLabel.font = UIFont(21);
    _letBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [view addSubview:_letBtn];
    
    //租用tableView
    _hireTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)+10, frameX, frameY - CGRectGetMaxY(view.frame)-50) style:UITableViewStylePlain];
    
    _hireTableView.dataSource = self;
    
    _hireTableView.delegate = self;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, frameX, 40)];
    
    _hireTableView.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, frameX, 40)];
    
    _hireTableView.tableFooterView   = footerView;

    //下拉刷新
    self.hireTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        _skip = 0;
        
        _skipNum = [NSNumber numberWithInt:_skip];
        
          if ([_isCommOrCurb isEqualToString:@"curb"]) {
              
              [self downloadHireData:@"customer" andMode:@"curb"];
              
          }else if ([_isCommOrCurb isEqualToString:@"community"]){

              [self downloadHireData:@"customer" andMode:@"community"];
 
          }
          
    }];
    [self.hireTableView.mj_header beginRefreshing];

    
    //上拉加载
    self.hireTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    if ([_isCommOrCurb isEqualToString:@"curb"]) {
        
        _skip += 10;
    
        _skipNum = [NSNumber numberWithInt:_skip];
        
        [self downloadHireData:@"customer" andMode:@"curb"];
        
    }else if ([_isCommOrCurb isEqualToString:@"community"]){
        
        _skip += 10;
        
        _skipNum = [NSNumber numberWithInt:_skip];
        
        [self downloadHireData:@"customer" andMode:@"community"];
       
    }
    
}];

    
    NSArray *array = @[@"商业",@"个人"];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:array];
    _segmentControl = segmentControl;
    segmentControl.frame = CGRectMake(34*frameX/320.0, 0,252*frameX/320.0,24*frameY/480.0);
    segmentControl.tintColor = RGB(255, 156, 0);
    [segmentControl addTarget:self action:@selector(hireSegmentControlClick:) forControlEvents:UIControlEventValueChanged];
    segmentControl.selectedSegmentIndex = 0;
    [headerView addSubview:segmentControl];
    
    //出租tableView
    _letTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)+10, frameX, frameY - CGRectGetMaxY(view.frame)-50) style:UITableViewStylePlain];
    _letTableView.dataSource = self;
    _letTableView.delegate = self;
    _letTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_letTableView];
    
    
    [self.view addSubview:_hireTableView];

}

- (void)backBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    [_datePicker remove];
}


- (void)hireSegmentControlClick:(UISegmentedControl *)segmentControl{

    switch (segmentControl.selectedSegmentIndex) {
        case 0:
        {
            _isLetOrhire = @"customer";
            _isCommOrCurb = @"curb";
            [self downloadHireData:@"customer" andMode:@"curb"];
        }
            break;
        case 1:
        {
            _isLetOrhire = @"customer";
            _isCommOrCurb = @"community";
            [self downloadHireData:@"customer" andMode:@"community"];
        }
            break;
            
        default:
            break;
    }
}

//选择日期
- (void)monthBtnClick:(UIButton *)btn{
    //NSDate *date = [NSDate dateWithTimeIntervalSinceNow:9000000];
    
    NSMutableArray *yearArray = [NSMutableArray array];
    
    for (int i = 1990; i<2200; i++) {
        
        NSString *string = [NSString stringWithFormat:@"%d",i];
        
        [yearArray addObject:string];
        
    }
    
    NSMutableArray *monthArray = [NSMutableArray array];
    
    for (int i = 1; i<=12; i++) {
        
        NSString *string = [NSString stringWithFormat:@"%d",i];
        
        [monthArray addObject:string];
    }
    
    NSArray *array = @[[NSArray arrayWithArray:yearArray], [NSArray arrayWithArray:monthArray]];
    
    _datePicker = [[ZHPickView alloc]initPickviewWithArray:array isHaveNavControler:NO];
    
    _datePicker.delegate = self;
    
    [_datePicker show];
    
}

#pragma mark --- ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    _yearLabel.text = [resultString substringToIndex:4];
    
    [_monthBtn setTitle:[resultString substringFromIndex:4] forState:UIControlStateNormal];
    
}

//租用
- (void)hireBtnClick:(UIButton *)btn{
    
    btn.selected  = !btn.selected;
    
    _letBtn.selected = !_letBtn.selected;
    
    _isLetOrhire = @"customer";
    
    _isCommOrCurb = @"curb";
    
    [self downloadHireData:_isLetOrhire andMode:_isCommOrCurb];
    
    _segmentControl.selectedSegmentIndex = 0;
    
    [self.view bringSubviewToFront:_hireTableView];
    
}
//租用数据下载
- (void)downloadHireData:(NSString *)string andMode:(NSString *)mode{
    
    self.query_month = [NSString stringWithFormat:@"%@-%@-01 00:00:00",_yearLabel.text,_monthBtn.titleLabel.text];
    
    
    if ([StringChangeJson getValueForKey:kUser_id]) {
    
        NSNumber *num = [NSNumber numberWithInt:0];

        NSDictionary *dic = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"query_month":_query_month,@"pay_state":num,@"limit":@10,@"mode":mode,@"skip":_skipNum,@"role": string};

        
        _hireRequest = [[KongCVHttpRequest alloc]initWithRequests:kGetListUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
            
            [self.hireArray removeAllObjects];
            
            NSArray *array = data[@"result"];

            if ([mode isEqualToString:@"community"]) {
                    
                for (NSDictionary *dictionary in array) {
                        
                    CheckModel *model = [CheckModel modelWithDic:dictionary];
                        
                    [self.hireArray addObject:model];
                        
                }
                    
            }else if ([mode isEqualToString:@"curb"]){
                    
                for (NSDictionary *dictionary in array) {
                        
                    CurbModel *model = [CurbModel modelWithDic:dictionary];
                        
                    [self.hireArray addObject:model];
                        
                }

            }
        
            [self.hireTableView reloadData];
            
            [self.hireTableView.mj_header endRefreshing];
            
            [self.hireTableView.mj_footer endRefreshing];
            
        }];

    }
}


//*****************************/出租/***********/
- (void)letBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    _hireBtn.selected = !_hireBtn.selected;
    
    //头视图
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 5, frameX, 40)];
    
    _letTableView.tableHeaderView = view;
    
    //分段控制器
    NSArray *array = @[@"商业",@"个人"];
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:array];
    
    segmentControl.frame = CGRectMake(34*frameX/320.0, 0,252*frameX/320.0,24*frameY/480.0);
    
    segmentControl.tintColor = RGB(255, 156, 0);
    
    [segmentControl addTarget:self action:@selector(segmentControlClick:) forControlEvents:UIControlEventValueChanged];
    
    segmentControl.selectedSegmentIndex = 0;
    
    [view addSubview:segmentControl];
    
    _isCommOrCurb = @"curb";
    
    _isLetOrhire = @"hirer";
    
    [self downloadLetData:@"hirer" andMode:@"curb"];
    
    [self.view bringSubviewToFront:_letTableView];
    
    
    //下拉刷新
     self.letTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         
         _skip = 0;
         
         _skipNum = [NSNumber numberWithInt:_skip];
         
            if ([_isCommOrCurb isEqualToString:@"curb"]) {

                [self downloadLetData:@"hirer" andMode:@"curb"];
                
            }else if ([_isCommOrCurb isEqualToString:@"community"]){

                [self downloadLetData:@"hirer" andMode:@"community"];
            }
      }];
 
    //上拉加载
    self.letTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _skip += 10;
        
        _skipNum = [NSNumber numberWithInt:_skip];
        
        if ([_isCommOrCurb isEqualToString:@"curb"]) {

            [self downloadLetData:@"hirer" andMode:@"curb"];
            
        }else if ([_isCommOrCurb isEqualToString:@"community"]){

            [self downloadLetData:@"hirer" andMode:@"community"];
            
        }
        
    }];
}


- (void)segmentControlClick:(UISegmentedControl *)segmentControl{

    switch (segmentControl.selectedSegmentIndex) {
        case 0:
        {
            _isCommOrCurb = @"curb";
            
            _isLetOrhire = @"hirer";
            
            [self downloadLetData:@"hirer" andMode:@"curb"];
            
        }
            break;
        case 1:
        {
            _isCommOrCurb = @"community";
            
            _isLetOrhire = @"hirer";
            
            [self downloadLetData:@"hirer" andMode:@"community"];
            
        }
            break;
            
        default:
            break;
    }
}

//出租数据下载
- (void)downloadLetData:(NSString *)string andMode:(NSString *)mode{
    
    _query_month = [NSString stringWithFormat:@"%@-%@-01",_yearLabel.text,_monthBtn.titleLabel.text];

    if ([StringChangeJson getValueForKey:kUser_id]) {
        
        NSDictionary *dictionary = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"query_month":_query_month,@"pay_state":@0,@"limit":@10,@"mode":mode,@"skip":_skipNum, @"role":string};

        
        _letRequest = [[KongCVHttpRequest alloc]initWithRequests:kGetListUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {
    
            NSArray *array = data[@"result"];
            
            [self.letArray removeAllObjects];
                
            for (NSDictionary *dic in array) {
                    
                CheckModel *model = [CheckModel modelWithDic:dic];
                    
                [self.letArray addObject:model];
                    
                }
            
            [self.letTableView reloadData];

            [self.letTableView.mj_header endRefreshing];
            
            [self.letTableView.mj_footer endRefreshing];
            
        }];

            [self.view bringSubviewToFront:_letTableView];
    }
}

#pragma mark --- <UITableViewDataSource,UITableViewDelegate>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSInteger Num;
    
    if ([tableView isEqual:_hireTableView]) {
        
        Num = self.hireArray.count;
        
    }else if ([tableView isEqual:_letTableView]){
        
        Num = self.letArray.count;
        
    }
    return Num;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:_hireTableView]) {
        
        static NSString *ident = @"cell";
        
        CheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
        
        if (cell == nil) {
            
            cell = [[CheckTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
            
        }

        CheckModel *model    =  self.hireArray[indexPath.row];
//        CurbModel    *models   =  _hireArray[indexPath.row];
//        if (model.park_community) {
            cell.model = model;
//        }else{
//            cell.curbModel = models;
//        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return cell;
        
    }else{
    
        static NSString *idents = @"cells";

        CheckTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:idents];
        
        if (cells == nil) {
            
            cells = [[CheckTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idents];
            
        }

        CheckModel *model = self.letArray[indexPath.row];
        
        cells.model = model;
        
        cells.selectionStyle = UITableViewCellSelectionStyleNone;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return cells;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 55*frameY/480;
}

@end
