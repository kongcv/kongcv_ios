//
//  StringChangeJson.h
//  kongcv
//
//  Created by 空车位 on 15/12/16.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringChangeJson : NSDictionary

+(NSDictionary *)jsonDictionaryWithString:(NSString *)string;

-(void)saveValue:(NSString *)value key:(NSString *)key;

+(NSString *)getValueForKey:(NSString *)key;

@end
