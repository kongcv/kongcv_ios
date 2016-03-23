//
//  NotificationViewController.h
//  kongcv
//
//  Created by 空车位 on 15/12/4.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController

//分类租用方式
@property (nonatomic,copy)  NSString *mode;
//车位objectid
@property (nonatomic,copy)  NSString *park_id;
//推送消息类型
@property (nonatomic,copy)  NSString *push_type;
//起始租用时间
@property (nonatomic,copy)  NSString *hire_start;
//结束租用时间
@property (nonatomic,copy)  NSString *hire_end;
//租用方式objectid
@property (nonatomic,copy)  NSString *hire_method_id;

@property (nonatomic,copy)  NSString *pushMessage;
//消息通知objectid
@property (nonatomic,copy)  NSString *message_id;

@property (nonatomic,assign)CGFloat endLa;

@property (nonatomic,assign)CGFloat endLo;
//推送里的电话
@property (nonatomic,copy)  NSString *own_mobile;
//推送token
@property (nonatomic,copy)  NSString *device_token;
//推送手机类型
@property (nonatomic,copy)  NSString *device_type;

@property (nonatomic,copy)  NSString *price;

//判断车位是否租用
@property (nonatomic,copy) NSString *park_space;

@end
