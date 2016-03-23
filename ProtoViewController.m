//
//  ProtoViewController.m
//  kongcv
//
//  Created by 空车位 on 16/1/29.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "ProtoViewController.h"

@interface ProtoViewController ()

@end

@implementation ProtoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:self.url];
    
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


@end
