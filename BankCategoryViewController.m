//
//  BankCategoryViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/17.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "BankCategoryViewController.h"
#import "BankModel.h"
#import "BankTableViewCell.h"
@interface BankCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array;
@end

@implementation BankCategoryViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"TwentyPage"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick endLogPageView:@"TwentyPage"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"类型";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNav:@"个人车位" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    [self initTableView];
    
    [self downloadData];
}


- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, frameX, frameY) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 115)];
    _tableView.tableFooterView = view;

}

- (void)downloadData{

    _array = [NSMutableArray array];
    
    _request = [[KongCVHttpRequest alloc]initWithRequests:kGetBankInfo sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:nil andBlock:^(NSDictionary *data) {
        
        NSArray *array =  data[@"result"];
        
        for (NSDictionary *dic in array) {
            BankModel *model = [BankModel modelWithDictionary:dic];
            [_array addObject:model];
        }
        [self.tableView reloadData];
    }];
}


-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ident = @"cell";
    
    BankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (cell == nil) {
        cell = [[BankTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    BankModel *model = _array[indexPath.row];
    
    cell.model = model;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BankModel *model = _array[indexPath.row];
    _block(@{@"key":model.bank,@"url":model.picture[@"url"]});
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}



@end
