//
//  UIBarButtonItem+KCVButtonItem.h
//  kongchewei
//
//  Created by 空车位 on 15/10/21.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (KCVButtonItem)
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title;
@end
