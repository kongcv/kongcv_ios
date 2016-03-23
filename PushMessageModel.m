//
//  PushMessageModel.m
//  kongcv
//
//  Created by 空车位 on 15/12/22.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "PushMessageModel.h"

@implementation PushMessageModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(PushMessageModel *)modelWithDictionar:(NSDictionary *)dictionary{
    return [[PushMessageModel alloc]initWithDic:dictionary];
}

-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
