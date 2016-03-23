//
//  UserNameViewController.m
//  kongcv
//
//  Created by 空车位 on 16/1/14.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "UserNameViewController.h"

@interface UserNameViewController ()
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) UITextField *textField;
@end

@implementation UserNameViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"FiveteenPage"];
    
    self.navigationController.navigationBarHidden = NO;
    
    UIImage *image = [[UIImage alloc]init];
    UIImage *tabBarImage = [image scaleFromImage:[UIImage imageNamed:@"640h"] toSize:CGSizeMake(self.view.frame.size.width,64)];
    [self.navigationController.navigationBar setBackgroundImage:tabBarImage forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick endLogPageView:@"FiveteenPage"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(247,247,247);
    
    
    //[self initNav:@"修改昵称" andColor:RGB(247, 247, 247)];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,frameX, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,0,50,40)];
    label.text = @"昵称";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame),0,frameX - CGRectGetMaxX(label.frame),40)];
    if ([StringChangeJson getValueForKey:@"name"]) {
        _textField.text = [StringChangeJson getValueForKey:@"name"];
    }else{
        _textField.text = [StringChangeJson getValueForKey:kMobelNum];
    }
    _textField.clearsOnBeginEditing = YES;
    _textField.clearButtonMode  = UITextFieldViewModeAlways;
    [self.view addSubview:_textField];
    
    UIBarButtonItem *rightIten = [UIBarButtonItem itemWithTarget:self action:@selector(saveUserName) image:nil title:@"保存"];
    self.navigationItem.rightBarButtonItem = rightIten;
    
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftBack) image:@"fh" title:nil];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveUserName{
    if (_textField.text) {
        NSDictionary *dictionary =  @{@"mobilePhoneNumber":@"",@"user_name":_textField.text,@"device_token":@"", @"device_type":@"ios",@"license_plate":@"",@"version":@""};
        _request = [[KongCVHttpRequest alloc]initWithRequests:kChangeIphone sessionToken:[StringChangeJson getValueForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {
            NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
            if ([dic[@"msg"] isEqualToString:@"成功"]) {
                StringChangeJson *userName = [[StringChangeJson alloc]init];
                [userName saveValue:_textField.text key:@"name"];
                _block(_textField.text);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入昵称" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

@end
