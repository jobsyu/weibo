//
//  StatusCell.h
//  weibo
//
//  Created by qianfeng on 15/7/2.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#define kCellBorderWidth 10

#define kScreenNameFont [UIFont systemFontOfSize:17]
#define kTimeFont  [UIFont systemFontOfSize:13]
#define kSourceFont kTimeFont
#define kTextFont  [UIFont systemFontOfSize:15]

#define kRetweetedTextFont [UIFont systemFontOfSize:16]
#define kRetweetedScreenNameFont [UIFont systemFontOfSize:16]

#import <UIKit/UIKit.h>
@class StatusCellFrame;

@interface StatusCell : UITableViewCell

@property (nonatomic,strong) StatusCellFrame *statusCellFrame;
@end
