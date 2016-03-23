//
//  CheckModel.m
//  kongcv
//
//  Created by 空车位 on 15/12/16.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "CheckModel.h"

@implementation CheckModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
   
}

+(CheckModel *)modelWithDic:(NSDictionary *)dic{
    return [[CheckModel alloc]initWithDic:dic];
}

-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

@end
