//
//  Account.m
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "Account.h"

@implementation Account
#pragma mark 归档的时候用
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_accessToken forKey:@"accessToken"];
    [encoder encodeObject:_uid forKey:@"uid"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.accessToken = [decoder decodeObjectForKey:@"accessToken"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
    }
    return self;
}
@end
