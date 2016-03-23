//
//  RouteCommentModel.h
//  kongcv
//
//  Created by 空车位 on 15/12/8.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RouteCommentModel : NSObject
@property (nonatomic,copy)  NSString *comment;
@property (nonatomic,copy)  NSString *createdAt;
@property (nonatomic,copy)  NSString *grade;
@property (nonatomic,copy)  NSString *objectId;
@property (nonatomic,strong)  NSDictionary *park_curb;
@property (nonatomic,strong) NSString *updatedAt;
@property (nonatomic,copy)   NSString *user;
@property (nonatomic,strong) NSString *image;
+(RouteCommentModel *)modelWithDictionary:(NSDictionary *)dic;
@end
