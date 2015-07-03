//
//  Status.m
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "Status.h"
#import "User.h"

@implementation Status
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.text = dict[@"text"];
        self.user = [[User alloc] initWithDict:dict[@"user"]];
        self.picUrls = dict[@"pic_urls"];
        
        NSDictionary *retweet = dict[@"retweeted_status"];
        if (retweet) {
            self.retweetedStatus = [[Status alloc] initWithDict:dict[@"retweeted_status"]];
        }
        
        self.createdat = dict[@"created_at"];
        self.source = dict[@"source"];
        
        self.repostsCount = [dict[@"reposts_count"] intValue];
        self.commentsCount = [dict[@"comments_count"] intValue];
        self.attitudesCount = [dict[@"attitudes_count"] intValue];
    }
    return self;
}

-(NSString *)createdat
{
    //WXLog(@"%@",self.createdat);
    //1.将新浪时间字符串转化为NSDate对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:_createdat];
    
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
//
//-(NSString *)source
//{
//    //<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
//    WXLog(@"source%@",_source);
//    int begin = [_source rangeOfString:@">"].location+1;
//    int end = [_source rangeOfString:@"</"].location;
//    
//    
//    return [NSString stringWithFormat:@"来自%@",[_source substringWithRange:NSMakeRange(begin,end-begin)]];
//}


-(void)setSource:(NSString *)source
{
    int begin = [source rangeOfString:@">"].location+1;
    int end = [source rangeOfString:@"</"].location;
    
    if(end-begin < source.length){
        _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:NSMakeRange(begin,end-begin)]];
    }

}
@end
