//
//  GroupCell.h
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kCellTypeNone, //没有样式
    kCellTypeArrow, //箭头
    kCellTypeLabel, //文字
    kCellTypeSwitch //开关
}CellType;

@interface GroupCell : UITableViewCell

@property (nonatomic,readonly) UISwitch *rightSwitch;
@property (nonatomic,readonly) UILabel *rightLabel;

@property (nonatomic,assign) CellType cellType;
@property (nonatomic,weak) UITableView *myTableView;
@property (nonatomic,strong) NSIndexPath *indexPath;

@end
