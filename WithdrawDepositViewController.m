//
//  WithdrawDepositViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/12.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "WithdrawDepositViewController.h"

#import "WithdrawMoneyViewController.h"

#import "BankInfoViewController.h"

#import "NSString+Hashing.h"

#import "WithdrawTableViewCell.h"

@interface WithdrawDepositViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITextField *moneyTextField;

@property (nonatomic,strong) UITextField *screateTextField;

@property (nonatomic,strong) KongCVHttpRequest *request;

@property (nonatomic,strong) NSMutableArray *array;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation WithdrawDepositViewController

-(NSArray *)titleArray{

    if (_titleArray == nil) {
        
        _titleArray = @[@"银行卡      :",@"金额(元)    :",@"提现密码  :"];
        
    }
    
    return _titleArray;
}

-(UITableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, frameX,47*frameX/320.0*3+1) style:UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor redColor];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        _tableView.scrollEnabled = NO;
        
        [self.view addSubview:_tableView];
        
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(247, 247, 247);
    
    [self initNav:@"提现" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    //提现记录
    UIButton *withdrowBtn = [UIButton buttonWithFrame:CGRectMake(frameX - 110,25,100,30) font:UIFont(17) bgColor:nil textColor:[UIColor blackColor] title:@"体现记录" bgImage:nil target:self action:@selector(withdrawDesposit:)];
    
    withdrowBtn.titleLabel.font = UIBold(15);
   
    [self.view addSubview:withdrowBtn];
    
    [self.tableView reloadData];

    //体现确认按钮
    UIButton *confirmBtn = [UIButton buttonWithFrame:CGRectMake(100, CGRectGetMaxY(self.tableView.frame)+30,frameX - 200, 50) font:UIFont(16) bgColor:RGB(255, 156, 0) textColor:[UIColor whiteColor] title:@"确认提现" bgImage:nil target:self action:@selector(confirmBtnClick:)];

    confirmBtn.layer.masksToBounds = YES;
    
    confirmBtn.layer.cornerRadius = 5.0;
    
    [self.view addSubview:confirmBtn];
    
}



//提现记录
- (void)withdrawDesposit:(UIButton *)btn{
    
    WithdrawMoneyViewController *moneyController = [[WithdrawMoneyViewController alloc]init];
    
    [self.navigationController pushViewController:moneyController animated:YES];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifer = @"cell";
    
    WithdrawTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        
        cell = [[WithdrawTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    //银行卡
    if (indexPath.row == 0) {
        
        UIButton *cardBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(cell.titleLabel.frame),1,frameX - CGRectGetMaxX(cell.titleLabel.frame)-5,45*frameX/320.0) type:UIButtonTypeCustom title:nil target:self action:@selector(bankClick:)];
        
        if (self.bankArray) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.bankArray firstObject][@"bank_icon"]]];
                
                [cardBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                
                cardBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0,100);
                
            });

            [cardBtn setTitle:[NSString stringWithFormat:@"%@",[self.bankArray firstObject][@"bank"]] forState:UIControlStateNormal];
            
            cardBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 70);
        
        }
        
        [cell.contentView addSubview:cardBtn];
        
    }else if (indexPath.row == 1){
    
        self.moneyTextField = [UITextField textFieldWithFrame:CGRectMake(CGRectGetMaxX(cell.titleLabel.frame), 1,frameX - CGRectGetMaxX(cell.titleLabel.frame)-5, 45*frameX/320.0) font:UIFont(15) bgColor:[UIColor whiteColor] textColor:nil placeholder:@"请输入金额"];
        
        self.moneyTextField.delegate = self;
        
        [cell.contentView addSubview:self.moneyTextField];
        
    }else if (indexPath.row == 2){
    
        self.screateTextField = [UITextField textFieldWithFrame:CGRectMake(CGRectGetMaxX(cell.titleLabel.frame), 1,frameX - CGRectGetMaxX(cell.titleLabel.frame)-5, 45*frameX/320.0)  font:UIFont(15) bgColor:[UIColor whiteColor] textColor:nil placeholder:@"请输入密码"];
        
        self.screateTextField.delegate = self;
        
        self.screateTextField.secureTextEntry = YES;
        
        [cell.contentView addSubview:self.screateTextField];
        
    }
    
    cell.titleLabel.text = self.titleArray[indexPath.row];
    
    cell.selected = UITableViewCellSelectionStyleNone;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 47*frameX/320.0;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.moneyTextField resignFirstResponder];
    
    [self.screateTextField resignFirstResponder];
    
    return YES;
    
}


//银行卡
- (void)bankClick:(UIButton *)btn{
    
    if (!self.bankArray ) {
        
        BankInfoViewController *bankInfo = [[BankInfoViewController alloc]init];
        
        [self.navigationController pushViewController:bankInfo animated:YES];
        
    }
    
}

//确认提现
- (void)confirmBtnClick:(UIButton *)btn{
    
    [self.moneyTextField resignFirstResponder];
    
    [self.screateTextField resignFirstResponder];
    
    NSNumber *moneyNum = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@",_moneyTextField.text] floatValue ]];
    //如果提现金额大于当前存款
        if (_moneyTextField.text.length == 0) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入提现金额" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alertView show];
            
        }else{
            
            if ([_moneyTextField.text floatValue] > [self.money floatValue]) {
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"提款金额超过账户余额" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alertView show];
            }else{
            
                NSString *passwdMD5 = [[_screateTextField.text MD5Hash] lowercaseString];
                
                if ([StringChangeJson getValueForKey:kUser_id] && passwdMD5 ) {
                    
                    NSDictionary *passsdDic = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"passwd":passwdMD5};
                  
                    _request  = [[KongCVHttpRequest alloc]initWithRequests:kVerifyPassWordUrl sessionToken:[StringChangeJson getValueForKey:kSessionToken] dictionary:passsdDic andBlock:^(NSDictionary *data) {
                        
                        NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
                       
                        if ([dic[@"msg"]  isEqualToString:@"成功"] && [StringChangeJson getValueForKey:kUser_id]  && moneyNum) {
                            
                            NSDictionary *dictionary = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"money":moneyNum};
                         
                            if ([StringChangeJson getValueForKey:kSessionToken]) {
                                _request = [[KongCVHttpRequest alloc]initWithRequests:kInsertWithdrawUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {
                                    
                                    NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
                                    
                                    if ([dic[@"state"] isEqualToString:@"ok"] ) {
                                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"提现成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                        [alertView show];
                                    }
                                }];
                            }
                        }
                    }];
                }
            }
      }
}

@end
