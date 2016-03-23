//
//  PushMessageModel.h
//  kongcv
//
//  Created by 空车位 on 15/12/22.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushMessageModel : NSObject
@property (nonatomic,copy)      NSString *createdAt;
@property (nonatomic,strong)    NSDictionary *extras;
@property (nonatomic,copy)      NSString *objectId;
@property (nonatomic,copy)      NSString *own_mobile;
@property (nonatomic,copy)      NSString *push_info;
@property (nonatomic,copy)      NSString *push_type;
@property (nonatomic,copy)      NSString *req_mobile;
@property (nonatomic,copy)      NSString *state;
@property (nonatomic,copy)      NSString *updatedAt;
@property (nonatomic,strong)    NSDictionary *user;
@property (nonatomic,strong)    NSString *mode;

+(PushMessageModel *)modelWithDictionar:(NSDictionary *)dictionary;

@end
