//
//  NotiTableViewCell.h
//  kongcv
//
//  Created by 空车位 on 16/1/7.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailInfoModel.h"
@interface NotiTableViewCell : UITableViewCell

@property (nonatomic,strong)  DetailInfoModel *model;

@property (nonatomic,copy)    NSString *park_id;

@property (nonatomic,copy)    NSString *mode;

@property (nonatomic,copy)    NSString *push_type;

@property (nonatomic,copy)    NSString *hire_method_id;

@property (nonatomic,copy)    NSString *own_mobile;

@property (nonatomic,copy)    NSString *device_token;

@property (nonatomic,copy)    NSString *device_type;

@property (nonatomic,copy)    NSString *message_id;

@property (nonatomic,copy)    NSString *price;

@property (nonatomic,copy)    NSString *hire_start;

@property (nonatomic,copy)    NSString *hire_end;

@property (nonatomic,copy)    NSString *pushMessage;

@property (nonatomic,copy)    NSString *trade_id;

@property (nonatomic,copy)    NSString *tradeItem;

@property (nonatomic,copy)    NSString *tradePrice;

@property (nonatomic,copy)    NSString *unit_Price;

@property (nonatomic,copy)   NSString *trade_state;

@property (nonatomic,copy)   NSString *park_space;

@end
