//
//  KongCVTabBarViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/10/14.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "KongCVTabBarViewController.h"
#import "UIImage+navationBar.h"
@interface KongCVTabBarViewController ()

@end

@implementation KongCVTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImage *image = [[UIImage alloc]init];
    
    UIImage *tabBarImage = [image scaleFromImage:[UIImage imageNamed:@""] toSize:CGSizeMake(self.view.frame.size.width, 44)];
    
    [self.navigationController.navigationBar setBackgroundImage:tabBarImage forBarMetrics:UIBarMetricsDefault];
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

- (UIViewController *)addViewControllerWithString:(NSString *)controllerName title:(NSString *)title image:(NSString *)image andSelectedImage:(NSString *)selectImage{

    Class class = NSClassFromString(controllerName);
    
    UIViewController *controller = [[class alloc]init];
    
    controller.title = title;
    
    controller.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *controllerNav = [[UINavigationController alloc]initWithRootViewController:controller];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewControllers];
    
    [array addObject:controllerNav];
    
    self.viewControllers = array;
    
    return controller;
    
}

@end













