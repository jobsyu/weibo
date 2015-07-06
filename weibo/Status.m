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
    if (self = [super initWithDict:dict]) {
        self.picUrls = dict[@"pic_urls"];
        
        NSDictionary *retweet = dict[@"retweeted_status"];
        if (retweet) {
            self.retweetedStatus = [[Status alloc] initWithDict:retweet];
        }
        self.source = dict[@"source"];
        
        self.repostsCount = [dict[@"reposts_count"] intValue];
        self.commentsCount = [dict[@"comments_count"] intValue];
        self.attitudesCount = [dict[@"attitudes_count"] intValue];
    }
    return self;
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
