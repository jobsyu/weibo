//
//  BaseModel.m
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.ID = [dict[@"id"] longLongValue];
        self.createdAt = dict[@"created_at"];
    }
    return self;
}

-(NSString *)createdAt
{
    //WXLog(@"%@",self.createdat);
    //1.将新浪时间字符串转化为NSDate对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:_createdAt];
    
    //2.获得当前时间
    NSDate *now = [NSDate date];
    
    //3.获得当前时间和微博发送时间的间隔（差多少秒）
    NSTimeInterval interval = [now timeIntervalSinceDate:date];
    //NSDate *date = [fmt ];
    //4.根据时间间隔算出合理的字符串
    if (interval < 60) { //1分钟
        return @"刚刚";
    } else if (interval < 60 *60 ){//1小时
        return [NSString stringWithFormat:@"%.f分钟前",interval/60];
    } else if (interval < 60 * 60 * 24){//1天内
        return [NSString stringWithFormat:@"%.f小时前",interval/60/60];
    } else {
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }
}

@end
