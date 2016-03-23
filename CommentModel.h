//
//  CommentModel.h
//  kongchewei
//
//  Created by 空车位 on 15/11/26.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic,copy)    NSString *comment;
@property (nonatomic,copy)    NSString *createdAt;
@property (nonatomic,copy)    NSString *grade;
@property (nonatomic,copy)    NSString *objectId;
@property (nonatomic,strong)  NSDictionary *park_community;
@property (nonatomic,strong)  NSString *updatedAt;
@property (nonatomic,copy)    NSString *user;
@property (nonatomic,copy)    NSString *image;
@property (nonatomic,copy)    NSString *park_curb;
+(CommentModel *)modelWithDictionary:(NSDictionary *)dic;
@end
