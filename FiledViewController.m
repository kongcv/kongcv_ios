//
//  FiledViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/23.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "FiledViewController.h"
#import "ChangePhoneNumViewController.h"
@interface FiledViewController ()

@end

@implementation FiledViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"Threty-twoPage"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"Threty-twoPage"];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(247, 247, 247);
    
    [self initNav:@"更改手机号" andButton:@"fh" andColor:RGB(247,247,247)];
    
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
        if (i== 0 ) {
            label.textColor = RGB(255, 156, 0);
            imageViewYaun.image = [UIImage imageNamed:@"icon_yuandian"];
        }else if ( i == 1){
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

    
    
    //下一步
    UIView *nextView =[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame)+88,frameX,34)];
    nextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nextView];
    
    for (int i = 0; i<2; i++) {
        UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame)+88+34*i,frameX,1)];
        imageView2.image = [UIImage imageNamed:@"720"];
        [self.view addSubview:imageView2];
    }
    
    UIButton *nextBtn = [UIButton buttonWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+88,frameX,34) type:UIButtonTypeCustom title:@"绑定失败" target:self action:@selector(nextBtnClick:)];
    [nextBtn setTitleColor:RGB(255, 156, 0) forState:UIControlStateNormal];
    nextBtn.titleLabel.font = UIFont(18);
    [self.view addSubview:nextBtn];
}
- (void)backItem{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextBtnClick:(UIButton *)btn{
    ChangePhoneNumViewController *changeController = [[ChangePhoneNumViewController alloc]init];
    [self.navigationController pushViewController:changeController animated:YES];
}

@end
