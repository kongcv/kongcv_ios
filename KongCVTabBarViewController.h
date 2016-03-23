//
//  KongCVTabBarViewController.h
//  kongchewei
//
//  Created by 空车位 on 15/10/14.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KongCVTabBarViewController : UITabBarController

- (UIViewController *)addViewControllerWithString:(NSString *)controllerName title:(NSString *)title image:(NSString *)image andSelectedImage:(NSString *)selectImage;

@end
