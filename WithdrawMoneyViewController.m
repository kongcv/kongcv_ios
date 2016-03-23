//
//  WithdrawMoneyViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/16.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "WithdrawMoneyViewController.h"
#import "WithdrawModel.h"
#import "WithdrawMoneyCell.h"
@interface WithdrawMoneyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) KongCVHttpRequest *request;

@property (nonatomic,strong) NSMutableArray *array;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) int skip;

@property (nonatomic,strong) NSNumber *number;

@end

@implementation WithdrawMoneyViewController
- (void)viewWillAppear:(BOOL)animated{

}
- (void)viewWillDisappear:(BOOL)animated{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNav:@"提现记录" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    _skip = 0;
    _number = [NSNumber numberWithInt:_skip];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        [self downloadData];
        
    });
    
    [self initTableView];
    
}


- (void)initTableView{
    
    _array = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, frameX, frameY - 64 -49) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,frameX,120*frameY/480.0)];
    
    _tableView.tableFooterView = view;
    
    //下拉刷新
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _skip = 0;
        
        _number = [NSNumber numberWithInt:_skip];
        
        [self downloadData];
        
    }];
    
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _skip += 10;
        
        _number = [NSNumber numberWithInt:_skip];
        
        [self downloadData];
        
    }];
    
}

- (void)downloadData{
    
    if ([StringChangeJson getValueForKey:kUser_id]) {
     
        NSDictionary *dictionary = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"skip":_number,@"limit":@10};

        _request = [[KongCVHttpRequest alloc]initWithRequests:kWithdrawUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {

            NSArray *array = data[@"result"];
            
            if (array.count != 0) {
                
                  [_array removeAllObjects];
                
                for (NSDictionary *dic in array) {
                    
                    WithdrawModel *model = [WithdrawModel modelWithDic:dic];
                    
                    [_array addObject:model];
                    
                }
                
                [self.tableView reloadData];
                
            }
 
            [self.tableView.mj_header endRefreshing];
            
            [self.tableView.mj_footer endRefreshing];

        }];

    }
}

#pragma  mark ---- <UITableViewDataSource,UITableViewDelegate>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ident = @"cell";
    
    WithdrawMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (cell == nil) {
        
        cell = [[WithdrawMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
    }
    
    WithdrawModel *model = _array[indexPath.row];
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

@end
