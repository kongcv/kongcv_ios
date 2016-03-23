//
//  UIView+BgView.m
//  kongcv
//
//  Created by 空车位 on 16/3/14.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "UIView+BgView.h"

@implementation UIView (BgView)
+(UIView *)viewWithFrame:(CGRect)rect{
    
    UIView *view  = [[UIView alloc]initWithFrame:rect];
    
    //上边线
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frameX, 1)];
    
    topImageView.image  = [UIImage imageNamed:@"720@2x"];
    
    [view addSubview:topImageView];
    
    
    //下边线
    
    UIImageView *bImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, view.frame.size.height-1, frameX,1)];
    
    bImageView.image = [UIImage imageNamed:@"720@2x"];
    
    [view addSubview:bImageView];
    
    
    return view;
}
@end

@implementation UILabel (BgView)

+(id)labelWithFrame:(CGRect)frame text:(NSString *)text Color:(UIColor *)color Font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.backgroundColor = color;
    label.font = font;
    return label;
}

@end

@implementation UITextView (BgView)

+(UITextView *)textViewWithFrame:(CGRect)frame font:(UIFont *)font bgColor:(UIColor *)color textColor:(UIColor *)textColor{

    UITextView *textView = [[UITextView alloc]initWithFrame:frame];
    
    textView.backgroundColor = color;
    
    textView.textColor = textColor;
    
    textView.font = font;
    
    return textView;
}

@end


@implementation UITextField (BgView)

+(UITextField *)textFieldWithFrame:(CGRect)frame font:(UIFont *)font bgColor:(UIColor *)color textColor:(UIColor *)textColor placeholder:(NSString *)string{

    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    
    textField.backgroundColor = color;
    
    textField.textColor = textColor;
    
    textField.font = font;
    
    textField.placeholder = string;
    
    return textField;
}
@end

@implementation UIButton (BgView)

+(UIButton *)buttonWithFrame:(CGRect)frame font:(UIFont *)font bgColor:(UIColor *)color textColor:(UIColor *)textColor title:(NSString *)string bgImage:(UIImage *)image target:(id)target action:(SEL)action{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.backgroundColor = color;
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    btn.frame = frame;
    
    btn.titleLabel.font = font;

    [btn setTitleColor:textColor forState:UIControlStateNormal];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitle:string forState:UIControlStateNormal];
    
    return btn;
    
}

@end

