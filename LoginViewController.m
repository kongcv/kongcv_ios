//
//  LoginViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/10/20.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "LoginViewController.h"

#import "ZHXDataCache.h"

#import "ProtoViewController.h"

#import "NSString+Hashing.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) UILabel *iphoneLabel;

@property(nonatomic,strong) UILabel *checkCodeLabel;

@property(nonatomic,strong) UITextField *iphoneTextField;

@property(nonatomic,strong) UITextField *checkTextField;

@property(nonatomic,strong) UIButton *checkCodeBt;

@property(nonatomic,strong) UIButton *landBt;

@property(nonatomic,strong) KongCvHttp *requestManger;

@property(nonatomic,strong) KongCVHttpRequest *request;

//协议Button
@property(nonatomic,strong) UIButton *protocolBt;

@property(nonatomic,strong) NSDictionary *dict;

@property(nonatomic,strong) StringChangeJson *stringJson;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    
    UIImage *image = [[UIImage alloc]init];
    
    UIImage *tabBarImage = [image scaleFromImage:[UIImage imageNamed:@"640h"] toSize:CGSizeMake(self.view.frame.size.width,64)];
    
    [self.navigationController.navigationBar setBackgroundImage:tabBarImage forBarMetrics:UIBarMetricsDefault];
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"Threty-threePage"];
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"Threty-threePage"];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:247/256.0 green:247/256.0 blue:247/256.0 alpha:1.0];
    
    [self prepareUI];
    
    self.navigationItem.title = @"注册";
    
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(barClick) image:@"default1" title:nil];
    
    self.navigationItem.leftBarButtonItem = leftItem;

    self.stringJson = [[StringChangeJson alloc]init];
    
}


#pragma mark --- barClick
- (void)barClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)prepareUI{
    
    //logo图标
    UIImage *logoImage = [UIImage imageNamed:@"logo"];
    UIImageView *logoImageView = [[UIImageView alloc]init];
    
    if (frameX != 414) {
        UIButton *button = [UIButton buttonWithFrame:CGRectMake(15,18,85,45) type:UIButtonTypeCustom title:nil target:self action:@selector(barClick)];
        [button setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
        [self.view addSubview:button];

        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frameX/2-35, 28.75,70, 30)];
        label.text = @"登陆";
        label.textColor = [UIColor colorWithRed:43/256.0 green:43/256.0 blue:43/256.0 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = UIFont(23);
        [self.view addSubview:label];
        
        logoImageView.frame = CGRectMake(frameX/2-150/2,71-44,150,150);
        logoImageView.image = logoImage;
        [self.view addSubview:logoImageView];
        
        UIImageView *iphoneImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(logoImageView.frame)+10, frameX-10, 30*frameY/480.0)];
        iphoneImage.image = [UIImage imageNamed:@"圆角矩形-1-拷贝-4@3x"];
        [self.view addSubview:iphoneImage];
        
        self.iphoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(logoImageView.frame)+10,60,30*frameY/480.0)];
        self.iphoneLabel.text = @"手机号";
        _iphoneLabel.textColor = [UIColor colorWithRed:43/256.0 green:43/256.0 blue:43/256.0 alpha:1.0];
        [self.view addSubview:_iphoneLabel];
        
        self.iphoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iphoneLabel.frame), CGRectGetMaxY(logoImageView.frame)+10, frameX-20-60, 30*frameY/480.0)];
        self.iphoneTextField.placeholder = @"请输入手机号码";
        [self.view addSubview:_iphoneTextField];
        
        
        UIImageView *checkImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(iphoneImage.frame)+9.2, frameX-90, 30*frameY/480.0)];
        checkImage.image = [UIImage imageNamed:@"圆角矩形-1-拷贝-4@3x"];
        [self.view addSubview:checkImage];
        
        
        self.checkCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(iphoneImage.frame)+9.2, 60, 30*frameY/480.0)];
        self.checkCodeLabel.textColor = [UIColor colorWithRed:43/256.0 green:43/256.0 blue:43/256.0 alpha:1.0];
        self.checkCodeLabel.text = @"验证码";
        [self.view addSubview:self.checkCodeLabel];
        
        self.checkTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.checkCodeLabel.frame), CGRectGetMaxY(iphoneImage.frame)+9.2,checkImage.frame.size.width - 65, 30*frameY/480.0)];
        self.checkTextField.placeholder = @"验证码";
        [self.view addSubview:self.checkTextField];
        
        self.checkCodeBt = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(_checkTextField.frame)+4.3, CGRectGetMaxY(iphoneImage.frame)+9.2, 75, 30*frameY/480.0) type:UIButtonTypeCustom title:@"短信验证" target:self action:@selector(btnClick:)];
        [self.checkCodeBt setTitleColor:[UIColor colorWithRed:106/256.0 green:106/256.0 blue:106/256.0 alpha:1.0] forState:UIControlStateNormal];
        [self.checkCodeBt setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1-验证码界面"] forState:UIControlStateNormal];
        [self.view addSubview:_checkCodeBt];
        
        UILabel *serlabel;
        if (frameX == 375.0) {
            serlabel = [[UILabel alloc]initWithFrame:CGRectMake(33,CGRectGetMaxY(_checkTextField.frame)+24.2,100, 20)];
        }else if(frameX == 320.0 ){
            serlabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_checkTextField.frame)+24.2,100, 20)];
        }
        serlabel.text = @"注册代表您同意";
        serlabel.font = UIFont(14);
        serlabel.textColor = RGB(169, 169, 169);
        serlabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:serlabel];

        
        //协议
        self.protocolBt = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(serlabel.frame)-2, CGRectGetMaxY(_checkTextField.frame)+24.2,130,20) type:UIButtonTypeCustom title:@"空车位网络使用协议" target:self action:@selector(protocolBtClick:)];
        self.protocolBt.titleLabel.font = UIFont(14);
        [self.protocolBt setTitleColor:RGB(148,202,228) forState:UIControlStateNormal];
        self.protocolBt.titleEdgeInsets = UIEdgeInsetsMake(0, 0,0,0);
        //self.protocolBt.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:self.protocolBt];
        
        UILabel *heLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.protocolBt.frame)-2,CGRectGetMaxY(_checkTextField.frame)+24.2,15,20)];
        heLabel.text = @"和";
        heLabel.font = UIFont(14);
        heLabel.textColor = RGB(169, 169, 169);
        [self.view addSubview:heLabel];
        
        UIButton *serviceBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(heLabel.frame)-2, CGRectGetMaxY(_checkTextField.frame)+24.2,60,20) type:UIButtonTypeCustom title:@"隐私条款" target:self action:@selector(serviceBtnClick:)];
        [serviceBtn setTitleColor:RGB(148,202,228) forState:UIControlStateNormal];
        serviceBtn.titleLabel.font = UIFont(14);
        [self.view addSubview:serviceBtn];
        
        
        //登陆
        self.landBt = [UIButton buttonWithFrame:CGRectMake(15, CGRectGetMaxY(_protocolBt.frame)+6.7, frameX-30*frameX/320.0, 35*frameY/480.0) type:UIButtonTypeCustom title:@"登陆" target:self action:@selector(landBtClick:)];
        self.landBt.backgroundColor = [UIColor colorWithRed:255/256.0 green:147/256.0 blue:0 alpha:1.0];
        self.landBt.layer.masksToBounds = YES;
        self.landBt.layer.cornerRadius = 5.0;
        self.landBt.titleLabel.font = UIFont(21);
        [self.view addSubview:self.landBt];
        
    }else{
    /****************************************************************************************************/
        UIButton *button = [UIButton buttonWithFrame:CGRectMake(15,30,75,45) type:UIButtonTypeCustom title:nil target:self action:@selector(barClick)];
        [button setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
        [self.view addSubview:button];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frameX/2-35,41.4,70, 30)];
        label.text = @"登陆";
        label.textColor = [UIColor colorWithRed:43/256.0 green:43/256.0 blue:43/256.0 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = UIFont(23);
        [self.view addSubview:label];
        
        logoImageView.frame = CGRectMake(frameX/2-150*frameX/320.0/2,104.8,150*frameX/320.0,150*frameX/320.0);
        logoImageView.image = logoImage;
        [self.view addSubview:logoImageView];
        
        UIImageView *iphoneImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(logoImageView.frame)+10, frameX-10, 35*frameY/480.0)];
        iphoneImage.image = [UIImage imageNamed:@"圆角矩形-1-拷贝-4@3x"];
        [self.view addSubview:iphoneImage];
        
        self.iphoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(logoImageView.frame)+10,60,35*frameY/480.0)];
        self.iphoneLabel.text = @"手机号";
        self.iphoneLabel.font = UIFont(19);
        _iphoneLabel.textColor = [UIColor colorWithRed:43/256.0 green:43/256.0 blue:43/256.0 alpha:1.0];
        [self.view addSubview:_iphoneLabel];
        
        self.iphoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iphoneLabel.frame)+5, CGRectGetMaxY(logoImageView.frame)+10, frameX-20-60, 35*frameY/480.0)];
        self.iphoneTextField.placeholder = @"请输入手机号码";
        [self.view addSubview:_iphoneTextField];
        
        
        UIImageView *checkImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(iphoneImage.frame)+13.2, frameX-90, 35*frameY/480.0)];
        checkImage.image = [UIImage imageNamed:@"圆角矩形-1-拷贝-4@3x"];
        [self.view addSubview:checkImage];
        
        
        self.checkCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(iphoneImage.frame)+13.2, 60, 35*frameY/480.0)];
        self.checkCodeLabel.textColor = [UIColor colorWithRed:43/256.0 green:43/256.0 blue:43/256.0 alpha:1.0];
        self.checkCodeLabel.text = @"验证码";
        self.checkCodeLabel.font = UIFont(19);
        [self.view addSubview:self.checkCodeLabel];
        
        self.checkTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.checkCodeLabel.frame)+5, CGRectGetMaxY(iphoneImage.frame)+8*frameY/480.0,checkImage.frame.size.width - 75, 35*frameY/480.0)];
        self.checkTextField.placeholder = @"验证码";
        //self.checkTextField.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:self.checkTextField];
        
        self.checkCodeBt = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(_checkTextField.frame)+6.2, CGRectGetMaxY(iphoneImage.frame)+8*frameY/480.0, 80, 35*frameY/480.0) type:UIButtonTypeCustom title:@"短信验证" target:self action:@selector(btnClick:)];
        self.checkCodeBt.titleLabel.font = UIFont(18);
        [self.checkCodeBt setTitleColor:[UIColor colorWithRed:106/256.0 green:106/256.0 blue:106/256.0 alpha:1.0] forState:UIControlStateNormal];
        [self.checkCodeBt setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1-验证码界面"] forState:UIControlStateNormal];
        //self.checkCodeBt.backgroundColor = [UIColor redColor];
        [self.view addSubview:_checkCodeBt];
        
    
        
        UILabel *serlabel = [[UILabel alloc]initWithFrame:CGRectMake(54,CGRectGetMaxY(_checkTextField.frame)+28,100, 20)];
        serlabel.text = @"注册代表您同意";
        serlabel.font = UIFont(14);
        serlabel.textColor = RGB(169, 169, 169);
        serlabel.textAlignment = NSTextAlignmentRight;
        //serlabel.backgroundColor = [UIColor redColor];
        [self.view addSubview:serlabel];
        
        //协议
        self.protocolBt = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(serlabel.frame)-2, CGRectGetMaxY(_checkTextField.frame)+28,130,20) type:UIButtonTypeCustom title:@"空车位网络使用协议" target:self action:@selector(protocolBtClick:)];
        self.protocolBt.titleLabel.font = UIFont(14);
        [self.protocolBt setTitleColor:RGB(148,202,228) forState:UIControlStateNormal];
        self.protocolBt.titleEdgeInsets = UIEdgeInsetsMake(0, 0,0,0);
        //self.protocolBt.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:self.protocolBt];
        
        UILabel *heLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.protocolBt.frame)-2,CGRectGetMaxY(_checkTextField.frame)+28,15,20)];
        heLabel.text = @"和";
        heLabel.font = UIFont(14);
        heLabel.textColor = RGB(169, 169, 169);
        [self.view addSubview:heLabel];
        
        UIButton *serviceBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(heLabel.frame)-2, CGRectGetMaxY(_checkTextField.frame)+28,60,20) type:UIButtonTypeCustom title:@"隐私条款" target:self action:@selector(serviceBtnClick:)];
        [serviceBtn setTitleColor:RGB(148,202,228) forState:UIControlStateNormal];
        serviceBtn.titleLabel.font = UIFont(14);
        [self.view addSubview:serviceBtn];
        
        //登陆
        self.landBt = [UIButton buttonWithFrame:CGRectMake(48.5, CGRectGetMaxY(_protocolBt.frame)+10.3, frameX-97, 35*frameY/480.0) type:UIButtonTypeCustom title:@"登陆" target:self action:@selector(landBtClick:)];
        self.landBt.backgroundColor = [UIColor colorWithRed:255/256.0 green:156/256.0 blue:0 alpha:1.0];
        self.landBt.layer.masksToBounds = YES;
        self.landBt.layer.cornerRadius = 5.0;
        self.landBt.titleLabel.font = UIFont(21);
        [self.view addSubview:self.landBt];
        
    }

    
    
}

//获取验证码
- (void)btnClick:(UIButton*)btn{
    
    [self resignResponder];
    
    if (_iphoneTextField.text.length == 0) {
        
        UIAlertViewShow(@"请输入电话号码");
        
    }else{
        
        //倒计时
        [self timeCountDown];
        
        NSDictionary *dictionary = @{@"mobilePhoneNumber":self.iphoneTextField.text};
    
        self.requestManger = [[KongCvHttp alloc]initWithRequests:kCheckCodeUrl dictionary:dictionary andBlock:^(NSDictionary *data) {
            
            [self.stringJson saveValue:self.iphoneTextField.text key:kMobelNum];
            
      }];
    }
}

//倒计时
- (void)timeCountDown
{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _checkCodeBt.userInteractionEnabled = YES;
                //_checkCodeBt.backgroundColor = [UIColor lightGrayColor];
                [_checkCodeBt setTitle:@"短信验证" forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%ds", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                _checkCodeBt.userInteractionEnabled = NO;
                //_checkCodeBt.backgroundColor = [UIColor lightGrayColor];
               
                [_checkCodeBt setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

//注册登录
- (void)landBtClick:(UIButton *)btn{
    
    [self resignResponder];
    
    if (_iphoneTextField.text.length == 0 || _checkTextField.text.length == 0) {
        
        UIAlertViewShow(@"请填写信息");
        
    }else{
    
        //登录
    NSDictionary *diction = @{@"mobilePhoneNumber":self.iphoneTextField.text,@"smsCode":self.checkTextField.text};
        
    self.requestManger = [[KongCvHttp alloc]initWithRequests:kLoginUrl dictionary:diction andBlock:^(NSDictionary *data) {

       self.dict = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
        
        if (_dict[@"sessionToken"]) {
            
            [self.stringJson saveValue:_dict[@"sessionToken"] key:kSessionToken];
            
            [self.stringJson saveValue:self.iphoneTextField.text key:kMobelNum];
            
        }
        
        //保存sessionToken  user_id
        if ([_dict[@"msg"] isEqualToString:@"成功"]) {

            NSString *str = [StringChangeJson getValueForKey:kRegistationID];
            
            if (str.length == 0) {
                
                str = @"";
                
            }
            
            //修改用户列表 上传RegisterId
            if ([StringChangeJson getValueForKey:kRegistationID]) {
            
                NSDictionary *dic = @{@"mobilePhoneNumber":self.iphoneTextField.text,
                                                           @"user_name":@"",
                                                           @"device_token":str,
                                                           @"device_type":@"ios",
                                                           @"city":[StringChangeJson getValueForKey:@"city"]};
                
                _request = [[KongCVHttpRequest alloc]initWithRequests:kChangeIphone sessionToken:_dict[@"sessionToken"] dictionary:dic andBlock:^(NSDictionary *data) {
                    
                }];
                
            }
            
            //获取用户信息
            [self getVersion:_dict[@"user_id"]];
            
        }
        
     }];
        
    }
    
}

//取消第一响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self resignResponder];
    
}

- (void)resignResponder{
    
    [self.iphoneTextField resignFirstResponder];
    
    [self.checkTextField resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}


//获取版本号
- (void)getVersion:(NSString *)userid{
    
    NSString *version =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    if ([StringChangeJson getValueForKey:kMobelNum ]) {
        
    }
    
    NSDictionary *dic = @{@"mobilePhoneNumber":[StringChangeJson getValueForKey:kMobelNum ],@"user_id":userid};

    self.request = [[KongCVHttpRequest alloc]initWithRequests:kGetUserInfoUrl sessionToken:[StringChangeJson getValueForKey:kSessionToken ] dictionary:dic andBlock:^(NSDictionary *data) {
        
        NSDictionary *dic = data[@"result"];

        //保存用户名 头像 电话号码 等信息
        [self.stringJson saveValue:dic[@"username"] key:@"username"];
        
        [self.stringJson saveValue:dic[@"image"][@"url"] key:@"image"];
        
        [self.stringJson saveValue:dic[@"mobilePhoneNumber"] key:@"mobilePhoneNumber"];
        
        [self.stringJson saveValue:self.dict[@"sessionToken"] key:kSessionToken];
        
        [self.stringJson saveValue:self.dict[@"user_id"] key:kUser_id];
        
        kNSNotification(@"refresh");
        
        [self.navigationController popViewControllerAnimated:YES];
        
        //更新版本号
        if (![version isEqualToString:data[@"version"]]) {
            
            NSDictionary *dictionary = @{@"mobilePhoneNumber":@"",
                                                                    @"user_name":@"",
                                                                    @"device_token":@"",
                                                                    @"device_type":@"ios",
                                                                     @"license_plate":@"",
                                                                    @"version":version};
            
            self.request = [[KongCVHttpRequest alloc]initWithRequests:kChangeIphone sessionToken:[StringChangeJson getValueForKey:kSessionToken ] dictionary:dictionary andBlock:^(NSDictionary *data) {

            }];
        }
        
    }];
}

//空车位用户协议
- (void)protocolBtClick:(UIButton *)btn{
    
    self.requestManger = [[KongCvHttp alloc]initWithRequests:kServiceUrl dictionary:nil andBlock:^(NSDictionary *data) {
    
        NSArray *array = data[@"result"];

        NSString *urlString = array[0][@"service_file"][@"url"];
 
        ProtoViewController *controller = [[ProtoViewController alloc]init];
        
        controller.url = urlString;
        
        [self.navigationController pushViewController:controller animated:YES];
        
   }];
    
}

- (void)serviceBtnClick:(UIButton *)btn{
    
    self.requestManger = [[KongCvHttp alloc]initWithRequests:kServiceUrl dictionary:nil andBlock:^(NSDictionary *data) {
        
        NSArray *array = data[@"result"];
        
        NSString *urlString = array[1][@"service_file"][@"url"];
        
        ProtoViewController *controller = [[ProtoViewController alloc]init];
        
        controller.url = urlString;
        
        [self.navigationController pushViewController:controller animated:YES];
        
    }];
    
}

@end
