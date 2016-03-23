//
//  RouteTableViewCell.h
//  kongcv
//
//  Created by 空车位 on 15/12/8.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailInfoModel.h"
@interface RouteTableViewCell : UITableViewCell

@property (nonatomic,strong)  DetailInfoModel *model;

//租用类型
@property (nonatomic,copy)    NSString *mode;
//车位objectid
@property (nonatomic,copy)    NSString *park_id;
//租用方式objectid
@property (nonatomic,copy)    NSString *hire_method_id;
//推送类型
@property (nonatomic,strong)  NSString *push_type;
//租用起始时间
@property (nonatomic,copy)    NSString *hire_start;
//租用结束时间
@property (nonatomic,copy)    NSString *hire_end;
//钱数
@property (nonatomic,copy)    NSString *price;

//@property (nonatomic,copy)    NSString *tradeItem;
//@property (nonatomic,copy)    NSString *owndevice_token;
//@property (nonatomic,copy)    NSString *owndevice_type;

@property (nonatomic,copy)    NSString *tradePrice;
//交易订单号
@property (nonatomic,copy)    NSString *trade_id;
//单价
@property (nonatomic,copy)    NSString *unit_Price;
//交易状态
@property (nonatomic,copy)    NSString *trade_state;
//租用规则
@property (nonatomic,copy)    NSNumber *ruleStr;
//消息列表获取的钱数
@property (nonatomic,copy)    NSString *listprice;
//租用别名
@property (nonatomic,copy) NSString *hire_fields;
@end
