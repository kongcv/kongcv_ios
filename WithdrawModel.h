//
//  WithdrawModel.h
//  kongcv
//
//  Created by 空车位 on 15/12/16.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdrawModel : NSObject
@property (nonatomic,copy) NSString *action;
@property (nonatomic,copy) NSString *balance;
@property (nonatomic,copy) NSString *charge_num;
@property (nonatomic,copy) NSString *check_state;
@property (nonatomic,copy) NSString *coupon;
@property (nonatomic,copy) NSString *createdAt;
@property (nonatomic,copy) NSString *handsel;
@property (nonatomic,copy) NSString *handsel_state;
@property (nonatomic,copy) NSString *money;
@property (nonatomic,copy) NSString *objectId;
@property (nonatomic,copy) NSString *pay_state;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *refund_state;
@property (nonatomic,copy) NSString *trade_state;
@property (nonatomic,copy) NSString *updatedAt;
@property (nonatomic,strong) NSDictionary *user;

+(WithdrawModel *)modelWithDic:(NSDictionary *)dic;

@end
