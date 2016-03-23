//
//  CurbNotificationViewController.h
//  kongcv
//
//  Created by 空车位 on 16/1/16.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "NaviViewController.h"

@interface CurbNotificationViewController : NaviViewController

@property (nonatomic,copy)  NSString *mode;
@property (nonatomic,copy)  NSString *park_id;
@property (nonatomic,copy)  NSString *push_type;
@property (nonatomic,copy)  NSString *hire_start;
@property (nonatomic,copy)  NSString *hire_end;
@property (nonatomic,copy)  NSString *hire_method_id;
@property (nonatomic,copy)  NSString *ssss;

@property (nonatomic,copy)  NSString *own_mobile;
@property (nonatomic,copy)  NSString *device_token;
@property (nonatomic,copy)  NSString *device_type;
@property (nonatomic,copy)  NSString *userId;
@property (nonatomic,copy)  NSString *price;
@property (nonatomic,assign)CGFloat endLa;
@property (nonatomic,assign)CGFloat endLo;

//差额交易
@property (nonatomic,copy) NSString *pay_type;
@property (nonatomic,copy) NSString *trade_id;
@property (nonatomic,copy) NSString *pay_tool;

@property (nonatomic,copy) NSString *hire_field;
@end
