//
//  LoginViewController.h
//  kongchewei
//
//  Created by 空车位 on 15/10/20.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "RootViewController.h"

typedef void(^ loginBlock) (NSArray *array);
@interface LoginViewController : RootViewController
@property (nonatomic,copy) loginBlock block;
@end
