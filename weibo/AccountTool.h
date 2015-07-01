//
//  AccountTool.h
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h";

@interface AccountTool : NSObject
single_interface(AccountTool)

-(void)saveAccount:(Account *)account;

@property (nonatomic,readonly) Account *account;
@end
