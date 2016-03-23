//
//  BankCategoryViewController.h
//  kongcv
//
//  Created by 空车位 on 15/12/17.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "RootViewController.h"

typedef void(^myBlock) (NSDictionary *dic);

@interface BankCategoryViewController : RootViewController

@property (nonatomic,copy) myBlock  block;

@end
