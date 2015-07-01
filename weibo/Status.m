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
    }
    return self;
}
@end
