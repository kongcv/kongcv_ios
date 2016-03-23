//
//  PicturesModel.h
//  kongchewei
//
//  Created by 空车位 on 15/10/15.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicturesModel : NSObject
@property (nonatomic,copy)   NSString *createdAt;
@property (nonatomic,copy)   NSString *field;
@property (nonatomic,strong)  NSDictionary *picture2;
@property (nonatomic,copy)   NSString *picture_url;
@property (nonatomic,strong) NSDictionary *picture;
@property (nonatomic,copy)   NSString *objectId;
@property (nonatomic,copy)   NSString *updatedAt;
@property (nonatomic,copy)   NSString *name;
@property (nonatomic,copy)   NSString *method;
@property (nonatomic,strong) NSDictionary *park_type;
@property (nonatomic,strong) NSString *hire_type;
@property (nonatomic,strong) NSNumber *rule;
@property (nonatomic,copy)   NSString *hide;

@property (nonatomic,strong) NSDictionary *picture_small;
@property (nonatomic,strong) NSDictionary *picture_community;
@property (nonatomic,strong) NSDictionary *picture_curb;

+(PicturesModel *)addWithDic:(NSDictionary *)dictionary;

@end
