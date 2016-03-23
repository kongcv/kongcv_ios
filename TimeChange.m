//
//  TimeChange.m
//  kongcv
//
//  Created by 空车位 on 15/12/24.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "TimeChange.h"

@implementation TimeChange
+(NSString *)timeChange:(NSString *)timeString{

    NSArray *array = [timeString componentsSeparatedByString:@"."];
    
    NSString *dateStr  =  [[array firstObject] stringByAppendingString:@"+0000"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSDate *localDate = [dateFormatter dateFromString:dateStr];
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:localDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:localDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:localDate];
    
    NSString *string = [NSString stringWithFormat:@"%@",destinationDateNow];
    
    NSArray *dateArray = [string componentsSeparatedByString:@"+"];
    
    return  [dateArray firstObject];
    
}
@end
