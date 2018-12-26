//
//  NSDate+Tool.m
//  JIIESTCar
//
//  Created by wzh on 16/1/11.
//  Copyright © 2016年 WZH. All rights reserved.
//

#import "NSDate+Tool.h"

@implementation NSDate (Tool)

#pragma mark - date

- (NSDate *)getLastDayInYear{
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    BOOL result = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitYear startDate:&beginDate interval:&interval forDate:self];
    
    if (result) {
        endDate=[beginDate dateByAddingTimeInterval:interval-1];
    }
    return endDate;
    
}

- (NSDate *)getFirstDayInYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *com = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    [com setMonth:1];
    [com setDay:1];
    NSDate *date = [calendar dateFromComponents:com];
    return date;
}


- (NSDate *)getLastDayInMonth
{
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    BOOL result = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:self];
    
    if (result) {
        endDate=[beginDate dateByAddingTimeInterval:interval-1];
    }
    return endDate;
}

- (NSDateComponents *)components
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:self];
    return components;
    
}

- (NSInteger)hour{
    NSDateComponents *com = [self components];
    return com.hour;
}

- (NSInteger)minute{
    NSDateComponents *com = [self components];
    return com.minute;
}

- (NSInteger)day{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components day];
}


- (NSInteger)month{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components month];
}

- (NSInteger)year{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components year];
}


- (NSInteger)firstWeekdayInMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    [comp setDay:1];
    
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    
    return firstWeekday - 1;
}
-(NSInteger)lastWeekdayInMouth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    [comp setDay:[self totaldaysInMonth]];
    
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger lastWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    
    return lastWeekday - 1;
    
}

- (NSInteger)totaldaysInMonth{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return daysInLastMonth.length;
}


//---上周

- (NSDate *)lastWeek{
    
    NSDate *date = [self lastDay:7];
    
    return date;
}


- (NSDate *)lastMonth{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate*)nextMonth{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}


- (NSDate *)lastMonth:(int)count{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -count;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}


- (NSDate *)nextYear{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)nextYearWithMonth:(int)month{
    
    NSDate *temDate = [self nextYear];
    
    NSDateComponents *com = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:temDate];
    com.month = month;
    
    NSDate *newDate = [[NSCalendar currentCalendar]dateFromComponents:com];
    return newDate;
}

- (NSInteger)currentWeekday
{
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps=[[NSDateComponents alloc]init];
    
    NSInteger unit= NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    comps=[calendar components:unit fromDate:self];
    
    return [comps weekday];
}


-(NSDate *)nextDay{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

-(NSDate *)nextDay:(NSInteger)count{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = +count;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)lastDay:(NSInteger)count{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -count;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
    
}
-(NSDate *)lastDay{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)getLocalDate
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: self];
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    return localeDate;
}

-(NSInteger)getDaysToDate:(NSDate *)endDate
{
    //去掉时分秒信息
    NSCalendar *cal=[NSCalendar currentCalendar];
    
    NSDate *fromDate;
    NSDate *toDate;
    [cal rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:self];
    [cal rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [cal components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return dayComponents.day;
}

-(NSInteger)getDaysFromDateInMinute:(NSDate *)endDate{
    
    NSCalendar *cal=[NSCalendar currentCalendar];
    
    NSDate *fromDate;
    NSDate *toDate;
    [cal rangeOfUnit:NSCalendarUnitMinute startDate:&fromDate interval:NULL forDate:self];
    [cal rangeOfUnit:NSCalendarUnitMinute startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [cal components:NSCalendarUnitMinute fromDate:fromDate toDate:toDate options:0];
    
    NSInteger days =ceilf(dayComponents.minute/(24.f*60));
    
    if (days<1) {
        days = 1;
    }
    return days;
}

- (CGFloat)getHoursFromDate:(NSDate *)endDate{
    
    NSCalendar *cal=[NSCalendar currentCalendar];
    
    NSDate *fromDate;
    NSDate *toDate;
    [cal rangeOfUnit:NSCalendarUnitMinute startDate:&fromDate interval:NULL forDate:self];
    [cal rangeOfUnit:NSCalendarUnitMinute startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [cal components:NSCalendarUnitMinute fromDate:fromDate toDate:toDate options:0];
    
    CGFloat hour =dayComponents.minute/(60.f);
    return hour;
}

- (NSComparisonResult)compareDayToDate:(NSDate *)endDate{
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSComparisonResult result=[cal compareDate:self toDate:endDate toUnitGranularity:NSCalendarUnitDay];
    return result;
}

- (NSDate *)dateAfterHour:(NSInteger)hour{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.hour = +hour;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

+ (BOOL)isDateToday:(NSDate *)date{
    BOOL isToday = [[NSCalendar currentCalendar]isDateInToday:date];
    return isToday;
}

- (NSInteger)getMonthIntervalFromDate:(NSDate *)endDate{
    NSCalendar *cal=[NSCalendar currentCalendar];
    
    NSDate *fromDate;
    NSDate *toDate;
    [cal rangeOfUnit:NSCalendarUnitMonth startDate:&fromDate interval:NULL forDate:self];
    [cal rangeOfUnit:NSCalendarUnitMonth startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *monthComponents = [cal components:NSCalendarUnitMonth fromDate:fromDate toDate:toDate options:0];
    return monthComponents.month + 1 ;
}


+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format{

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    
    NSString *string = [formatter stringFromDate:date];
    
    return string;
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    
    NSDate *date = [formatter dateFromString:string];
    
    return date;
}

+ (NSString *)stringFromTimeStamp:(NSTimeInterval)timeStamp withFormat:(NSString *)format{
    
    NSString *str = [NSString stringWithFormat:@"%lld",(long long)timeStamp];
    if ([str length]==13) {
        timeStamp = timeStamp/1000;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString *string = [formatter stringFromDate:date];
    
    return string;
}

+ (NSTimeInterval )timeStamp:(NSDate *)date{
    NSTimeInterval interval = ((long long)[date timeIntervalSince1970])*1000;
    return interval;
}

+ (NSDate *)firstDayInMonth:(NSDate *)date{
    double interval = 0;
    NSDate *beginDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:date];
    return beginDate;
}

+ (NSDate *)lastDayInMonth:(NSDate *)date{
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:date];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }
    return endDate;
}


@end
