//
//  MoreController.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#pragma mark 这个类只用在MoreController

@interface LogutBtn : UIButton
@end

@implementation LogutBtn

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width - 2 * x;
    CGFloat height = contentRect.size.height;
    return CGRectMake(x, y, width, height);
}
@end

#import "MoreController.h"
#import "GroupCell.h"

@interface MoreController()
{
    NSArray *_data;
}
@end

@implementation MoreController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    //1.搭建界面
    [self buildUI];
    
    //2读取plist文件的内容
    [self loadPlist];
    
    //3.设置tableView属性
    [self buildTableView];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section  == _data.count -1) {
        return 10;
    }
    return 0;
}

#pragma mark 搭建UI界面
-(void)buildUI
{
    // 1.设置标题
    self.title = @"更多";
    // 2.设置右上角按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)loadPlist
{
    //获取路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"More" withExtension:@"plist"];
    _data = [NSArray arrayWithContentsOfURL:url];
}

#pragma mark 设置tableview属性
-(void)buildTableView
{
   //1.设置背景
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    //2.设置tableView每组头部的高度
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 0;
    
    //3.要在tableview底部添加一个按钮
    LogutBtn *logout = [LogutBtn buttonWithType:UIButtonTypeCustom];
    [logout setImage:[UIImage resizedImage:@"common_button_big_red.png"] forState:UIControlStateNormal];
    [logout setImage:[UIImage resizedImage:@"common_button_big_red_highlighted.png"] forState:UIControlStateHighlighted];
    logout.bounds = CGRectMake(0, 0, 0, 44);
    
    //4.设置按钮文字
    [logout setTitle:@"退出登录" forState:UIControlStateNormal];
    
    self.tableView.tableFooterView = logout;
    
    //增加底部额外的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return _data.count;
}

#pragma mark 每当有一个新的cell进入屏幕视野范围内就会调用
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.myTableView = tableView;
    }
    
    //1.取出这行对应的字典数据
    NSDictionary *dict = _data[indexPath.section][indexPath.row];
    
    //2.设置文字
    cell.textLabel.text = dict[@"name"];
    
    //3.设置cell的背景
    cell.indexPath = indexPath;
    
    if (indexPath.section == 2) {
        cell.cellType = kCellTypeLabel;
        cell.rightLabel.text = indexPath.row?@"有图模式":@"经典主题";
    } else {
        cell.cellType = kCellTypeArrow;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
