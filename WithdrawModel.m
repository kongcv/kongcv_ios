//
//  WithdrawModel.m
//  kongcv
//
//  Created by 空车位 on 15/12/16.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "WithdrawModel.h"

@implementation WithdrawModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(WithdrawModel *)modelWithDic:(NSDictionary *)dic{

    return [[WithdrawModel alloc]initWithDic:dic];
}


- (instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

@end
