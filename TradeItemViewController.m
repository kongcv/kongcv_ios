//
//  TradeItemViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/11.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "TradeItemViewController.h"

#import "TradeItemTableViewCell.h"

#import "HirerTradeTableViewCell.h"

#import "TradeItemDetailController.h"

#import "CheckModel.h"

#import "DVSwitch.h"

#import "NotificationViewController.h"

#import "TimeChange.h"

#import "CurbItemViewController.h"

@interface TradeItemViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) KongCVHttpRequest *request;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *tradeArray;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIButton *button;

@property (nonatomic,copy)   NSString *customStr;

@property (nonatomic,strong) UITableView *tradeTableView;

@property (nonatomic,assign) int skip;

@property (nonatomic,strong) NSNumber *skipNum;

@property (nonatomic,copy)   NSString      *isHireOrLet;

@end

@implementation TradeItemViewController
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick endLogPageView:@"Twenty-threePage"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
     self.tabBarController.tabBar.hidden = NO;
    
    self.navigationController.navigationBar.hidden = NO;
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"Twenty-threePage"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self initNav:@"" andButton:@"fh" andColor:RGB(247,156, 0)];
    
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
    
    DVSwitch *switc = [[DVSwitch alloc]initWithStringsArray:@[@"租用订单",@"出租订单"]];
    if (frameX == 320.0) {
        switc.frame = CGRectMake(65, 26,190,24);
    }else if (frameX == 375.0){
        switc.frame = CGRectMake(78,24,224,29.4);
    }else if (frameX == 414.0){
        switc.frame = CGRectMake(85,24,240.3,29.4);
    }
    switc.backgroundColor = [UIColor colorWithRed:254/255.0 green:156/255.0 blue:0 alpha:1.0];
   
    [switc setPressedHandler:^(NSUInteger index) {
        
        if (index == 0) {
            
            [UIView animateWithDuration:0.3 animations:^{
                if (frameX == 320.0) {
                    _imageView.center = CGPointMake(80,CGRectGetMaxY(_button.frame)+0.5);
                }else if (frameX == 375.0){
                    _imageView.center = CGPointMake(93.75,CGRectGetMaxY(_button.frame)+0.5);
                }else{
                    _imageView.center = CGPointMake(103.5,CGRectGetMaxY(_button.frame)+0.5);
                }
                
            } completion:nil];
            
            _customStr = @"customer";
            
            _isHireOrLet  = @"curb";
            
            [self downloadData:@"curb"];
            
            [self.view bringSubviewToFront:_tableView];
            
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                if (frameX == 320.0) {
                    _imageView.center = CGPointMake(80,CGRectGetMaxY(_button.frame)+0.5);
                }else if (frameX == 375.0){
                    _imageView.center = CGPointMake(93.75,CGRectGetMaxY(_button.frame)+0.5);
                }else{
                    _imageView.center = CGPointMake(103.5,CGRectGetMaxY(_button.frame)+0.5);
                }
                
            } completion:nil];
            
            [self.view bringSubviewToFront:_tradeTableView];
    
            _customStr = @"hirer";
            
            _isHireOrLet  = @"curb";
            
            [self downloadData:@"curb" ];
            
        }
    }];
    [self.view addSubview:switc];

    [self layoutUI];
    
    _skip = 0;
    
    _skipNum = [NSNumber numberWithInt:_skip];
    
    _customStr = @"customer";
    
    _isHireOrLet  = @"curb";
    
    _dataArray = [NSMutableArray array];
    
    _tradeArray = [NSMutableArray array];
    
}

- (void)backItem{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)layoutUI{
    
    NSArray *array = @[@"商业",@"个人"];
    
    UIButton *button;
    
    for (int i = 0; i<2; i++) {
        
        button = [UIButton buttonWithFrame:CGRectMake(0+(frameX/2)*i,64,frameX/2,40) type:UIButtonTypeSystem title:array[i] target:self action:@selector(buttonClick:)];
        
        _button = button;
        
        button.tag = 100+i;
        
        [button setTitleColor:RGB(255, 156, 0) forState:UIControlStateNormal];
        
        [button setBackgroundImage:[UIImage imageNamed:@"backg_kuang"] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
        
    }

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(button.frame)+10,frameX,350*frameY/480.0) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    UIView *letView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX,40)];
    
    letView.backgroundColor = [UIColor whiteColor];
    
    _tableView.tableFooterView = letView;
    
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ([_customStr isEqualToString:@"customer"]) {
            
            if ([_isHireOrLet isEqualToString:@"curb"]) {
                
                _skip = 0;
                
                _skipNum = [NSNumber numberWithInt:_skip];
                
                [self downloadData:@"curb" ];
                
            }else if ([_isHireOrLet isEqualToString:@"community"]){
                
                _skip = 0;
                
                _skipNum = [NSNumber numberWithInt:_skip];
                
                [self downloadData:@"community" ];
                
            }
            
        }
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if ([_customStr isEqualToString:@"customer"]) {
            
            if ([_isHireOrLet isEqualToString:@"curb"]) {
                
                _skip += 10;
                
                _skipNum = [NSNumber numberWithInt:_skip];
                
                [self downloadData:@"curb" ];
                
            }else if ([_isHireOrLet isEqualToString:@"community"]){
                
                _skip += 10;
                
                _skipNum = [NSNumber numberWithInt:_skip];
                
                [self downloadData:@"community" ];
                
            }
        }
    }];


    //出租订单
    _tradeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(button.frame)+10,frameX,350*frameY/480.0) style:UITableViewStylePlain];
    _tradeTableView.dataSource = self;
    _tradeTableView.delegate = self;
    _tradeTableView.tableFooterView = letView;
    
    //下拉刷新
    self.tradeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([_customStr isEqualToString:@"hirer"]){
            if ([_isHireOrLet isEqualToString:@"curb"]) {
                _skip = 0;
                _skipNum = [NSNumber numberWithInt:_skip];
                [self downloadData:@"curb" ];
            }else if ([_isHireOrLet isEqualToString:@"community"]){
                _skip = 0;
                _skipNum = [NSNumber numberWithInt:_skip];
                [self downloadData:@"community" ];
            }
        }
    }];

    
    //上拉加载
    self.tradeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ([_customStr isEqualToString:@"hirer"]){
            if ([_isHireOrLet isEqualToString:@"curb"]) {
                _skip += 10;
                _skipNum = [NSNumber numberWithInt:_skip];
                [self downloadData:@"curb" ];
            }else if ([_isHireOrLet isEqualToString:@"community"]){
                _skip +=10;
                _skipNum = [NSNumber numberWithInt:_skip];
            
                [self downloadData:@"community" ];
            }
        }
    }];

    
    
    [self.view addSubview:_tradeTableView];

    [self.view addSubview:_tableView];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame), button.frame.size.width,1)];
    _imageView.image = [UIImage imageNamed:@"bg_xian"];
    [self.view addSubview:_imageView];
    
}

- (void)buttonClick:(UIButton *)btn{

    switch (btn.tag - 100) {
        case 0:
        {
            _isHireOrLet = @"curb";
            _skip = 0;
            _skipNum = [NSNumber numberWithInt:_skip];
            [self downloadData:_isHireOrLet];
            [UIView animateWithDuration:0.3 animations:^{
                
                if (frameX == 320.0) {
                    _imageView.center = CGPointMake(80,CGRectGetMaxY(_button.frame)+0.5);
                }else if (frameX == 375.0){
                    _imageView.center = CGPointMake(93.75,CGRectGetMaxY(_button.frame)+0.5);
                }else{
                    _imageView.center = CGPointMake(103.5,CGRectGetMaxY(_button.frame)+0.5);
                }
                
            } completion:nil];
        }
            break;
        case 1:
        {
            _isHireOrLet = @"community";
            _skip = 0;
            _skipNum = [NSNumber numberWithInt:_skip];
            [self downloadData:_isHireOrLet];
            [UIView animateWithDuration:0.3 animations:^{
            if (frameX == 320.0) {
                _imageView.center = CGPointMake(240,CGRectGetMaxY(_button.frame)+0.5);
            }else if (frameX == 375.0){
                _imageView.center = CGPointMake(281.25,CGRectGetMaxY(_button.frame)+0.5);
            }else{
                _imageView.center = CGPointMake(310.5,CGRectGetMaxY(_button.frame)+0.5);
            }
            
            } completion:nil];
        }
            break;
            
        default:
            break;
    }
}

- (void)downloadData:(NSString *)string{

    if ([_customStr isEqualToString:@"customer"]) {
        
        if ([StringChangeJson getValueForKey:kUser_id]) {
            
            NSDictionary *dictionary = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"role":_customStr,@"trade_state":@3,@"skip":_skipNum,@"limit":@10,@"mode":string};
            
            _request = [[KongCVHttpRequest alloc]initWithRequests:kTradeDetailInfoUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {

                NSArray *array = data[@"result"];
                    
                [_dataArray removeAllObjects];
                    
                for (NSDictionary *dic in array) {
                        
                    CheckModel *model = [CheckModel modelWithDic:dic];
                        
                    [_dataArray addObject:model];
                        
                }
                    
                [_tableView reloadData];

                [self.tableView.mj_header endRefreshing];
                
                [self.tableView.mj_footer endRefreshing];
                
            }];

        }
  }else if([_customStr isEqualToString:@"hirer"]){
      
      if ([StringChangeJson getValueForKey:kUser_id]) {
          
          NSDictionary *dictionary = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"role":_customStr,@"trade_state":@3,@"skip":_skipNum,@"limit":@10,@"mode":string};
          
          _request = [[KongCVHttpRequest alloc]initWithRequests:kTradeDetailInfoUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {

            NSArray *array = data[@"result"];

            [_tradeArray removeAllObjects];
                  
            for (NSDictionary *dic in array) {
                      
                CheckModel *model = [CheckModel modelWithDic:dic];
                      
                [_tradeArray addObject:model];
                      
            }
                  
              [_tradeTableView reloadData];
                  

          [self.tradeTableView.mj_header endRefreshing];
              
            [self.tradeTableView.mj_footer endRefreshing];
              
          }];
        }
   }
}

#pragma mark --- <UITableViewDataSource,UITableViewDelegate>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger num;
    
    if ([tableView isEqual:_tableView]) {
        
        num = _dataArray.count;
        
    }else if ([tableView isEqual:_tradeTableView]){
        
        num = _tradeArray.count;
        
    }
    return num;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_tableView]) {
        
        static NSString *ident = @"cell";
        
        TradeItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
        
        if (cell == nil) {
            
            cell = [[TradeItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
            
        }
        
        CheckModel *model = _dataArray[indexPath.row];
        
        cell.model = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return cell;
    }else{
        
        static NSString *ident = @"tradeCell";
        
        HirerTradeTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:ident];
        
        if (cells == nil) {
            
            cells = [[HirerTradeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
            
        }
        
        CheckModel *model = _tradeArray[indexPath.row];
        
        cells.model = model;
        
        cells.selectionStyle = UITableViewCellSelectionStyleNone;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return cells;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([_customStr isEqualToString:@"customer"]){
        
        TradeItemDetailController *tradeItemDetailController = [[TradeItemDetailController alloc]init];
        
        CheckModel *model  = _dataArray[indexPath.row];
        
        NSString *trade_state = [NSString stringWithFormat:@"%@",model.trade_state];
        
        if (model.park_community) {

            tradeItemDetailController.community = model.park_community;
            
            tradeItemDetailController.curb = model.park_curb;
            
            tradeItemDetailController.isHireOrLet = _isHireOrLet;
            
            NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:model.hire_method];
            
            NSDictionary *hirDic = [StringChangeJson jsonDictionaryWithString:model.hirer];
            
            tradeItemDetailController.hire_method_id = dic[@"objectId"];
            
            tradeItemDetailController.hirer_id = hirDic[@"objectId"];
            
            tradeItemDetailController.price = model.price;
            
            tradeItemDetailController.field = dic[@"field"];
            
            if (model.hire_start[@"iso"]) {
                
                tradeItemDetailController.start_time = [TimeChange timeChange:model.hire_start[@"iso"]];
                
            }
            if (model.hire_end[@"iso"]) {
                
               tradeItemDetailController.end_time = [TimeChange timeChange:model.hire_end[@"iso"]];
                
            }
            
             tradeItemDetailController.device_token = hirDic[@"device_token"];
            
             tradeItemDetailController.device_type = hirDic[@"device_type"];
            
             tradeItemDetailController.mobile = hirDic[@"mobilePhoneNumber"];
            
             tradeItemDetailController.trade_id = model.objectId;
            
             tradeItemDetailController.unitPrice = model.unit_price;
            
             tradeItemDetailController.trade_state = [NSString stringWithFormat:@"%@",model.trade_state];
            
             [self.navigationController pushViewController:tradeItemDetailController animated:YES];
         
        }else if(model.park_curb){
            
            if ([trade_state isEqualToString:@"0"]) {
                
                //NSString *check_state = [NSString stringWithFormat:@"%@",model.check_state];
                
                CurbItemViewController *curbItemController = [[CurbItemViewController alloc]init];
                
                curbItemController.curb = model.park_curb;
                
                curbItemController.isHireOrLet = _isHireOrLet;
                
                NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:model.hire_method];
                
                NSDictionary *hirDic = [StringChangeJson jsonDictionaryWithString:model.hirer];
                
                curbItemController.hire_method_id = dic[@"objectId"];
                
                curbItemController.hirer_id = hirDic[@"objectId"];
            
                if (model.hire_start[@"iso"]) {
                    
                    curbItemController.start_time = [TimeChange timeChange:model.hire_start[@"iso"]];
                    
                }
                if (model.hire_end[@"iso"]) {
                    
                    curbItemController.end_time = [TimeChange timeChange:model.hire_end[@"iso"]];
                    
                }
                
                curbItemController.device_token = hirDic[@"device_token"];
                
                curbItemController.device_type = hirDic[@"device_type"];
                
                curbItemController.mobile = hirDic[@"mobilePhoneNumber"];
                
                curbItemController.pay_tool = model.pay_tool;
                
                curbItemController.trade_id = model.objectId;
                
                curbItemController.unitPrice = model.unit_price;
                
                curbItemController.trade_state = trade_state;
                
                curbItemController.field = dic[@"field"];
                
                NSString *money = [NSString stringWithFormat:@"%@",model.money];
                
                NSString *price = [NSString stringWithFormat:@"%@",model.price];

                NSString *handsel_state  = [NSString stringWithFormat:@"%@",model.handsel_state];
                
                NSString *trade_state = [NSString stringWithFormat:@"%@",model.trade_state];
                
                NSString *fieldStr = dic[@"field"];
                
                //NSLog(@"%@---%@----%@",fieldStr,handsel_state ,trade_state);
                
                if ([fieldStr isEqualToString:@"hour_meter"]) {
 
                    if([trade_state isEqualToString:@"0"]){
                        //支付定金
                        if ([handsel_state isEqualToString:@"1"]) {

                            curbItemController.price =  [NSString stringWithFormat:@"%f",[price floatValue] - [money floatValue]];
                            
                        }else if([handsel_state isEqualToString:@"0"]){

                            curbItemController.price = price;
                            
                        }
                        
                    }
                    
                }
                
                 [self.navigationController pushViewController:curbItemController animated:YES];
                
            }
            
        }
        
    }else if ([_customStr isEqualToString:@"hirer"]){
        
        CheckModel *model = _tradeArray[indexPath.row];
        
        if (model.user) {
            
            NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:model.user];
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",dic[@"mobilePhoneNumber"]];
            
            UIWebView * callWebview = [[UIWebView alloc] init];
            
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            
            [self.view addSubview:callWebview];
            
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 167*frameX/320.0;
}

@end
