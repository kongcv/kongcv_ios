//
//  PushMessageTableViewCell.h
//  kongcv
//
//  Created by 空车位 on 15/12/22.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushMessageModel.h"
@interface PushMessageTableViewCell : UITableViewCell
@property (nonatomic,strong) PushMessageModel *model;
@property (nonatomic,copy)   NSString *recv;
@property (nonatomic,copy)   NSString *send;
@end
