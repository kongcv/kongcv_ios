//
//  ZHXDataCache.h
//  kongcv
//
//  Created by 空车位 on 15/12/24.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>


//缓存

@interface ZHXDataCache : NSObject

+(ZHXDataCache *)sharedCache;

-(BOOL)saveDataWithData:(NSDictionary *)data andStringName:(NSString *)name;

-(NSDictionary *)getDataWithStringName:(NSString *)name;

//-(BOOL)removeData:(NSString *)string;
@end
