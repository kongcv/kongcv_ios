//
//  MoneyPocketViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/11.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "MoneyPocketViewController.h"

//提现
#import "WithdrawDepositViewController.h"
//账单
#import "CheckViewController.h"
//银行
#import "BankViewController.h"

#import "StringChangeJson.h"

#import "MoneyTableViewCell.h"

@interface MoneyPocketViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) KongCVHttpRequest *request;

@property (nonatomic,strong) UILabel *moneyLabel;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic,strong) NSArray *iconArray;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) NSArray *bankArray;

@end

@implementation MoneyPocketViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"SixteenPage"];

}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick endLogPageView:@"SixteenPage"];
    
}


-(NSArray *)titleArray{
    
    if (_titleArray == nil) {
        
        _titleArray = @[@"账单",@"银行卡",@"提现"];
        
    }
    
    return _titleArray;
}

-(NSArray *)iconArray{
    
    if (_iconArray == nil) {
        
        _iconArray = @[@"zhangdan",@"bank",@"tixian"];
        
    }
    
    return _iconArray;
}

-(UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgView.frame)+14, frameX, frameY - CGRectGetMaxY(_bgView.frame)-49) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        _tableView.scrollEnabled = NO;
        
        [self.view addSubview:_tableView];
        
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self layoutUI];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self downloadData];
        
    });

    [self.tableView reloadData];
    
}

- (void)downloadData{
    
    if ([StringChangeJson getValueForKey:kUser_id]) {
        
        NSDictionary *dic = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"skip":@0,@"limit":@10};
        _request = [[KongCVHttpRequest alloc]initWithRequests:kGetPurse sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
            
            NSDictionary *dic  = [data[@"result"] firstObject ];
            
            if (dic) {
                
                self.bankArray = dic[@"bank_card"];
                
                NSString *string = [NSString stringWithFormat:@"%@",dic[@"money"]];
                
                self.moneyLabel.text = [NSString stringWithFormat:@"%.f元",[string floatValue ]];
                
            }
            
        }];
    }
}

- (void)layoutUI{

    self.view.backgroundColor = RGB(247, 247, 247);
    
    [self initNav:@"钱包" andButton:@"fh" andColor:RGB(247, 247, 247)];

    //账户余额背景
    self.bgView = [UIView viewWithFrame:CGRectMake(0,65, frameX, 74)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    //账户余额图标
    UIImageView *accountMonIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25+64, 22, 24)];
    accountMonIcon.image = [UIImage imageNamed:@"qianbao"];
    [self.view addSubview:accountMonIcon];

    
    //显示账户余额label
    UILabel *accountMoneyLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(accountMonIcon.frame)+20,64, frameX-200, 74) text:@"账户余额" Color:nil Font:UIFont(17)];
    [self.view addSubview:accountMoneyLabel];
    
    //钱数
    _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(accountMoneyLabel.frame),64, 100, 74)];
    
    _moneyLabel.font = UIFont(21);
    
    _moneyLabel.textColor = RGB(255, 194, 99);
    
    [self.view addSubview:_moneyLabel];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titleArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identfier = @"cell";
    
    MoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    
    if (cell == nil) {
        
        cell = [[MoneyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
        
    }
    
    cell.titleLabel.text = self.titleArray[indexPath.row];
    
    cell.iconImageView.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 47*frameX/320.0;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *controllersArray = @[@"CheckViewController",@"BankViewController",@"WithdrawDepositViewController"];
    
    Class class = NSClassFromString(controllersArray[indexPath.row]);
    
    RootViewController *controller = [[class alloc]init];
    
    if (indexPath.row == 2) {
        
        WithdrawDepositViewController *control = (WithdrawDepositViewController *)controller;
        
        control.money = _moneyLabel.text;
        
        control.bankArray = self.bankArray;
        
    }
    
    if (indexPath.row != 1){
    
        [self.navigationController pushViewController:controller animated:YES];
        
    }else{
        
        NSString *string  = [[NSUserDefaults standardUserDefaults]objectForKey:@"createCard"];
        
        if ([string isEqualToString:@"createCard"]) {
            
            BankViewController *controller = [[BankViewController alloc]init];
            
            [self.navigationController pushViewController:controller animated:YES];
            
        }else{
        
            static dispatch_once_t onceToken;dispatch_once(&onceToken, ^{
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"空车位提示" message:@"添加银行卡方便您提取钱包金额,但请您妥善保管提现密码,避免丢失或泄漏!我们会保护您的个人隐私,不会透露给任何人." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认添加", nil];
                
                [alertView show];
                
            });
            
        }
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"createCard" forKey:@"createCard"];
        
        BankViewController *controller = [[BankViewController alloc]init];
        
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    
}


@end
