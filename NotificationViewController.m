//
//  NotificationViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/4.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "NotificationViewController.h"

#import "PaymentViewController.h"

#import "CommentViewController.h"

#import "DetailInfoModel.h"

#import "CommentModel.h"

#import "NotiTableViewCell.h"

#import "CommentTableViewCell.h"

#import "DVSwitch.h"

#import "QRadioButton.h"

#import "CalculateUnit.h"
#define kGap4s     8.9
#define kGap6       10.8
#define kGap6p    11.5
#define kWidth4s   32.6
#define kWidth6     39.3
#define kWidth6p  42.3
@interface NotificationViewController ()  <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIView *naView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *commentTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *commentDataArray;
@property (nonatomic,strong) NSMutableArray *commentCellArray;
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) KongCVHttpRequest *comRequest;
@property (nonatomic,strong) KongCVHttpRequest *JPushRequest;
@property (nonatomic,strong) KongCVHttpRequest *insertRequest;
@property (nonatomic,strong) KongCVHttpRequest *iphoneRequest;
@property (nonatomic,strong) DetailInfoModel *modelss;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) NSMutableArray *methodArray;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) QRadioButton *qradioButton;
@property (nonatomic,assign) int skip;
@property (nonatomic,strong) NSNumber *skipNum;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIButton *navBtn;

@property (nonatomic,strong) PaymentViewController *payController;
@end

@implementation NotificationViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payButtonClick:) name:@"payButtonClick" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadComment) name:@"comment" object:nil];
    
    [MobClick beginLogPageView:@"EightPage"];
}

- (void)reloadComment{
    
    [self downloadCommentData];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"EightPage"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = RGB(254, 254, 254);
    _naView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 64)];
    _naView.backgroundColor = RGB(254, 156, 0);
    [self.view addSubview:_naView];
    
    //初始化数据数组
    _commentDataArray = [NSMutableArray array];
    
    //初始化cell数组
    _commentCellArray   = [NSMutableArray array];
    
    _dataArray = [NSMutableArray array];
    
    _skip = 0;
    
    _skipNum = [NSNumber numberWithInt:_skip];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self downLoad];
    });
    dispatch_async(queue, ^{
        [self downloadCommentData];
    });
    
    //初始化UItableView
    [self initTableVIew];

    [self layoutUI];

}
//布局UI
- (void)layoutUI{

    UIView *view = [[UIView alloc]init];
    if (frameX == 320.0) {
        view.frame = CGRectMake(64,24,192,27);
        view.layer.cornerRadius = 12.0;
    }else if (frameX == 375.0){
        view.frame = CGRectMake(76,24,228,32.4);
        view.layer.cornerRadius = 17.0;
    }else if (frameX == 414.0){
        view.frame = CGRectMake(82.5,24,245.3,32.4);
        view.layer.cornerRadius = 17.0;
    }
    view.layer.masksToBounds = YES;
    
    view.layer.borderColor = RGB(255, 255, 255).CGColor;
    view.layer.borderWidth = 2;
    [self.view addSubview:view];
    
    DVSwitch *switc = [[DVSwitch alloc]initWithStringsArray:@[@"详情",@"评论"]];
    if (frameX == 320.0) {
        switc.frame = CGRectMake(65, 25,190,25);
    }else if (frameX == 375.0){
        switc.frame = CGRectMake(79,25,222,30.4);
    }else if (frameX == 414.0){
        switc.frame = CGRectMake(85.5,25,240,30.4);
    }
    switc.backgroundColor = [UIColor colorWithRed:254/255.0 green:156/255.0 blue:0 alpha:1.0];
    [switc setPressedHandler:^(NSUInteger index) {
        if (index == 0) {
//            //导航
//            if (frameX == 320.0) {
//                _navBtn = [ UIButton buttonWithFrame:CGRectMake(frameX -80,15,75,40) type:UIButtonTypeCustom title:nil target:self action:@selector(navBtnClick:)];
//            }else if (frameX == 375.0){
//                _navBtn = [ UIButton buttonWithFrame:CGRectMake(frameX -85,17,75,40) type:UIButtonTypeCustom title:nil target:self action:@selector(navBtnClick:)];
//            }else if (frameX == 414.0){
//               _navBtn = [ UIButton buttonWithFrame:CGRectMake(frameX -95,17,75,40) type:UIButtonTypeCustom title:nil target:self action:@selector(navBtnClick:)];
//            }
//            [_navBtn setBackgroundImage:[UIImage imageNamed:@"icon_pressed_dh"] forState:UIControlStateNormal];
//            [self.view addSubview:_navBtn];
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
    
    UIButton *button;
    if (frameX == 414.0 || frameX == 375.0) {
        button = [UIButton buttonWithFrame:CGRectMake(15,18,75,45) type:UIButtonTypeCustom title:nil target:self action:@selector(leftItem)];
    }else{
        button = [UIButton buttonWithFrame:CGRectMake(15,15,75,45) type:UIButtonTypeCustom title:nil target:self action:@selector(leftItem)];
    }
    [button setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)leftItem{
    
    self.navigationController.navigationBar.hidden = NO;
    
    if (self.pushMessage) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"message" object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)downLoad{
    
    NSDictionary *dictionary = @{@"park_id":self.park_id,@"mode":@"community"};

    _request = [[KongCVHttpRequest alloc]initWithRequests:kDetailInfoUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {
        
        [_dataArray removeAllObjects];
        
        NSDictionary *dic = data[@"result"];
        
        if (dic) {
            
            _modelss = [DetailInfoModel modelWithDic:dic];
            
            [_dataArray addObject:_modelss];
            
            [self.tableView reloadData];
            
        }

    }];

}


- (void)downloadCommentData{
    
    NSDictionary *dic = @{@"park_id" : self.park_id, @"skip":_skipNum, @"limit":@10, @"mode" :self.mode};
    
    _comRequest = [[KongCVHttpRequest alloc]initWithRequests:kCommentUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
        
        [self.commentCellArray removeAllObjects];
        
        [self.commentDataArray removeAllObjects];
        
        NSArray *array = data[@"result"];
        
        if (array.count != 0) {
            
            for (NSDictionary *dic in data[@"result"]) {
                
                CommentModel *model = [CommentModel modelWithDictionary:dic];
                
                [_commentDataArray addObject:model];
                
                CommentTableViewCell *cell = [[CommentTableViewCell alloc]init];
                
                [_commentCellArray addObject:cell];
                
            }
            
            [self.commentTableView reloadData];
            
        }

        [self.commentTableView.mj_footer endRefreshing];
        
        [self.commentTableView.mj_header endRefreshing];
        
    }];
    
}


//初始化UItableView
- (void)initTableVIew{

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, frameX, frameY - 64 ) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_naView.frame), frameX, frameY - 64) style:UITableViewStylePlain];
    _commentTableView.dataSource = self;
    _commentTableView.delegate = self;
    [self.view addSubview:_commentTableView];
    [self.view addSubview:_tableView];

    self.commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _skip = 0;
        
        _skipNum = [NSNumber numberWithInt:_skip];
        
        [self downloadCommentData];
        
    }];
    
    
    self.commentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _skip += 10;
        
        _skipNum = [NSNumber numberWithInt:_skip];
        
       [self downloadCommentData];
        
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

#pragma mark ---- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSInteger count;
    
    if ([tableView isEqual:_tableView]) {
        count = _dataArray.count;
    }else if ([tableView isEqual:_commentTableView]){
        count = _commentDataArray.count;
    }
    return count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:_tableView]) {
        static NSString *Ident = @"ident";
        NotiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Ident];
        if (!cell) {
            cell = [[NotiTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Ident];
            cell.push_type = self.push_type;
            cell.park_id   =  self.park_id;
            cell.mode = self.mode;
            cell.hire_method_id = self.hire_method_id;
            cell.own_mobile = self.own_mobile;
            cell.device_type = self.device_type;
            cell.device_token = self.device_token;
            cell.pushMessage = self.pushMessage;
            cell.message_id = self.message_id;
            cell.price = self.price;
            cell.hire_start = self.hire_start;
            cell.hire_end = self.hire_end;
            cell.park_space = self.park_space;
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
    
    CommentModel *model = _commentDataArray[indexPath.row];
    cells.model = model;
    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cells;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat length;
    if ([tableView isEqual:_tableView]) {
        if (frameX == 320.0) {
            length = 920;
        }else if(frameX == 375.0){
            length = 1000;
        }else{
            length = 1100;
        }
    }else if ([tableView isEqual:_commentTableView]){
        
        CommentTableViewCell *cell = _commentCellArray[indexPath.row];
        cell.model = _commentDataArray[indexPath.row];
        length = cell.cellHeight+16.6;
        
    }
    return length;
}

//支付
- (void)payButtonClick:(NSNotification *)info{
    
    NSDictionary *dic = info.userInfo;
    _payController = [[PaymentViewController alloc]init];
    _payController.hire_methold_id = self.hire_method_id;
    _payController.park_id = self.park_id;
    _payController.mode = self.mode;
    _payController.priceNum = [NSNumber numberWithFloat:[dic[@"price"] floatValue]];
    _payController.hirer_id = dic[@"hirer_id"];
    _payController.start_time = [NSString stringWithFormat:@"%@",self.hire_start];
    _payController.end_time = [NSString stringWithFormat:@"%@",self.hire_end];
    _payController.device_token = dic[@"token"];
    _payController.device_type = dic[@"type"];
    _payController.mobile = dic[@"mobile"];
    _payController.unit_price = dic[@"unit_price"];
    _payController.property_id = dic[@"property"];
    
    if ([self.hire_method_id isEqualToString:@"56373f1100b0ee7f5ee8355c"]) {
        _payController.extra_flag = @"0";
    }else{
        if ([dic[@"day"] intValue]>1) {
            _payController.extra_flag = @"1";
        }else{
            _payController.extra_flag = @"0";
        }
    }
    [_payController setHidesBottomBarWhenPushed:YES];

    [self performSelectorOnMainThread:@selector(presentPayController) withObject:nil waitUntilDone:YES];
}

- (void)presentPayController{
   [self presentViewController:_payController animated:YES completion:nil];
}

#pragma mark ---  UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [_textField resignFirstResponder];
    
    CommentViewController *commentController = [[CommentViewController alloc]init];
    
    commentController.parkId = self.park_id;
    
    commentController.mode = self.mode;
    
    [self presentViewController:commentController animated:YES completion:nil];

}





@end
