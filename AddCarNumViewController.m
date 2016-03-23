//
//  AddCarNumViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/23.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "AddCarNumViewController.h"
#import "AFNetworking.h"
@interface AddCarNumViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) UITextField *textField;
@end

@implementation AddCarNumViewController
- (void)viewWillAppear:(BOOL)animated{
    
    UIImage *image = [[UIImage alloc]init];
    UIImage *tabBarImage = [image scaleFromImage:[UIImage imageNamed:@"640h"] toSize:CGSizeMake(self.view.frame.size.width,64)];
    [self.navigationController.navigationBar setBackgroundImage:tabBarImage forBarMetrics:UIBarMetricsDefault];
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"Twenty-EightPage"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"Twenty-EightPage"];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(247, 247, 247);
    
    [self initNav:@"车牌号" andButton:@"fh" andColor:RGB(247, 247, 247)];

    UIButton *button = [UIButton buttonWithFrame:CGRectMake(frameX -60,20,50,40) type:UIButtonTypeCustom title:@"保存" target:self action:@selector(addSever)];
    [button setTitleColor:[UIColor blackColor ] forState:UIControlStateNormal];
    button.titleLabel.font = UIFont(19);
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:button];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10+64, frameX, 44)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    for (int i = 0; i<2; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,64+9+44*i, frameX, 1)];
        imageView.image = [UIImage imageNamed:@"720"];
        [self.view addSubview:imageView];
    }
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10+64, frameX-10, 44)];
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.placeholder = @"请输入车牌号";
    _textField.delegate = self;
    [self.view addSubview:_textField];
    
}


- (void)addSever{
    //修改用户列表
    if ([StringChangeJson getValueForKey:kMobelNum] && _textField.text ) {
        NSDictionary *dic =@{@"mobilePhoneNumber":[[NSUserDefaults standardUserDefaults]objectForKey:kMobelNum],@"user_name":@"",@"device_token":@"", @"device_type":@"ios",@"license_plate":_textField.text};
        if ([StringChangeJson getValueForKey:kMobelNum]) {
            _request = [[KongCVHttpRequest alloc]initWithRequests:kChangeIphone sessionToken:[StringChangeJson getValueForKey:kSessionToken] dictionary:dic  andBlock:^(NSDictionary *data) {
                NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
                if ([dic[@"msg"] isEqualToString:@"成功"]) {
                    
                    StringChangeJson *stringJson = [[StringChangeJson alloc]init];
                    [stringJson saveValue:_textField.text key:@"license_plate"];
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请您注册!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
}

@end
