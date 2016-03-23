//
//  AboutCompanyModel.m
//  kongcv
//
//  Created by 空车位 on 16/1/6.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "AboutCompanyModel.h"

@implementation AboutCompanyModel

+(AboutCompanyModel *)modelWithDic:(NSDictionary *)dic{

    return [[AboutCompanyModel alloc]initWithDic:dic];
}


-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

@end
