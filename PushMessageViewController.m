//
//  PushMessageViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/22.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "PushMessageViewController.h"
#import "PushMessageModel.h"
#import "PushMessageTableViewCell.h"
#import "NotificationViewController.h"
#import "DetailViewController.h"
#import "RouteViewController.h"
#import "CurbNotificationViewController.h"
@interface PushMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

//网络请求
@property (nonatomic,strong) KongCVHttpRequest *request;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIImageView *puImageView;

@property (nonatomic,strong) NSNumber *skipNum;
@property (nonatomic,assign) int skip;
//发送消息或者接受消息
@property (nonatomic,strong) NSString *string;
@end

@implementation PushMessageViewController
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
    self.navigationController.navigationBarHidden = YES;
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"Twenty-fourPage"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadController) name:@"message" object:nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"Twenty-fourPage"];
    
    //[[NSNotificationCenter defaultCenter]removeObserver:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(247, 247, 247);

    [self initNav:@"消息通知" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    _string = @"send";
    
    [self initTableView];
    
    self.dataArray = [NSMutableArray array];
    
    _skip = 0;
    
    _skipNum = [NSNumber numberWithInt:_skip];
}

- (void)reloadController{

    _string = @"recv";
    [self downloadData:_string];
}


- (void)downloadData:(NSString *)string{

    
    if ([StringChangeJson getValueForKey:kMobelNum]) {

        NSDictionary *dic;
        
        if ([_string isEqualToString:@"recv"]) {
            
           dic =   @{@"mobilePhoneNumber":[StringChangeJson getValueForKey:kMobelNum], @"skip":_skipNum, @"limit":@10, @"action":string,@"mode":@"community"};
            
        }else if ([_string isEqualToString:@"send"]){
            
           dic =  @{@"mobilePhoneNumber":[StringChangeJson getValueForKey:kMobelNum], @"skip":_skipNum, @"limit":@10, @"action":string,@"mode":@""};
            
        }
        
        _request = [[KongCVHttpRequest alloc]initWithRequests:kMessageUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
            
            NSArray *array = data[@"result"];
            
            if (array.count != 0) {
                
                [_dataArray removeAllObjects];
                
                for (NSDictionary *dic in array) {
                    
                    PushMessageModel *model = [PushMessageModel modelWithDictionar:dic];
                    
                    [_dataArray addObject:model];
                    
                }
                
                [self.tableView reloadData];
                
            }
            
            [self.tableView.mj_header endRefreshing];
            
            [self.tableView.mj_footer endRefreshing];
            
        }];
    }
}


- (void)initTableView{
    
    NSArray *array = @[@"我发送的",@"我收到的"];
    
    for (int i = 0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithFrame:CGRectMake(0+frameX/2*i,64,frameX/2,44) type:UIButtonTypeCustom title:array[i] target:self action:@selector(btnClick:)];
        btn.tag = 100+i;
        btn.titleLabel.font = UIFont(16);
        btn.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:btn];
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,44+64, frameX, 1)];
    imageView.image = [UIImage imageNamed:@"720"];
    [self.view addSubview:imageView];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10,frameX,frameY - CGRectGetMaxY(imageView.frame)-10-49)];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, frameX, 150)];
    
    self.tableView.tableFooterView = view;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    _puImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frameX/4-25, 44+64,50, 2)];
    
    _puImageView.image = [UIImage imageNamed:@"bgPu_xian"];
    
    [self.view addSubview:_puImageView];
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _skip = 0;
        
        _skipNum = [NSNumber numberWithInt:_skip];
        
        if ([_string isEqualToString:@"send"]) {
            
            [self downloadData:@"send"];
            
        }else if ([_string isEqualToString:@"recv"]){
            
            [self downloadData:@"recv"];
            
        }
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _skip += 10;
        
        _skipNum = [NSNumber numberWithInt:_skip];
        
        if ([_string isEqualToString:@"send"]) {
            
            [self downloadData:@"send"];
            
        }else if ([_string isEqualToString:@"recv"]){
            
            [self downloadData:@"recv"];
            
        }
        
    }];
    
}

- (void)btnClick:(UIButton *)btn{
    switch (btn.tag - 100) {
        case 0:
        {
            _string = @"send";
            
            _skip = 0;
            
            _skipNum = [NSNumber numberWithInt:_skip];
            
            [self downloadData:@"send"];
            
            [UIView animateWithDuration:0.3 animations:^{
                _puImageView.center = CGPointMake(80*frameX/320.0,45+64);
            } completion:nil];
            
        }
            break;
        case 1:
        {
            _string = @"recv";
            
            _skip = 0;
            
            _skipNum = [NSNumber numberWithInt:_skip];
            
            [self downloadData:@"recv"];
            
            [UIView animateWithDuration:0.3 animations:^{
                 _puImageView.center = CGPointMake(240*frameX/320.0,45+64);
            } completion:nil];
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark ----- <UITableViewDataSource,UITableViewDelegate>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ident = @"cell";
    
    PushMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (cell == nil) {
        
        cell = [[PushMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
        if ([_string isEqualToString:@"recv"]) {
            
            cell.recv = @"recv";
            
        }else if ([_string isEqualToString:@"send"]){
            
            cell.send = @"send";
            
        }
    }
    
    PushMessageModel *model = _dataArray[indexPath.row];
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PushMessageModel *model = _dataArray[indexPath.row];
    NSString *state = [NSString stringWithFormat:@"%@",model.state];

    if ([_string isEqualToString:@"recv"]) {
        
        if ([state isEqualToString:@"0"]) {
            
            NotificationViewController *detailController = [[NotificationViewController alloc]init];
            
            detailController.hire_method_id = model.extras[@"hire_method_id"];
            
            detailController.mode = model.extras[@"mode"];
            
            detailController.push_type = model.push_type;
            
            detailController.park_id = model.extras[@"park_id"];
            
            detailController.pushMessage = @"pushMessage";
            
            detailController.price = model.extras[@"price"];
            
            detailController.hire_start = model.extras[@"hire_start"];
            
            detailController.hire_end = model.extras[@"hire_end"];
            
            detailController.own_mobile = model.extras[@"own_mobile"];
            
            detailController.device_token = model.extras[@"own_device_token"];
            
            detailController.device_type = model.extras[@"own_device_type"];
            
            detailController.message_id = model.objectId;
            
            [self.navigationController pushViewController:detailController animated:YES];
            
        }
    }else if([_string isEqualToString:@"send"]){
        
        NSString *mode =  model.extras[@"mode"];
        
        if ([state isEqualToString:@"0"]) {
            
            if ([mode isEqualToString:@"community"]) {
                
                DetailViewController *detailController = [[DetailViewController alloc]init];
                
                detailController.park_id = model.extras[@"park_id"];
                
                detailController.mode = mode;
                
                detailController.pushMessage = @"push";
                
                [self.navigationController pushViewController:detailController animated:YES];
                
            }else{
                
                RouteViewController *routeController = [[RouteViewController alloc]init];
                
                routeController.park_id = model.extras[@"park_id"];
                
                routeController.mode = mode;
                
                routeController.pushMessage = @"push";
                
                routeController.price = @"price";
                
                [self.navigationController pushViewController:routeController animated:YES];
                
            }
        }else if ([state isEqualToString:@"1"]){
            
            if ([mode isEqualToString:@"community"]) {

                NotificationViewController *notViewController = [[NotificationViewController alloc]init];
                
                notViewController.hire_method_id = model.extras[@"hire_method_id"];
                
                notViewController.hire_start = model.extras[@"hire_start"];
                
                notViewController.hire_end = model.extras[@"hire_end"];
                
                notViewController.park_id = model.extras[@"park_id"];
                
                notViewController.mode = model.extras[@"mode"];
                
                notViewController.price = [NSString stringWithFormat:@"%@",model.extras[@"price"]];
                
                notViewController.push_type = @"verify_accept";
                
                notViewController.device_token = model.extras[@"own_device_token"];
                
                notViewController.device_type = model.extras[@"own_device_type"];
                
                notViewController.own_mobile = model.extras[@"own_mobile"];

                [self.navigationController pushViewController:notViewController animated:YES];
                
            }else{
                
                CurbNotificationViewController *curbController = [[CurbNotificationViewController alloc]init];
                
                curbController.hire_method_id = model.extras[@"hire_method_id"];
                
                curbController.park_id = model.extras[@"park_id"];
                
                curbController.hire_start = model.extras[@"hire_start"];
                
                curbController.hire_end = model.extras[@"hire_end"];
                
                curbController.mode = model.extras[@"mode"];
                
                curbController.price = [NSString stringWithFormat:@"%@",model.extras[@"price"]];
                
                curbController.push_type = @"verify_accept";
                
                [self.navigationController pushViewController:curbController animated:YES];
                
            }
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 72;
}

@end
