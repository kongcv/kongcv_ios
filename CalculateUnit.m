//
//  CalculateUnit.m
//  kongcv
//
//  Created by 空车位 on 16/1/7.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "CalculateUnit.h"
@interface CalculateUnit()
@property (nonatomic,assign) int moneyDay;
@end
@implementation CalculateUnit

-(NSNumber *)calculateMoneyWithStartTime:(NSString *)startTime endTime:(NSString *)endTime andNoDays:(NSString *)noday andPrice:(NSString *)price{
    
    NSNumber *moneyNum;  //返回的钱数
    
    NSArray *array = [price  componentsSeparatedByString:@"/" ];
   
    NSArray *strartArr = [startTime componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
    NSArray *endArra = [endTime componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
    
    NSString *startTimeStr = [NSString stringWithFormat:@"%@-%@-%@",strartArr[0],strartArr[1],strartArr[2]];
    NSString *endTimeStr = [NSString stringWithFormat:@"%@-%@-%@",endArra[0],endArra[1],endArra[2]];
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [gregorian setFirstWeekday:2];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *fromDate = [dateFormatter dateFromString:startTimeStr];
    
    NSDate *toDate = [dateFormatter dateFromString:endTimeStr]; //8-25
    
    NSDateComponents *day = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate  options:0];
    
    
    int days =day.day+1;         //起始和租用时间段的总天数
    int multDays = days%7;      //最后一周有多少天
    
//    NSLog(@"总共租用%d天",days);
//    NSLog(@"有%d周",days/7);
//    NSLog(@"剩余%d天",multDays);
    
    
    //如果有多余的天数，不到一周
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"7", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:fromDate];
    NSString *string = [weekdays objectAtIndex:theComponents.weekday]; //起始租用是周几
         
    //NSLog(@"起始是：%@",string);
    //剩余最后一周有那几天
    NSMutableArray *a = [NSMutableArray array];
    for (int i = 0; i<multDays; i++) {
        if (i+[string integerValue] <= 7) {
            [a addObject:[NSString stringWithFormat:@"%d",i+[string integerValue]]];
        }
    }
        
    int P = multDays - a.count;
    for (int i = 0; i<P; i++) {
           [a addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
    //NSLog(@"剩余天数有那%@天",a);
        
        
    int d = 0;
        //NSArray *arr = [noday componentsSeparatedByString:@"、"];
    NSArray *arr;
    if (noday) {
        if (noday.length == 1) {
            arr = @[noday];
        }else{
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"周 、,"];
            arr = [noday componentsSeparatedByCharactersInSet:set];
        }
    }
        //NSLog(@"%@",arr);
    //NSLog(@"非出租日  %@",[arr lastObject]);
    //NSLog(@"%@",noday);
    NSMutableArray *ar = [NSMutableArray array];
    for (NSString *str in arr) {
        //NSLog(@"str----%@",str);
    if ([str isEqualToString:@"一"]) {
        
        [ar addObject:@"1"];
        
    }else if ([str isEqualToString:@"二"]){
                [ar addObject:@"2"];
            }else if ([str isEqualToString:@"三"]){
                [ar addObject:@"3"];
            }else if ([str isEqualToString:@"四"]){
                [ar addObject:@"4"];
            }else if ([str isEqualToString:@"五"]){
                [ar addObject:@"5"];
            }else if ([str isEqualToString:@"六"]){
                [ar addObject:@"6"];
            }else if ([str isEqualToString:@"日"]){
                [ar addObject:@"7"];
            }
        }
         
        NSString *nodayssss=@"";
    
        for (NSString *daystr in ar) {
            
            NSString *s = [NSString stringWithFormat:@"%@、",daystr];
            
            nodayssss = [nodayssss stringByAppendingString:s];
            
        }

        NSArray *noArray = [nodayssss componentsSeparatedByString:@"、"];
    
        for (NSString *str in a) {
            
            for (NSString *s in noArray) {
                
                if ([str isEqualToString:s]) {
                    
                    d += 1;
                    
                }
            }
        }

      self.string = [NSString stringWithFormat:@"%d",days - days/7*ar.count-d];

        if ([[array lastObject] isEqualToString:@"天"]) {
            
            int price = (days - days/7*ar.count - d) *[[array firstObject] intValue];
            
            moneyNum = [NSNumber numberWithInt:price];
            
            
        }else if ([[array lastObject] isEqualToString:@"月"]){
            //有多少个月
            
            //一天是多少钱
            
            int dayMonths =  [[array firstObject] floatValue] / (30 - 4*ar.count - d) ;
            
            //有几个月
            int month = days / 30;
            
            int yushu = days % 30;
            
            //不够一个月，剩余的天数
            int yuDays = days - month * 30;
            
            if ([[NSString stringWithFormat:@"%d",yushu] isEqualToString:@"0" ])  {
                
                moneyNum = [NSNumber numberWithInt:month * [[array firstObject] floatValue]];
                
            }else{
            
                //不够一个月，可以租用的天数
                
                if (  yuDays > d) {
                    
                    int moDays = yuDays - yuDays/7*ar.count - d ;
                    
                    int money = month * [[array firstObject] floatValue]  + moDays * dayMonths ;
                    
                    moneyNum = [NSNumber numberWithInt:money];
                    
                }else{
                
                    moneyNum = [NSNumber numberWithInt:month * [[array firstObject] floatValue]];
                    
                }
            }
        }

    return moneyNum;
}



@end
