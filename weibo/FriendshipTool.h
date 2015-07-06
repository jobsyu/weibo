//
//  FriendshipTool.h
//  weibo
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 ycp. All rights reserved.
//


typedef void (^FollowersSuccessBlock)(NSArray *followers);
typedef void (^FollowersFailureBlock)(NSError *error);

typedef void (^FriendsSuccessBlock)(NSArray *friends);
typedef void (^FriendsFailureBlock)(NSError *error);

#import <Foundation/Foundation.h>

@interface FriendshipTool : NSObject
+(void)followersWithId:(long long)ID success:(FollowersSuccessBlock)success failure:(FollowersFailureBlock)failure;

+(void)friendsWithId:(long long)ID success:(FriendsSuccessBlock)success failure:(FriendsFailureBlock)failure;
@end
