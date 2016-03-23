//
//  UIView+BgView.h
//  kongcv
//
//  Created by 空车位 on 16/3/14.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (BgView)
+(UIView *)viewWithFrame:(CGRect )rect;
@end


@interface UILabel (BgView)
+(id)labelWithFrame:(CGRect)frame  text:(NSString *)text  Color:(UIColor *)color Font:(UIFont *)font;
@end


@interface UITextView (BgView)
+(UITextView *)textViewWithFrame:(CGRect)frame font:(UIFont *)font bgColor:(UIColor *)color textColor:(UIColor *)textColor;
@end


@interface UITextField (BgView)
+(UITextField *)textFieldWithFrame:(CGRect)frame font:(UIFont *)font bgColor:(UIColor *)color textColor:(UIColor *)textColor placeholder:(NSString *)string;
@end


@interface UIButton (BgView)
+(UIButton *)buttonWithFrame:(CGRect)frame font:(UIFont *)font bgColor:(UIColor *)color textColor:(UIColor *)textColor title:(NSString *)string bgImage:(UIImage *)image target:(id)target action:(SEL)action;
@end







