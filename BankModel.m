//
//  BankModel.m
//  kongcv
//
//  Created by 空车位 on 15/12/17.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "BankModel.h"

@implementation BankModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(BankModel *)modelWithDictionary:(NSDictionary *)dic{

    return [[BankModel alloc]initWithDic:dic];
}


-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

@end
