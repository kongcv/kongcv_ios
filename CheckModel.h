//
//  CheckModel.h
//  kongcv
//
//  Created by 空车位 on 15/12/16.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckModel : NSObject

@property (nonatomic,copy)    NSString *action;
@property (nonatomic,copy)    NSString *balance;
@property (nonatomic,copy)    NSString *charge_num;
@property (nonatomic,copy)    NSString *check_state;
@property (nonatomic,copy)    NSString *coupon;
@property (nonatomic,copy)    NSString *createdAt;
@property (nonatomic,copy)    NSString *extra_flag;
@property (nonatomic,copy)    NSString *frozen;
@property (nonatomic,copy)    NSString *handsel;
@property (nonatomic,copy)    NSString *handsel_state;
@property (nonatomic,strong)  NSDictionary *hire_end;
@property (nonatomic,copy)    NSString *hire_method;
@property (nonatomic,strong)  NSDictionary *hire_start;
@property (nonatomic,copy)    NSString *hirer;
@property (nonatomic,copy)    NSString *money;
@property (nonatomic,copy)    NSString *objectId;
@property (nonatomic,copy)    NSString *park_community;
@property (nonatomic,copy)    NSString *park_curb;
@property (nonatomic,copy)    NSString *pay_state;
@property (nonatomic,copy)    NSString *pay_tool;
@property (nonatomic,copy)    NSString *price;
//@property (nonatomic,copy)    NSString *property;
@property (nonatomic,copy)    NSString *refund_state;
@property (nonatomic,strong)  NSArray *trade_bill_id;
@property (nonatomic,copy)    NSString *trade_state;
@property (nonatomic,copy)    NSString *updatedAt;
@property (nonatomic,copy)    NSString *user;
@property (nonatomic,copy)    NSString *unit_price;

+(CheckModel *)modelWithDic:(NSDictionary *)dic;

@end
