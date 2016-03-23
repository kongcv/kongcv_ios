//
//  SearchModel.m
//  kongchewei
//
//  Created by 空车位 on 15/10/30.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([_iStruct isEqualToString:key]) {
        
        _iStruct = value;
    }
    
}


+(SearchModel *)modelWithDictionary:(NSDictionary *)dic{

    return [[SearchModel alloc]initWithDictionary:dic];
}


- (instancetype)initWithDictionary:(NSDictionary *)dic{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}





@end
