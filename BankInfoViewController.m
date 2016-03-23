//
//  BankInfoViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/17.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "BankInfoViewController.h"
#import "BankCategoryViewController.h"
#import "NSString+Hashing.h"
#import "StringChangeJson.h"
#import "UIImageView+WebCache.h"
@interface BankInfoViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) KongCVHttpRequest *passwdRequest;
@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *cardTextField;
@property (nonatomic,strong) UIButton     *categoryBtn;
@property (nonatomic,strong) UITextField *screateTextField;
@property (nonatomic,strong) UITextField *configTextield;
@property (nonatomic,strong) UITextField *oldpasswdTextField;
@property (nonatomic,strong) NSDictionary *dictionary;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,copy)   NSString *bankString;
@property (nonatomic,strong) NSArray *bankArray;
@end

@implementation BankInfoViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"EightteenPage"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick endLogPageView:@"EightteenPage"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(247, 247, 247);
    
    if (self.string) {
        [self initNav:@"更改银行卡" andButton:@"fh" andColor:RGB(247, 247, 247)];
    }else{
        [self initNav:@"添加银行卡" andButton:@"fh" andColor:RGB(247, 247, 247)];
    }

    //银行卡信息
    if (self.bankDictionary) {
        self.bankArray = self.bankDictionary[@"bank_card"];
    }
    
    [self layoutUI];
}


- (void)layoutUI{
    self.scrollView = [[UIScrollView alloc]initWithFrame: CGRectMake(0, 64, frameX, frameY - 64-49)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = YES;
    self.scrollView.backgroundColor = RGB(247, 247, 247);
    [self.view addSubview:self.scrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.scrollView addGestureRecognizer:tap];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 4, frameX,49*3)];
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];
    
    for (int i = 0;i<4; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,4+49*i, frameX, 1)];
        imageview.image = [UIImage imageNamed:@"720@2x"];
        [self.scrollView addSubview:imageview];
    }
    
    //持卡人
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4,75, 49)];
    nameLabel.text = @"持卡人  :";
    [self.scrollView addSubview:nameLabel];
    
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), 4,frameX - CGRectGetMaxX(nameLabel.frame), 49)];
    if (self.string) {
        _nameTextField.text = [self.bankArray firstObject][@"name"];
    }else{
        _nameTextField.placeholder = @"姓名";
    }
    _nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:_nameTextField];

    //卡号
    UILabel *cardLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(nameLabel.frame),75, 49)];
    cardLabel.text = @"卡号     :";
    [self.scrollView addSubview:cardLabel];
    
    _cardTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cardLabel.frame),CGRectGetMaxY(nameLabel.frame),frameX - CGRectGetMaxX(cardLabel.frame), 49)];
    if (self.string) {
        _cardTextField.text = [self.bankArray firstObject][@"card"];
    }else{
        _cardTextField.placeholder = @"请输入卡号";
    }
    _cardTextField.delegate = self;
    _cardTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:_cardTextField];
    
    //类型
    UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(cardLabel.frame),75, 49)];
    categoryLabel.text = @"类型     :";
    [self.scrollView addSubview:categoryLabel];

    _categoryBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(categoryLabel.frame)+50, CGRectGetMaxY(cardLabel.frame), 190, 49) type:UIButtonTypeCustom title:@"" target:self action:@selector(categoriesBtnClick:)];

    NSString *string;
    if ([self.bankArray firstObject][@"bank"]) {
        string = [NSString stringWithFormat:@"%@",[self.bankArray firstObject][@"bank"]];
    }
    if (string.length != 0) {
        
        [_categoryBtn setTitle:string forState:UIControlStateNormal];
        
        if (_categoryBtn.titleLabel.text.length == 6) {
            
            _categoryBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-85, 0, 0);
            
        }else if (_categoryBtn.titleLabel.text.length == 4){
            
            _categoryBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-120, 0, 0);
            
        }
    }
    [self.scrollView addSubview:_categoryBtn];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(categoryLabel.frame)+10,CGRectGetMaxY(cardLabel.frame)+9.5,30, 30)];
    
    if ([StringChangeJson getValueForKey:@"url"]) {
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[StringChangeJson getValueForKey:@"url"]]];
        
    }else if(self.bankArray){
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[self.bankArray firstObject][@"bank_icon"]]];
        
    }
    [self.scrollView addSubview:_imageView];
    
    //设置密码
    UILabel *mimaLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(categoryLabel.frame),200, 22)];
    mimaLabel.text = @"请设置提现密码";
    mimaLabel.font = UIFont(16);
    [self.scrollView addSubview:mimaLabel];
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(mimaLabel.frame), frameX,49*2)];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:bgview];
    
    UIImageView *imageview;
    for (int i = 0;i<3; i++) {
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(mimaLabel.frame)+49*i, frameX, 1)];
        imageview.image = [UIImage imageNamed:@"720@2x"];
        [self.scrollView addSubview:imageview];
    }
    
    
    //shezhi密码
    UILabel *screateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(mimaLabel.frame),83, 49)];
    screateLabel.text = @"请输入     :";
    [self.scrollView addSubview:screateLabel];
    
    _screateTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(screateLabel.frame),CGRectGetMaxY(mimaLabel.frame),190, 49)];
    _screateTextField.placeholder = @"请输入密码";
    _screateTextField.secureTextEntry = YES;
    [self.scrollView addSubview:_screateTextField];
    
    //确认密码
    UILabel *configLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(screateLabel.frame),83, 49)];
    configLabel.text = @"再次输入 :";
    [self.scrollView addSubview:configLabel];
    
    _configTextield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(configLabel.frame),CGRectGetMaxY(screateLabel.frame),190, 49)];
    _configTextield.placeholder = @"请再次输入密码";
    _configTextield.secureTextEntry = YES;
    [self.scrollView addSubview:_configTextield];

    
    if (self.string) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageview.frame),frameX,49)];
        view.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:view];
        
        UILabel *oldPasswdlabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(configLabel.frame),83,49)];
        oldPasswdlabel.text = @"旧密码     :";
        [self.scrollView addSubview:oldPasswdlabel];
        
        _oldpasswdTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(oldPasswdlabel.frame),CGRectGetMaxY(configLabel.frame),190,49)];
        _oldpasswdTextField.placeholder = @"请输入旧密码";
        _oldpasswdTextField.secureTextEntry = YES;
        [self.scrollView addSubview:_oldpasswdTextField];
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_oldpasswdTextField.frame), frameX, 1)];
        imageview.image = [UIImage imageNamed:@"720@2x"];
        [self.scrollView addSubview:imageview];
        
        //确认提交
        UIButton *configBtn = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_oldpasswdTextField.frame)+26,frameX-20, 45) type:UIButtonTypeCustom title:@" 更        改" target:self action:@selector(configBtnConfig:)];
        configBtn.backgroundColor = RGB(247, 156, 0);
        configBtn.layer.masksToBounds = YES;
        configBtn.layer.cornerRadius = 5.0;
        [self.scrollView addSubview:configBtn];
    }else if(self.string.length == 0){
        //确认提交
        UIButton *configBtn = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_configTextield.frame)+26,frameX-20, 45) type:UIButtonTypeCustom title:@" 提        交" target:self action:@selector(configBtnConfig:)];
        configBtn.backgroundColor = RGB(247, 156, 0);
        configBtn.layer.masksToBounds = YES;
        configBtn.layer.cornerRadius = 5.0;
        [self.scrollView addSubview:configBtn];
    }
    
    if (frameX == 320.0 ) {
        self.scrollView.contentSize = CGSizeMake(0,CGRectGetMaxY(configLabel.frame)+450);
    }
}

#pragma mark --- <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_nameTextField resignFirstResponder];
    [_cardTextField resignFirstResponder];
    [_screateTextField resignFirstResponder];
    [_configTextield resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual:_cardTextField]) {
        
        if (toBeString.length >=  21 && range.length !=1) {
            
            textField.text = [toBeString substringToIndex:21];
            
            return NO;
        }
    }
    
    return YES;
}

- (void)categoriesBtnClick:(UIButton *)btn{
    BankCategoryViewController *bankController = [[BankCategoryViewController alloc]init];
    bankController.block = ^(NSDictionary *dic){
        [_categoryBtn setTitle:dic[@"key"] forState:UIControlStateNormal];
        if (_categoryBtn.titleLabel.text.length == 6) {
             _categoryBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-85, 0, 0);
        }else if (_categoryBtn.titleLabel.text.length == 4){
             _categoryBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-120, 0, 0);
        }
        [_imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"url"]]];
        StringChangeJson *json = [[StringChangeJson alloc]init];
        [json saveValue:dic[@"url"] key:@"url"];
        _bankString = dic[@"url"];
    };
    [self.navigationController pushViewController:bankController animated:YES];
}

//提交银行信息
- (void)configBtnConfig:(UIButton *)btn{
    
    NSString *preString = @"^[a-zA-Z\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",preString];
    
    //银行卡操作
    NSString *action ;
    if (_nameTextField.text.length == 0|| _cardTextField.text.length == 0 || _categoryBtn.titleLabel.text.length == 0 || _screateTextField.text.length == 0 || _configTextield.text.length == 0) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请填写完整信息" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
    }else{
        //判断是什么操作
        if (self.bankDictionary.count == 0) {
            action = @"new";
        }else if (self.bankDictionary.count != 0 ){
            if ([[NSString stringWithFormat:@"%@",[self.bankArray firstObject][@"bank"]] isEqualToString:_categoryBtn.titleLabel.text] && [[self.bankArray firstObject][@"name"]isEqualToString:_nameTextField.text] && [[self.bankArray firstObject][@"card"] isEqualToString:_cardTextField.text]) {
                if ( ![[[_screateTextField.text MD5Hash] lowercaseString] isEqualToString:self.bankDictionary[@"passwd"]]) {
                    
                    action = @"passwd";
                }
            }else if ( ![[self.bankArray firstObject][@"card"] isEqualToString:_categoryBtn.titleLabel.text]  || ![[self.bankArray firstObject][@"name"]isEqualToString:_nameTextField.text]  || ![[NSString stringWithFormat:@"%@",[self.bankArray firstObject][@"bank"]] isEqualToString:_cardTextField.text]){
                if ([self.bankDictionary[@"passwd"] isEqualToString:[[_screateTextField.text MD5Hash] lowercaseString]]) {
                    action = @"card";
                }else if (![self.bankDictionary[@"passwd"] isEqualToString:[[_screateTextField.text MD5Hash] lowercaseString]]){
                    action = @"new";
                }
            }
         }
    }
    
    
    //NSLog(@"%@",action);
    if ([_screateTextField.text isEqualToString:_configTextield.text]) {
        if (![pred evaluateWithObject:_nameTextField.text]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"不支持特殊字符"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            
            if (self.bankDictionary) {
                //先校验密码是否正确
                NSString *passwdMD5 = [[_oldpasswdTextField.text MD5Hash] lowercaseString];
                NSDictionary   *passwdDic = @{@"user_id":[StringChangeJson getValueForKey:kUser_id], @"passwd":passwdMD5};
                
                _passwdRequest = [[KongCVHttpRequest alloc]initWithRequests:kVerifyPassWordUrl sessionToken:[StringChangeJson getValueForKey:kSessionToken] dictionary:passwdDic andBlock:^(NSDictionary *data) {
                    
                    NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
                    
                    if ([dic[@"msg"] isEqualToString:@"成功"]) {
                        
                        NSString *screateString = [[_configTextield.text MD5Hash] lowercaseString];

                        NSDictionary *dictionary = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"bank_card":@{@"bank":_categoryBtn.titleLabel.text,@"card":_cardTextField.text,@"name":_nameTextField.text,@"bank_icon":[NSString stringWithFormat:@"%@",[StringChangeJson getValueForKey:@"url"]]},@"passwd":screateString,@"action":action};
                            
                        [self submitBankInfo:dictionary];

                
                    }else{
                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请再次输入旧密码" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                    
                }];
            }else{
                
                NSString *screateString = [[_configTextield.text MD5Hash] lowercaseString];
                
                NSDictionary *dictionary;
                if ([StringChangeJson getValueForKey:@"url"]) {
                      dictionary = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"bank_card":@{@"bank":_categoryBtn.titleLabel.text,@"card":_cardTextField.text,@"name":_nameTextField.text,@"bank_icon":[StringChangeJson getValueForKey:@"url"]},@"passwd":screateString,@"action":action};
                }
                
                [self submitBankInfo:dictionary];
                
            }
        }
    }

}


- (void)tapClick:(UITapGestureRecognizer *)tap{
    [_nameTextField resignFirstResponder];
    [_cardTextField resignFirstResponder];
    [_screateTextField resignFirstResponder];
    [_configTextield resignFirstResponder];
}

- (void)submitBankInfo:(NSDictionary *)dic{
    
    _request = [[KongCVHttpRequest alloc]initWithRequests:kInsertPurse sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
        
        //NSLog(@"%@",data[@"result"]);
        
        NSDictionary *dictionary = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
        
        if ([dictionary[@"msg"] isEqualToString:@"成功"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadBank" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];

}

@end
