//
//  GetParkingModel.m
//  kongcv
//
//  Created by 空车位 on 15/12/11.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "GetParkingModel.h"

@implementation GetParkingModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([_myStruct isEqualToString:key]) {
        
        _myStruct = value;
    }
}


+(GetParkingModel *)modelWithDictionary:(NSDictionary *)dictionary{

    return [[GetParkingModel alloc]initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)diction{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:diction];
    }
    return self;
}

@end
