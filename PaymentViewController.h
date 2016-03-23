//
//  PaymentViewController.h
//  kongcv
//
//  Created by 空车位 on 15/12/3.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "RootViewController.h"

@interface PaymentViewController : RootViewController
@property (nonatomic,copy) NSString *priceStr;
@property (nonatomic,copy) NSString *park_id;
@property (nonatomic,copy) NSString *hire_methold_id;
@property (nonatomic,copy) NSString *mode;
@property (nonatomic,copy) NSString *start_time;
@property (nonatomic,copy) NSString *end_time;
@property (nonatomic,copy)   NSString *pay_type;
@property (nonatomic,copy)   NSString *hirer_id;
@property (nonatomic,copy)   NSString *extra_flag;
@property (nonatomic,strong) NSNumber *priceNum;

@property (nonatomic,copy)   NSString *pay_types;//差额交易字段
@property (nonatomic,copy)   NSString *trade_id;    //订单交易号
@property (nonatomic,copy)   NSString *pay_tool;   //支付方式
@property (nonatomic,copy)   NSString *device_token;
@property (nonatomic,copy)   NSString *device_type;
@property (nonatomic,copy)   NSString *mobile;
@property (nonatomic,copy)   NSString *unit_price;

@property (nonatomic,copy)  NSString *property_id;
@property (nonatomic,copy)  NSString *curb_rate;

@property (nonatomic,copy) NSString *hire_field;
@end
