//
//  BaseText.m
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "BaseText.h"
#import "User.h"

@implementation BaseText

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        self.user = [[User alloc] initWithDict:dict[@"user"]];
        self.text = dict[@"text"];
    }
    return self;
}

@end
