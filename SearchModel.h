//
//  SearchModel.h
//  kongchewei
//
//  Created by 空车位 on 15/10/30.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *createAt;
@property (nonatomic,copy) NSString *gate_card;
@property (nonatomic,strong) NSDictionary *hire_end;
@property (nonatomic,strong) NSArray *hire_method;
@property (nonatomic,strong) NSArray *hire_price;
@property (nonatomic,strong) NSDictionary *hire_start;
@property (nonatomic,strong) NSArray *hire_time;
@property (nonatomic,strong) NSDictionary *location;
@property (nonatomic,copy)   NSString *long_time;
@property (nonatomic,strong) NSArray *no_hire;
@property (nonatomic,copy) NSString *normal;
@property (nonatomic,copy) NSString *objectId;
@property (nonatomic,copy) NSString *park_description;
@property (nonatomic,assign) NSInteger *park_height;
@property (nonatomic,copy)  NSString *park_hide;
@property (nonatomic,copy)  NSString *park_space;
@property (nonatomic,copy) NSString *iStruct;
@property (nonatomic,copy)  NSString *tail_num;
@property (nonatomic,strong) NSString *updatedAt;
@property (nonatomic,strong) NSDictionary *user;


//@property (nonatomic,copy) NSString *address;
//@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *createdAt;
//@property (nonatomic,copy) NSString *gate_card;
//@property (nonatomic,strong) NSDictionary *hire_end;
//@property (nonatomic,strong) NSArray *hire_method;
//@property (nonatomic,strong) NSDictionary *hire_start;
//@property (nonatomic,strong) NSDictionary *location;
//@property (nonatomic,copy)   NSString *normal;
//@property (nonatomic,copy)   NSString *objectId;
//@property (nonatomic,copy)   NSString *park_height;
//@property (nonatomic,copy)   NSString *park_space;
@property (nonatomic,copy)   NSString *kStruct;
//@property (nonatomic,copy)   NSString *updatedAt;
//@property (nonatomic,strong) NSDictionary *user;


+(SearchModel *)modelWithDictionary:(NSDictionary *)dic;

@end
