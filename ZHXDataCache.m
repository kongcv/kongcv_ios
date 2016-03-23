//
//  ZHXDataCache.m
//  kongcv
//
//  Created by 空车位 on 15/12/24.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "ZHXDataCache.h"
#import "NSString+Hashing.h"

@interface ZHXDataCache ()
@property (nonatomic,assign) NSTimeInterval invaliteTime;  //单位:s
@end
@implementation ZHXDataCache

//创建单例
static ZHXDataCache *cache = nil;
+(ZHXDataCache *)sharedCache{
    @synchronized(self){
        if (cache == nil) {
            cache = [[ZHXDataCache alloc]init];
        }
    }
    return cache;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self){
    
        if (!cache) {
            cache = [super allocWithZone:zone];
        }
    }
    return cache;
}

-(id)init{

    if (self = [super init]) {
        _invaliteTime = 24*60*60/2.0;
    }
    return self;
}

-(BOOL)saveDataWithData:(NSDictionary *)data andStringName:(NSString *)name{
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Cache",NSHomeDirectory()];
    
    NSFileManager *manger = [NSFileManager defaultManager];
    
    BOOL isSuc = [manger createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (!isSuc) {
        NSLog(@"error");
        return NO;
    }
    
    name = [name MD5Hash];
    
    NSString *allpath = [NSString stringWithFormat:@"%@/%@",path,name];
    
    BOOL isWriteSuc = [data writeToFile:allpath atomically:YES];

    return isWriteSuc;
}

-(NSDictionary *)getDataWithStringName:(NSString *)name{

    NSString *tempName = [name MD5Hash];
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Cache/%@",NSHomeDirectory(),tempName];
    
    NSFileManager *manage = [NSFileManager defaultManager];
    
    if (![manage fileExistsAtPath:path]) {
        return nil;
    }
    
    NSTimeInterval invalitTime = [[NSDate date] timeIntervalSinceDate:[self getLastModefityDateWithFile:path]];
    
    if (invalitTime >= _invaliteTime) {
        return nil;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return dic;
}

- (NSDate *)getLastModefityDateWithFile:(NSString *)path{

    NSFileManager *manger = [NSFileManager defaultManager];
    NSDictionary *dic = [manger attributesOfItemAtPath:path error:nil];
    return dic[NSFileModificationDate];
    
}

//-(BOOL)removeData:(NSString *)string{
//    
//    NSFileManager *manger = [NSFileManager defaultManager];
//    [manger removeItemAtPath:string error:nil];
//    
//    return YES;
//}

@end












