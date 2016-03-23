//
//  KongCVHttpRequest.m
//  kongchewei
//
//  Created by 空车位 on 15/10/15.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "KongCVHttpRequest.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@implementation KongCVHttpRequest

- (id)initWithRequests:(NSString *)urlString sessionToken:(NSString *)sessionToken dictionary:(NSDictionary *)dic andBlock:(myBlock)mangerBlock {
    
    if (self = [super init]) {
    
       [self requestString:urlString  sessionToken:sessionToken  dictionary:dic  andBlock:mangerBlock] ;
    }
    return self;
}

- (void)requestString:(NSString *)string sessionToken:(NSString *)sessionToken dictionary:(NSDictionary *)dic andBlock:(myBlock)tempBlock{
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
   
    [manger.requestSerializer setValue:Jtype forHTTPHeaderField:ContentType];
    
    [manger.requestSerializer setValue:appKeys forHTTPHeaderField:Key];
    
    [manger.requestSerializer setValue:appIds forHTTPHeaderField:Id];
    
   [manger.requestSerializer setValue:sessionToken forHTTPHeaderField:kToken];
    
   [manger POST:string parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       if (responseObject) {
           tempBlock(responseObject);
       }

   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       //NSLog(@"qqqqq%@",error.localizedDescription);
   }];
    
}




@end
