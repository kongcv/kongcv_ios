//
//  ChangePhoneNumViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/23.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "ChangePhoneNumViewController.h"
#import "RecvCodeViewController.h"
#import "AFNetworking.h"
#import "FiledViewController.h"
#import "UIImage+navationBar.h"
@interface ChangePhoneNumViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) KongCVHttpRequest *request;
@end

@implementation ChangePhoneNumViewController

-(void)viewWillAppear:(BOOL)animated{
//      self.navigationController.navigationBar.hidden = NO;
//    UIImage *image = [[UIImage alloc]init];
//    UIImage *tabBarImage = [image scaleFromImage:[UIImage imageNamed:@"矩形"] toSize:CGSizeMake(self.view.frame.size.width,64)];
//    [self.navigationController.navigationBar setBackgroundImage:tabBarImage forBarMetrics:UIBarMetricsDefault];

    [super viewWillAppear:animated];

    [MobClick beginLogPageView:@"Twenty-NinePage"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"Twenty-NinePage"];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(247, 247, 247);
    
    [self initNav:@"更改手机号" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    [self layoutUI];
}


- (void)layoutUI{

    
    UIView *View =[[UIView alloc]initWithFrame:CGRectMake(0,12+64,frameX,76*frameX/320.0)];
    View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:View];
    
    UIImageView *imageView;
    for (int i = 0; i<2; i++) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,12+64+76*i*frameX/320.0,frameX,1)];
        imageView.image = [UIImage imageNamed:@"720"];
        [self.view addSubview:imageView];
    }
    
    UIView *newView =[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame)+4,frameX,44)];
    newView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:newView];
    
    //流程图
    NSArray *array = @[@"绑定手机",@"接收验证码",@"绑定成功"];
    UIImageView *imageViewYaun;
    for (int i = 0; i<3; i++) {
        imageViewYaun = [[UIImageView alloc]init];
        imageViewYaun.frame = CGRectMake(33*frameX/320.0+(27*frameX/320.0+86.5*frameX/320.0)*i,25+64,27*frameX/320.0, 27*frameX/320.0);
        imageViewYaun.image = [UIImage imageNamed:@"btn_deafult"];
        [self.view addSubview:imageViewYaun];
        
        UILabel *label = [[UILabel alloc]init];
        if (frameX == 375.0) {
            label.frame =  CGRectMake(12*frameX/320.0+(70*frameX/320.0+45*frameX/320.0)*i,CGRectGetMaxY(imageViewYaun.frame)+3*frameX/320.0,70,30);
        }else if(frameX == 414.0  ){
             label.frame =  CGRectMake(18*frameX/320.0+(70*frameX/320.0+45*frameX/320.0)*i,CGRectGetMaxY(imageViewYaun.frame)+3*frameX/320.0,70,30);
        }else if (frameX == 320.0){
            label.frame =  CGRectMake(10*frameX/320.0+(70*frameX/320.0+45*frameX/320.0)*i,CGRectGetMaxY(imageViewYaun.frame)+3*frameX/320.0,70,30);
        }
        label.backgroundColor = [UIColor whiteColor];
        if (i== 0) {
            label.textColor = RGB(255, 156, 0);
            imageViewYaun.image = [UIImage imageNamed:@"icon_yuandian"];
        }else{
            label.textColor = RGB(68, 68, 68);
        }
        label.text = array[i];
        label.font = UIFont(14);
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
    
    //横线
    for (int i = 0; i<2; i++) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake((33+30)*frameX/320.0+i*(80.5*frameX/320.0+33*frameX/320.0),CGRectGetMaxY(imageViewYaun.frame)-imageViewYaun.frame.size.height/2,80.5*frameX/320.0,1)];
            view.backgroundColor = RGB(68,68, 0);
            [self.view addSubview:view];
    }
    

    //
    for (int i = 0; i<2; i++) {
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame)+4+44*i,frameX,1)];
        imageView1.image = [UIImage imageNamed:@"720"];
        [self.view addSubview:imageView1];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+4,104,44)];
    label.text = @"新绑定手机号";
    label.font = UIFont(15);
    label.textColor = RGB(68,68,68);       
    [self.view addSubview:label];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+12, CGRectGetMaxY(imageView.frame)+4,190,44)];
    _textField = textField;
    textField.delegate = self;
    textField.placeholder = [NSString stringWithFormat:@"已绑定的手机号%@",[[NSUserDefaults standardUserDefaults]objectForKey:kMobelNum]];
    textField.font = UIFont(14);
    [self.view addSubview:textField];
 
    
    //下一步
    UIView *nextView =[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(label.frame)+88,frameX,34)];
    nextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nextView];
    
    for (int i = 0; i<2; i++) {
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(label.frame)+88+34*i,frameX,1)];
        imageView1.image = [UIImage imageNamed:@"720"];
        [self.view addSubview:imageView1];
    }
    
    UIButton *nextBtn = [UIButton buttonWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+88,frameX,34*frameX/320.0) type:UIButtonTypeCustom title:@"下  一  步" target:self action:@selector(nextBtnClick:)];
    [nextBtn setTitleColor:RGB(255, 156, 0) forState:UIControlStateNormal];
    nextBtn.titleLabel.font = UIFont(18);
    [self.view addSubview:nextBtn];
    
}

- (void)nextBtnClick:(UIButton *)btn{
    
    
    if (_textField.text.length  != 0) {
      
        if ([StringChangeJson getValueForKey:kSessionToken]) {
            
            NSString *registerId = [StringChangeJson getValueForKey:kRegistationID];
            
            if (registerId.length == 0) {
                
                registerId = @"";
                
            }
            
            //修改用户列表
            NSDictionary *dic = @{@"mobilePhoneNumber":_textField.text,@"user_name":@"",@"device_token":registerId, @"device_type":@"ios",@"license_plate":@"",@"version":@""};
            
            _request = [[KongCVHttpRequest alloc]initWithRequests:kChangeIphone sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
                
                NSDictionary *diction = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
                
                if ([diction[@"msg"] isEqualToString:@"成功"]) {
                
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"发送成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alertView show];
                    
                }
                
            }];
    
            RecvCodeViewController *recvController = [[RecvCodeViewController alloc]init];
            
            recvController.phoneString = _textField.text;
            
            [self.navigationController pushViewController:recvController animated:YES];
            
        }
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
}
@end
