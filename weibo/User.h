//
//  User.h
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,copy) NSString *screenName;

-(id)initWithDict:(NSDictionary *)dict;
@end
