//
//  StatusDetailController.m
//  weibo
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "StatusDetailController.h"
#import "Status.h"
#import "StatusDetailCellFrame.h"
#import "StatusDetailCell.h"
#import "DetailHeader.h"

@interface StatusDetailController ()
{
    StatusDetailCellFrame *_DetailFrame;
}
@end

@implementation StatusDetailController
kHideScroll

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
    self.view.backgroundColor = kGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _DetailFrame = [[StatusDetailCellFrame alloc] init];
    _DetailFrame.status =_status;
   
}

#pragma mark - Table view data source

#pragma mark 1.有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

#pragma mark 2.第section组头部控件有多高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0;
    return 50;
}

#pragma mark 3.第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 0) return 1;
    return 50;

}

#pragma mark 4.indexPath这行的cell有多高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _DetailFrame.cellHeight;
    }
    
    return 44;
}

#pragma mark 5.indexPath这行的cell长什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) { //微博详情
        static NSString *CellIdentifier = @"DetailCell";
        StatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[StatusDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.cellFrame = _DetailFrame;
        
        return cell;
    }
    
    static NSString *CellIdentifier =@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

#pragma mark 6.第section组头部显示什么控件
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    
    DetailHeader *header = [DetailHeader header];
    header.status = _DetailFrame.status;
    return header;
}


@end
