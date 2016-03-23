//
//  StringChangeJson.m
//  kongcv
//
//  Created by 空车位 on 15/12/16.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "StringChangeJson.h"

@implementation StringChangeJson
+(NSDictionary *)jsonDictionaryWithString:(NSString *)string{
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return dictionary;
    
}


-(void)saveValue:(NSString *)value key:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

+(NSString *)getValueForKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   return  [defaults objectForKey:key];
}

@end
