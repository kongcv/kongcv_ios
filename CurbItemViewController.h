//
//  CurbItemViewController.h
//  kongcv
//
//  Created by 空车位 on 16/1/26.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "RootViewController.h"

@interface CurbItemViewController : RootViewController

//交易id
@property (nonatomic,copy) NSString *trade_id;

@property (nonatomic,copy) NSString *community;

@property (nonatomic,copy) NSString *curb;
//车位objectid
@property (nonatomic,copy) NSString *park_id;
//租用类型
@property (nonatomic,copy) NSString *mode;

@property (nonatomic,copy) NSString *isHireOrLet;
//价格
@property (nonatomic,copy) NSString *price;
//租用者objectid
@property (nonatomic,copy) NSString *hirer_id;

@property (nonatomic,copy) NSString *start_time;

@property (nonatomic,copy) NSString *end_time;

@property (nonatomic,copy) NSString *device_token;

@property (nonatomic,copy) NSString *device_type;

@property (nonatomic,copy) NSString *mobile;
//租用方式objectid
@property (nonatomic,copy) NSString *hire_method_id;
//支付工具
@property (nonatomic,copy) NSString *pay_tool;
//单价
@property (nonatomic,copy) NSString *unitPrice;
//交易状态
@property (nonatomic,copy) NSString *trade_state;
//租用方式别名
@property (nonatomic,copy) NSString *field;
@end
