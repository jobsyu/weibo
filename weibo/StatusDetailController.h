//
//  StatusDetailController.h
//  weibo
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@interface StatusDetailController : UITableViewController
@property (nonatomic,strong) Status *status;
@end
