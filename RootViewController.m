//
//  RootViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/10/14.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "RootViewController.h"
#import "UIImage+navationBar.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBarHidden = YES;
//    UIImage *image = [[UIImage alloc]init];
//    UIImage *tabBarImage = [image scaleFromImage:[UIImage imageNamed:@"矩形"] toSize:CGSizeMake(self.view.frame.size.width,64)];
//    [self.navigationController.navigationBar setBackgroundImage:tabBarImage forBarMetrics:UIBarMetricsDefault];
    
    //_defaults = [NSUserDefaults standardUserDefaults];
    
    
}

- (void)initNav:(NSString *)title  andColor :(UIColor *)color{

    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 64)];
    
    navView.backgroundColor = color;
    
    [self.view addSubview:navView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frameX/2.0-50,25,100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = title;
    
    label.font = UIFont(19);
    
    label.font = [UIFont boldSystemFontOfSize:16];
    
    [self.view addSubview:label];
}

- (void)initNav:(NSString *)title andButton:(NSString *)string andColor :(UIColor *)color{

    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 64)];
    
    navView.backgroundColor = color;
    
    [self.view addSubview:navView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frameX/2.0-50,25,100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = title;
    
    label.font = UIFont(19);
    
    label.font = [UIFont boldSystemFontOfSize:16];
    
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(5,5,85,70);
    
    [button setBackgroundImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    UIImageView *imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(navView.frame)-1,frameX, 1)];
    
    imageViewLine.image = [UIImage imageNamed:@"720@2x"];
    
    [self.view addSubview:imageViewLine];
    
}


- (void)backButtonClick:(UIButton *)btn{

    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
