//
//  UIButton+myButton.m
//  kongchewei
//
//  Created by 空车位 on 15/10/14.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "UIButton+myButton.h"

@implementation UIButton (myButton)

+(UIButton *)buttonWithFrame:(CGRect)frame type:( UIButtonType *)type  title:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button =  [UIButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}




@end
