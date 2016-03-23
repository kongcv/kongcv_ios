//
//  KongNewViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/10/14.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "KongNewViewController.h"
#import "KongCVTabBarViewController.h"
#import "KongCVViewController.h"
@interface KongNewViewController ()

@end

@implementation KongNewViewController
- (IBAction)button:(UIButton *)sender {
    
    //KongCVTabBarViewController *tabBar = [[KongCVTabBarViewController alloc]init];
   
    
    KongCVViewController *Cont = [[KongCVViewController alloc]init];
    //[self.navigationController popToViewController:Cont animated:YES];
    
    [self presentViewController:Cont animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
