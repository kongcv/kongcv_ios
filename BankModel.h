//
//  BankModel.h
//  kongcv
//
//  Created by 空车位 on 15/12/17.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankModel : NSObject
@property(nonatomic,copy)   NSString *bank;
@property(nonatomic,copy)   NSString *createdAt;
@property(nonatomic,copy)   NSString *objectId;
@property(nonatomic,strong) NSDictionary *picture;
@property(nonatomic,copy)   NSString *updatedAt;

+(BankModel *)modelWithDictionary:(NSDictionary *)dic;
@end
