//
//  RecvCodeViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/23.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "RecvCodeViewController.h"
#import "FinishViewController.h"
#import "FiledViewController.h"
#import "AFNetworking.h"
@interface RecvCodeViewController ()
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) KongCVHttpRequest *request;
@end

@implementation RecvCodeViewController

-(void)viewWillAppear:(BOOL)animated{
    
     [super viewWillAppear:animated];

     [MobClick beginLogPageView:@"ThretyPage"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"ThretyPage"];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(247, 247, 247);
    
    [self initNav:@"更改手机号" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    UIView *View =[[UIView alloc]initWithFrame:CGRectMake(0,12+64,frameX,76)];
    View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:View];
    
    UIImageView *imageView;
    for (int i = 0; i<2; i++) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,12+64+76*i,frameX,1)];
        imageView.image = [UIImage imageNamed:@"720"];
        [self.view addSubview:imageView];
    }
    
    //流程图
    NSArray *array = @[@"绑定手机",@"接收验证码",@"绑定成功"];
    UIImageView *imageViewYaun;
    for (int i = 0; i<3; i++) {
        imageViewYaun = [[UIImageView alloc]init];
        imageViewYaun.frame = CGRectMake(33*frameX/320.0+(27*frameX/320.0+86.5*frameX/320.0)*i,25+64,27*frameX/320.0, 27*frameX/320.0);
        imageViewYaun.image = [UIImage imageNamed:@"btn_deafult"];
        [self.view addSubview:imageViewYaun];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10*frameX/320.0+(70*frameX/320.0+45*frameX/320.0)*i,CGRectGetMaxY(imageViewYaun.frame)+6*frameX/320.0,70,30)];
        if (i== 1) {
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
    
    
    //验证码
    UIView *newView =[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame)+4,frameX,44)];
    newView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:newView];
    
    UIImageView *imageView1;
    for (int i = 0; i<2; i++) {
        imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame)+4+44*i,frameX,1)];
        imageView1.image = [UIImage imageNamed:@"720"];
        [self.view addSubview:imageView1];
    }
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(imageView.frame)+4,104,44)];
    label.text = @"验证码";
    label.font = UIFont(15);
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = RGB(68,68,68);
    [self.view addSubview:label];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+12, CGRectGetMaxY(imageView.frame)+4,190,44)];
    _textField = textField;
    textField.placeholder = @"请输入验证码";
    textField.font = UIFont(14);
    [self.view addSubview:textField];
    
    //下一步
    UIView *nextView =[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView1.frame)+88,frameX,34)];
    nextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nextView];
    
    for (int i = 0; i<2; i++) {
        UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView1.frame)+88+34*i,frameX,1)];
        imageView2.image = [UIImage imageNamed:@"720"];
        [self.view addSubview:imageView2];
    }
    
    UIButton *nextBtn = [UIButton buttonWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame)+88,frameX,34) type:UIButtonTypeCustom title:@"下  一  步" target:self action:@selector(nextBtnClick:)];
    [nextBtn setTitleColor:RGB(255, 156, 0) forState:UIControlStateNormal];
    nextBtn.titleLabel.font = UIFont(18);
    [self.view addSubview:nextBtn];
}

- (void)backItem{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextBtnClick:(UIButton *)btn{
    if (_textField.text.length != 0 ) {
        if ([StringChangeJson getValueForKey:kSessionToken]) {
            
            //修改用户列表
            NSDictionary *dic = @{@"smsCode":_textField.text};
            
            _request = [[KongCVHttpRequest alloc]initWithRequests:kTextAccountUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
                
                NSDictionary *diction = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
                
                if ([diction[@"msg"] isEqualToString:@"成功"]) {
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    [defaults removeObjectForKey:kMobelNum]; //18518634636
                    
                    FinishViewController *finishController = [[FinishViewController alloc]init];
                    finishController.phoneString = self.phoneString;
                    [defaults setObject:self.phoneString forKey:kMobelNum];
                    [self.navigationController pushViewController:finishController animated:YES];

                }else {
                    FiledViewController  *filedController = [[FiledViewController alloc]init];
                    [self.navigationController pushViewController:filedController animated:YES];
                }
                
            }];
            
            FinishViewController *finishController = [[FinishViewController alloc]init];
            [self.navigationController pushViewController:finishController animated:YES];
        }
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
}

@end
