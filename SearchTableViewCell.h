//
//  SearchTableViewCell.h
//  kongchewei
//
//  Created by 空车位 on 15/10/31.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"
@interface SearchTableViewCell : UITableViewCell
@property (nonatomic,copy)  NSString *hire_method_id;
@property (nonatomic,strong) SearchModel *model;

@end
