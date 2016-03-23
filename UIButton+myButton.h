//
//  UIButton+myButton.h
//  kongchewei
//
//  Created by 空车位 on 15/10/14.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (myButton)


+(UIButton *)buttonWithFrame:(CGRect)frame type:( UIButtonType *)type title:(NSString *)title target:(id)target action:(SEL)action;
@end
