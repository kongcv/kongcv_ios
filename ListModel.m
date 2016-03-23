//
//  ListModel.m
//  kongcv
//
//  Created by 空车位 on 15/12/11.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(ListModel *)modelWithDic:(NSDictionary *)dictionary{

    return [[ListModel alloc]initWithDic:dictionary];
}

-(instancetype)initWithDic:(NSDictionary *)dictionary{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

@end
