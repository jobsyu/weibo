//
//  BaseTextCell.h
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "BaseWordCell.h"
@class BaseTextCellFrame;
@interface BaseTextCell : BaseWordCell
@property (nonatomic,strong) BaseTextCellFrame *cellFrame;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,weak) UITableView *myTableView;
@end
