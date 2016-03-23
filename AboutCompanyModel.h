//
//  AboutCompanyModel.h
//  kongcv
//
//  Created by 空车位 on 16/1/6.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AboutCompanyModel : NSObject
@property (nonatomic,strong)    NSArray *result;
//@property (nonatomic,copy)  NSString *info;
//@property (nonatomic,copy)  NSString *name;
//@property (nonatomic,copy)  NSString *objectId;
//@property (nonatomic,copy)  NSString *updatedAt;

+(AboutCompanyModel *)modelWithDic:(NSDictionary *)dic;

@end
