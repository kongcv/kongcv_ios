//
//  SearchParkViewController.h
//  kongcv
//
//  Created by 空车位 on 15/12/28.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "RootViewController.h"
typedef void(^ parkBlock) (NSArray *array);
@interface SearchParkViewController :RootViewController
@property (nonatomic,copy) parkBlock block;
@end
