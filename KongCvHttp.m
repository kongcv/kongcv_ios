//
//  KongCvHttp.m
//  kongcv
//
//  Created by 空车位 on 16/1/6.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "KongCvHttp.h"
#import "AFNetworking.h"
@implementation KongCvHttp
- (id)initWithRequests:(NSString *)urlString  dictionary:(NSDictionary *)dic andBlock:(myBlock)mangerBlock {
    
    if (self = [super init]) {
        
        [self requestString:urlString dictionary:dic  andBlock:mangerBlock] ;
        
    }
    
    return self;
}

- (void)requestString:(NSString *)string  dictionary:(NSDictionary *)dic andBlock:(myBlock)tempBlock{
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manger.requestSerializer setValue:Jtype forHTTPHeaderField:ContentType];
    
    [manger.requestSerializer setValue:appKeys forHTTPHeaderField:Key];
    
    [manger.requestSerializer setValue:appIds forHTTPHeaderField:Id];
    
    [manger POST:string parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            tempBlock(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"qqqqq%@",error.localizedDescription);
        
    }];
    
}

@end
