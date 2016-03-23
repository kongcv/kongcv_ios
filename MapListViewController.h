//
//  MapListViewController.h
//  kongchewei
//
//  Created by 空车位 on 15/11/9.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapListViewController : UIViewController

//经纬度
@property (nonatomic,assign)  CGFloat  latitude;
@property (nonatomic,assign)  CGFloat  longitude;

@property (nonatomic,copy)    NSString *name;
//租用分类方式
@property (nonatomic,copy)    NSString *mode;
//租用方式id
@property (nonatomic,copy)    NSString *hire_method_id;
//租用别名
@property (nonatomic,copy)    NSString *hire_field;
//判断是否是停车场
@property (nonatomic,copy)    NSString *hire_type;
//租用规则
@property (nonatomic,strong)  NSNumber *ruleStr;


@end
