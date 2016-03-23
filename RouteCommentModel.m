//
//  RouteCommentModel.m
//  kongcv
//
//  Created by 空车位 on 15/12/8.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "RouteCommentModel.h"

@implementation RouteCommentModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(RouteCommentModel *)modelWithDictionary:(NSDictionary *)dic{
    
    return [[RouteCommentModel alloc]initWithDic:dic];
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
