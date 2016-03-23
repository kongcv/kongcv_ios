//
//  GetParkingModel.h
//  kongcv
//
//  Created by 空车位 on 15/12/11.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetParkingModel : NSObject
@property (nonatomic,copy)   NSString *address;
@property (nonatomic,copy)   NSString *city;
@property (nonatomic,copy)   NSString *createdAt;
@property (nonatomic,copy)   NSString *gate_card;
@property (nonatomic,strong) NSDictionary *hire_end;
@property (nonatomic,copy)   NSString *hire_method;
@property (nonatomic,strong) NSArray *hire_price;
@property (nonatomic,strong) NSDictionary *hire_start;
@property (nonatomic,strong) NSArray *hire_time;
@property (nonatomic,strong) NSDictionary *location;
@property (nonatomic,copy)   NSString *long_time;
@property (nonatomic,copy)   NSString *normal;
@property (nonatomic,copy)   NSString *objectId;
@property (nonatomic,copy)   NSString *park_height;
@property (nonatomic,copy)   NSString *park_space;
@property (nonatomic,copy)   NSString *park_hide;
@property (nonatomic,copy)   NSString *park_area;
@property (nonatomic,copy)   NSString *myStruct;
@property (nonatomic,copy)   NSString *prak_struct;
@property (nonatomic,copy)   NSString *updatedAt;
@property (nonatomic,copy)   NSString *user;
@property (nonatomic,copy)   NSString *user_group;
@property (nonatomic,copy)   NSString *money;
@property (nonatomic,strong) NSArray *no_hire;
@property (nonatomic,copy)   NSString *tail_num;
@property (nonatomic,copy)   NSString *park_description;
@property (nonatomic,copy)   NSString *hire_field;

+(GetParkingModel *)modelWithDictionary:(NSDictionary *)dictionary;

@end
