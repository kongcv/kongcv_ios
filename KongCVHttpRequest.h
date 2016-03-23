//
//  KongCVHttpRequest.h
//  kongchewei
//
//  Created by 空车位 on 15/10/15.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KongCVHttpRequest;

typedef void (^myBlock) (NSDictionary *data);

@interface KongCVHttpRequest : NSObject

@property (nonatomic,strong) NSDictionary *data;

- (id)initWithRequests:(NSString *)urlString sessionToken:(NSString *)sessionToken   dictionary:(NSDictionary *)dic  andBlock:(myBlock)mangerBlock;

@end
