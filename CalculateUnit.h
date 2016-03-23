//
//  CalculateUnit.h
//  kongcv
//
//  Created by 空车位 on 16/1/7.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateUnit : NSObject
@property(nonatomic,copy) NSString *string;
-(NSNumber *)calculateMoneyWithStartTime:(NSString *)startTime endTime:(NSString *)endTime andNoDays:(NSString *)noday  andPrice:(NSString *)price;
@end
