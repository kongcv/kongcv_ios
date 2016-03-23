//
//  RootViewController.h
//  kongchewei
//
//  Created by 空车位 on 15/10/14.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
//@property (nonatomic,strong) NSUserDefaults *defaults;

- (void)initNav:(NSString  *)title andColor :(UIColor *)color;


- (void)initNav:(NSString  *)title andButton:(NSString *)string andColor :(UIColor *)color;
@end
