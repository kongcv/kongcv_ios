//
//  UserNameViewController.h
//  kongcv
//
//  Created by 空车位 on 16/1/14.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "RootViewController.h"
typedef void(^ nameBlock) (NSString *string);
@interface UserNameViewController : RootViewController
@property (nonatomic,copy) nameBlock block;
@end
