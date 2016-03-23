//
//  RouteViewController.h
//  kongcv
//
//  Created by 空车位 on 15/12/8.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "NaviViewController.h"

#import <AMapNaviKit/AMapNaviKit.h>

#import "SearchModel.h"
@interface RouteViewController : NaviViewController

//起始坐标点
@property (nonatomic,assign) CGFloat startLa;
@property (nonatomic,assign) CGFloat startLo;
//结束坐标点
@property (nonatomic,assign) CGFloat endLa;
@property (nonatomic,assign) CGFloat endLo;
//车位Objectid
@property (nonatomic,copy)   NSString *park_id;
//出租类型
@property (nonatomic,copy)   NSString *mode;
//租用类型
@property (nonatomic,copy)   NSString *hire_method_id;
//判断从消息通知
@property (nonatomic,copy)   NSString *pushMessage;
//租用规则
@property (nonatomic,strong) NSNumber *ruleStr;
//消息列表获取的钱数 
@property (nonatomic,copy)   NSString *price;

@end
