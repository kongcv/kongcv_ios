//
//  CheckTableViewCell.h
//  kongcv
//
//  Created by 空车位 on 15/12/24.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckModel.h"
#import "CurbModel.h"
@interface CheckTableViewCell : UITableViewCell
@property (nonatomic,strong) CheckModel *model;
@property (nonatomic,strong) CurbModel *curbModel;
@end
