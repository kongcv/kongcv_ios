//
//  ListModel.h
//  kongcv
//
//  Created by 空车位 on 15/12/11.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

@property (nonatomic,copy) NSString *hire_time;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *objectName;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *field;

+(ListModel *)modelWithDic:(NSDictionary *)dictionary;

@end
