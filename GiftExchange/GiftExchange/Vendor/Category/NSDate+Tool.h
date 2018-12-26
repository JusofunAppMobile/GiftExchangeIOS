//
//  NSDate+Tool.h
//  JIIESTCar
//
//  Created by wzh on 16/1/11.
//  Copyright © 2016年 WZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Tool)

//- (NSInteger)currentWeekday:(NSDate *)_temDate;

- (NSDateComponents *)components;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)year;
- (NSInteger)hour;
- (NSInteger)minute;

- (NSInteger)firstWeekdayInMonth;
- (NSInteger)lastWeekdayInMouth;
- (NSInteger)totaldaysInMonth;

- (NSDate *)lastWeek;

- (NSDate *)lastMonth;
- (NSDate *)nextMonth;
- (NSDate *)lastMonth:(int)count;

- (NSInteger)currentWeekday;
- (NSDate *)nextDay;
- (NSDate *)lastDay;
- (NSDate *)nextDay:(NSInteger)count;
- (NSDate *)lastDay:(NSInteger)count;

- (NSDate *)getLocalDate;
- (NSDate *)getLastDayInMonth;
- (NSInteger)getDaysToDate:(NSDate *)endDate;
- (NSInteger)getDaysFromDateInMinute:(NSDate *)endDate;


- (NSComparisonResult)compareDayToDate:(NSDate *)endDate;
- (NSDate *)getLastDayInYear;
- (NSDate *)getFirstDayInYear;

- (NSDate *)nextYear;
- (CGFloat)getHoursFromDate:(NSDate *)endDate;
- (NSDate *)dateAfterHour:(NSInteger)hour;
+ (BOOL)isDateToday:(NSDate *)date;
- (NSInteger)getMonthIntervalFromDate:(NSDate *)endDate;
- (NSDate *)nextYearWithMonth:(int)month;

//date转string
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
//string转date
+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)format;
//时间戳转string
+ (NSString *)stringFromTimeStamp:(NSTimeInterval)timeStamp withFormat:(NSString *)format;
//- (NSDate *)firstDayInMonth;

+ (NSTimeInterval)timeStamp:(NSDate *)date;

+ (NSDate *)firstDayInMonth:(NSDate *)date;

+ (NSDate *)lastDayInMonth:(NSDate *)date;


@end
