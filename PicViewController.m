//
//  PicViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/10/20.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "PicViewController.h"
@interface PicViewController ()

@end

@implementation PicViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"TwoPage"];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"TwoPage"];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
    UIButton *button = [UIButton buttonWithFrame:CGRectMake(15,8,75,45) type:UIButtonTypeCustom title:nil target:self action:@selector(barClick)];
    
    [button setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
}

- (void)barClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{

    return YES;
}

@end
