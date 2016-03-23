//
//  UIBarButtonItem+KCVButtonItem.m
//  kongchewei
//
//  Created by 空车位 on 15/10/21.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "UIBarButtonItem+KCVButtonItem.h"

@implementation UIBarButtonItem (KCVButtonItem)

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title{
    
    UIButton *btn = [UIButton buttonWithFrame:CGRectMake(0, 6,40,45) type:UIButtonTypeCustom title:title target:target action:action];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}

@end
