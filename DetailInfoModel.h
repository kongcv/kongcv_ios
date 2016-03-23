//
//  DetailInfoModel.h
//  kongchewei
//
//  Created by 空车位 on 15/11/25.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailInfoModel : NSObject

@property (nonatomic,copy)   NSString *address;
@property (nonatomic,copy)   NSString *all_time_day;
@property (nonatomic,copy)   NSString *all_time_month;
@property (nonatomic,copy)   NSString *city;
@property (nonatomic,copy)   NSString *createdAt;
@property (nonatomic,copy)   NSString *gate_card;
@property (nonatomic,strong) NSDictionary *hire_end;
@property (nonatomic,copy)   NSString *hire_method;
@property (nonatomic,strong) NSArray *hire_price;
@property (nonatomic,strong) NSDictionary *hire_start;
@property (nonatomic,strong) NSArray *hire_time;
@property (nonatomic,copy)   NSString *interval_light_day;
@property (nonatomic,copy)   NSString *interval_light_month;
@property (nonatomic,copy)   NSString *interval_night_day;
@property (nonatomic,copy)   NSString *interval_night_month;
@property (nonatomic,strong) NSDictionary *location;
@property (nonatomic,strong) NSNumber *long_time;
@property (nonatomic,strong) NSArray *no_hire;
@property (nonatomic,copy)   NSString *normal;
@property (nonatomic,copy)   NSString *objectId;
@property (nonatomic,copy)   NSString *park_area;
@property (nonatomic,copy)   NSString *park_description;
@property (nonatomic,copy)   NSString *park_height;
@property (nonatomic,copy)   NSString *park_hide;
@property (nonatomic,copy)   NSString *park_space;
@property (nonatomic,copy)   NSString *park_struct;
@property (nonatomic,copy)   NSString *tail_num;
@property (nonatomic,copy)   NSString *updatedAt;
@property (nonatomic,copy)   NSString *user;
@property (nonatomic,copy)   NSString *user_group;
@property (nonatomic,strong) NSArray *hire_field;
@property (nonatomic,strong) NSDictionary *property;
@property (nonatomic,copy)   NSString *rate;

+(DetailInfoModel *)modelWithDic:(NSDictionary *)dictionary;
@end
