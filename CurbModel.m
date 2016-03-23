//
//  CurbModel.m
//  kongcv
//
//  Created by 空车位 on 15/12/25.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "CurbModel.h"

@implementation CurbModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(CurbModel *)modelWithDic:(NSDictionary *)dic{
    return [[CurbModel alloc]initWithDic:dic];
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

@end
