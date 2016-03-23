//
//  KongCvHttp.h
//  kongcv
//
//  Created by 空车位 on 16/1/6.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KongCVHttpRequest;

typedef void (^myBlock) (NSDictionary *data);

@interface KongCvHttp : NSObject

@property (nonatomic,strong) NSDictionary *data;

- (id)initWithRequests:(NSString *)urlString dictionary:(NSDictionary *)dic  andBlock:(myBlock)mangerBlock;
@end
