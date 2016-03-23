//
//  DetailInfoModel.m
//  kongchewei
//
//  Created by 空车位 on 15/11/25.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "DetailInfoModel.h"

@implementation DetailInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
        
//        if ([_myStruct isEqualToString:key]) {
//            _myStruct = value;
//        }
    
}



+(DetailInfoModel *)modelWithDic:(NSDictionary *)dictionary{

    return [[DetailInfoModel alloc]initWithDictionary:dictionary];
}

-(instancetype)initWithDictionary:(NSDictionary *)dic{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

@end
