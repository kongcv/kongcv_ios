//
//  DetailViewController.h
//  kongchewei
//
//  Created by 空车位 on 15/11/3.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "NaviViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "SearchModel.h"

@interface DetailViewController : NaviViewController

//导航起始点
@property (nonatomic,assign) CGFloat startLa;
@property (nonatomic,assign) CGFloat startLo;
//导航结束点
@property (nonatomic,assign) CGFloat endLa;
@property (nonatomic,assign) CGFloat endLo;
//车位parkId
@property (nonatomic,copy)   NSString *park_id;
//出租类型
@property (nonatomic,copy)   NSString *mode;
//租用方式
@property (nonatomic,copy)   NSString *hire_method_id;
//判断是否是从消息通知进入
@property (nonatomic,copy)   NSString *pushMessage;
//判断是否租用
@property (nonatomic,copy)   NSString *park_space;
//出租规则
@property (nonatomic,strong) NSNumber *ruleStr;

@end
