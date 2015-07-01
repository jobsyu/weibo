//
//  User.m
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "User.h"

@implementation User

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.screenName = dict[@"screen_name"];
    }
    return self;
}

@end
