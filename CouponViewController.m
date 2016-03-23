//
//  CouponViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/31.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "CouponViewController.h"
#import "UIImage+navationBar.h"
@interface CouponViewController ()
@property (nonatomic,strong) KongCVHttpRequest *request;
@end

@implementation CouponViewController


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"ElevenPage"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"ElevenPage"];
    UIImage *image = [[UIImage alloc]init];
    UIImage *tabBarImage = [image scaleFromImage:[UIImage imageNamed:@"矩形"] toSize:CGSizeMake(self.view.frame.size.width,64)];
    [self.navigationController.navigationBar setBackgroundImage:tabBarImage forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor whiteColor];
    NSDictionary *dictionary = @{@"user_id" :@"5681fdc760b2690c5d1f0f0e"};
    _request = [[KongCVHttpRequest alloc]initWithRequests:kGetCouponUrl sessionToken:[StringChangeJson getValueForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {
        NSLog(@"%@",data[@"result"]);
    }];
}



@end
