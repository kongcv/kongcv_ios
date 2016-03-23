//
//  CommentModel.m
//  kongchewei
//
//  Created by 空车位 on 15/11/26.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+(CommentModel *)modelWithDictionary:(NSDictionary *)dic{

    return [[CommentModel alloc]initWithDic:dic];
}

-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
