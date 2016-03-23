//
//  TradeItemDetailController.m
//  kongcv
//
//  Created by 空车位 on 15/12/21.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "TradeItemDetailController.h"
#import "KongCVViewController.h"
#import "DetailInfoModel.h"
#import "DetailTableViewCell.h"
#import "CommentTableViewCell.h"
#import "DVSwitch.h"
#import "CommentModel.h"
#import "ZHXDataCenter.h"
#import "CommentViewController.h"
#import "QRadioButton.h"
#import "PaymentViewController.h"
#import "MJRefresh.h"
#import "NotiTableViewCell.h"
#define kGap4s     8.9
#define kGap6       10.8
#define kGap6p    11.5
#define kWidth4s   32.6
#define kWidth6     39.3
#define kWidth6p  42.3

@interface TradeItemDetailController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,QRadioButtonDelegate>
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) KongCVHttpRequest *JPushRequest;
@property (nonatomic,strong) KongCVHttpRequest *comRequest;
@property (nonatomic,strong) KongCVHttpRequest *iphoneRequest;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *commentDataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *commentTableView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIView *commentView;
@property (nonatomic,strong) NSMutableArray *commentCellArray;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) NSNumber *skipNum;
@property (nonatomic,assign) int skip;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) NSArray *methodArray;
@property (nonatomic,strong) QRadioButton *RadioButton;
@property (nonatomic,strong) PaymentViewController *payController;

@end

@implementation TradeItemDetailController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"Twenty-threePage"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"Twenty-threePage"];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self initNav:@"" andButton:@"fh" andColor:RGB(247,156, 0)];
    
    //初始化数据数组
    _commentDataArray = [NSMutableArray array];
    //初始化cell数组
    _commentCellArray = [NSMutableArray array];

    
    UIView *bgView = [[UIView alloc]init];
    if (frameX == 320.0) {
        bgView.frame = CGRectMake(64,24,192,27);
        bgView.layer.cornerRadius = 12.0;
    }else if (frameX == 375.0){
        bgView.frame = CGRectMake(76,22,228,34.4);
        bgView.layer.cornerRadius = 17.0;
    }else if (frameX == 414.0){
        bgView.frame = CGRectMake(82.5,22,245.3,32.4);
        bgView.layer.cornerRadius = 17.0;
    }
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderColor = RGB(255, 255, 255).CGColor;
    bgView.layer.borderWidth = 1;
    [self.view addSubview:bgView];

    
    if (self.community) {
        NSDictionary *communityDic = [StringChangeJson jsonDictionaryWithString:self.community];
        self.mode = @"community";
        self.park_id = communityDic[@"objectId"];
    }else if(self.curb){
        NSDictionary *curbDic = [StringChangeJson jsonDictionaryWithString:self.curb];
        self.mode = @"curb";
        self.park_id = curbDic[@"objectId"];
    }
    
    DVSwitch *switc = [[DVSwitch alloc]initWithStringsArray:@[@"详情",@"评论"]];
    if (frameX == 320.0) {
        switc.frame = CGRectMake(65, 26,190,24);
    }else if (frameX == 375.0){
        switc.frame = CGRectMake(78,24,224,29.4);
    }else if (frameX == 414.0){
        switc.frame = CGRectMake(85,24,240.3,29.4);
    }
    switc.backgroundColor = RGB(255, 156, 0);
    [switc setPressedHandler:^(NSUInteger index) {
            if (index == 0) {
                [self.view bringSubviewToFront:_tableView];
                self.tabBarController.tabBar.hidden = NO;
            }else{
    
                [self.view bringSubviewToFront:_commentTableView];
                self.tabBarController.tabBar.hidden = YES;
    
                _skip = 0;
                _skipNum = [NSNumber numberWithInt:_skip];
                [NSThread detachNewThreadSelector:@selector(downloadComment) toTarget:self withObject:nil];
    
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, frameY - 40, frameX, 40)];
                view.backgroundColor = RGB(247, 247, 247);
                [self.view addSubview:view];
    
                _textField = [[UITextField alloc]init];
                if (frameX == 320.0) {
                    _textField.frame = CGRectMake(20, 5, frameX - 40, 30);
                    _textField.layer.cornerRadius = 16.0;
                }else if (frameX == 375.0){
                    _textField.frame = CGRectMake(20, 2, frameX - 40, 36);
                    _textField.layer.cornerRadius = 20.0;
                }else if (frameX == 414.0){
                    _textField.frame = CGRectMake(20, 2, frameX-40, 36);
                    _textField.layer.cornerRadius = 20.0;
                }
                _textField.layer.masksToBounds = YES;
                _textField.delegate = self;
                _textField.placeholder = @"写评论......";
                _textField.borderStyle = UITextBorderStyleRoundedRect;
                [view addSubview:_textField];
                
            }
        }];
    [self.view addSubview:switc];

    
    //初始化UITableView
    [self initTableView];
    
    [NSThread detachNewThreadSelector:@selector(download) toTarget:self withObject:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadCommentTableView) name:@"comment" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payButtonClick:) name:@"payButtonClick" object:nil];
}


//支付
- (void)payButtonClick:(NSNotification *)info{
    
    NSDictionary *dic = info.userInfo;
    
    _payController = [[PaymentViewController alloc]init];
    
    _payController.hire_methold_id = self.hire_method_id;
    
    _payController.park_id = self.park_id;
    
    _payController.mode = self.mode;
    
    _payController.priceNum = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@",self.price] floatValue]];
    
    _payController.hirer_id = dic[@"hirer_id"];
    
    _payController.start_time =  self.start_time;
    
    _payController.end_time =  self.end_time;
    
    _payController.device_token = self.device_token;
    
    _payController.device_type = self.device_type;
    
    _payController.trade_id = self.trade_id;
    
    _payController.mobile = self.mobile;
    
    _payController.unit_price = self.unitPrice;
    
    if ([self.field isEqualToString:@"hour_meter"]) {
        
        _payController.extra_flag = @"0";
        
    }else{
        
        if ([dic[@"day"] intValue]>1) {
            
            _payController.extra_flag = @"1";
            
        }else{
            
            _payController.extra_flag = @"0";
            
        }
        
    }
    
    [_payController setHidesBottomBarWhenPushed:YES];
    
    [self presentViewController:_payController animated:YES completion:nil];
}


- (void)leftItem{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//通知刷新评论列表
- (void)reloadCommentTableView{
    _skip = 0;
    _skipNum = [NSNumber numberWithInt:_skip];
    [self downloadComment];
}

#pragma mark ---  UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [_textField resignFirstResponder];
    CommentViewController *commentController = [[CommentViewController alloc]init];
    commentController.parkId = self.park_id;
    commentController.mode = self.mode;
    [self presentViewController:commentController animated:YES completion:nil];
    
}

//下载道路详情数据
- (void)download{

    NSDictionary *dictionary = @{@"park_id":self.park_id,@"mode":self.mode};
    
    _request = [[KongCVHttpRequest alloc]initWithRequests:kDetailInfoUrl sessionToken:nil dictionary:dictionary andBlock:^(NSDictionary *data) {
        
        _dataArray = [NSMutableArray array];
        
        NSDictionary *dictionary = data[@"result"];
        
        DetailInfoModel *model = [DetailInfoModel modelWithDic:dictionary];
            
        [_dataArray addObject:model];
 
        [self.tableView reloadData];
        
    }];
    
}
//下载评论数据
- (void)downloadComment{

    NSDictionary *dic = @{@"park_id" : self.park_id, @"skip":_skipNum, @"limit":@10, @"mode" :self.mode};

    _comRequest = [[KongCVHttpRequest alloc]initWithRequests:kCommentUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
        
        [_commentCellArray removeAllObjects];
        
        [_commentDataArray removeAllObjects];
        
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
        
        [self.commentTableView.mj_header endRefreshing];
        
        [self.commentTableView.mj_footer endRefreshing];
       
    }];
    
}

//初始化UITableView
- (void)initTableView{
    
    //初始化详情UITableVIew
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, frameX, frameY-64-49) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    //初始化评论UITableVIew
    _commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, frameX,frameY - 64-49) style:UITableViewStylePlain];
    
    _commentTableView.delegate = self;
    
    _commentTableView.dataSource = self;
    
    [self.view addSubview:_commentTableView];
    
    self.commentTableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _skip = 0;
        _skipNum = [NSNumber numberWithInt:_skip];
        [self downloadComment];
    }];
    [self.commentTableView.mj_header  beginRefreshing];
    
    self.commentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _skip += 10;
        _skipNum = [NSNumber numberWithInt:_skip];
        [self downloadComment];
    }];
    
    [self.view addSubview:_tableView];
    
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
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 40)];
    
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

#pragma mark ---- UITableViewDataSource,UITableViewDelegate
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
        
        DetailInfoModel *model = _dataArray[indexPath.row];
        
        if (!cell) {
            
            cell = [[NotiTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Ident];
            
            if ([self.isHireOrLet isEqualToString:@"community"]) {
                
                cell.push_type = @"verify_accept";
                cell.tradePrice = @"price";
                cell.hire_end = self.end_time;
                cell.hire_start = self.start_time;
                cell.price        = self.price;
                cell.park_id = self.park_id;
                cell.hire_method_id = self.hire_method_id;
                cell.mode = self.mode;
                cell.park_id = self.park_id;
                cell.device_type = self.device_type;
                cell.device_token = self.device_token;
                cell.trade_id = model.objectId;
                cell.tradeItem = self.tradeItem;
                cell.unit_Price = self.unitPrice;
                cell.trade_state = self.trade_state;
            }
        }
        
        cell.model = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return cell;
        
    }else {
        
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat length;
    
    if ([tableView isEqual:_tableView]) {
        
        length = 1000;
        
    }else if ([tableView isEqual:_commentTableView]){
        
        CommentTableViewCell *cell = _commentCellArray[indexPath.row];
        cell.model = _commentDataArray[indexPath.row];
        length = cell.cellHeight+16.6;
        
    }
    return length;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
