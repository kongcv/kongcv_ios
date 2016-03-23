//
//  PicturesModel.m
//  kongchewei
//
//  Created by 空车位 on 15/10/15.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "PicturesModel.h"

@implementation PicturesModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+(PicturesModel *)addWithDic:(NSDictionary *)dictionary{

    return [[PicturesModel alloc]initWithDic:dictionary];
}

- (id)initWithDic:(NSDictionary *)dictionary{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

@end
