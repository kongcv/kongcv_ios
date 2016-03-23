//
//  DetailTableViewCell.h
//  kongchewei
//
//  Created by 空车位 on 15/11/25.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailInfoModel.h"
@interface DetailTableViewCell : UITableViewCell
@property (nonatomic,strong)  DetailInfoModel *model;
@property (nonatomic,copy)    NSString *park_id;
@property (nonatomic,copy)    NSString *mode;
@property (nonatomic,copy)    NSString *push_type;
@property (nonatomic,copy)    NSString *hire_method_id;

@property (nonatomic,copy)    NSString *park_space;

@property (nonatomic,strong) NSNumber *ruleStr; //规则
@end
