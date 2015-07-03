//
//  HomeController.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "HomeController.h"
#import "Status.h"
#import "StatusTool.h"
#import "User.h"
#import "StatusCellFrame.h"
#import "UIImageView+WebCache.h"
#import "StatusCell.h"

@interface HomeController()
@property (nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation HomeController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.设置界面属性
    [self buildUI];
    
    //2.获得用户的微博数据
    [self loadStatusData];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refresh];
    [refresh addTarget:self action:@selector(startRefresh:) forControlEvents:UIControlEventValueChanged];
}

-(void)startRefresh:(UIRefreshControl *)refresh
{
    //1.第一条微博的ID
    long long first = [[_statusFrames[0] status] ID];
    
    //2.获取微博数据
    [StatusTool statusesWithSinceId:first maxId:0 success:^(NSArray *
        statues) {
        //1.在拿到最新微博数据的同时计算它的frame
        NSMutableArray *newFrames =[NSMutableArray array];
        for (Status *s in statues) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status = s;
            [newFrames addObject:f];
        }
        
        //2.将newFrames整体插入到旧数据的前面
        [_statusFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        
        //3.刷新表格
        [self.tableView reloadData];
        
        //4.让刷新控件停止刷新状态
        [refresh endRefreshing];
    } failure:nil];
}

#pragma mark 加载微博数据
-(void)loadStatusData
{
    _statusFrames = [NSMutableArray array];
    
    //获取微博数据
    [StatusTool statusesWithSinceId:0 maxId:0 success:^(NSArray *statues) {
        // 1.在拿到最新微博数据的同时计算它的frame
        for (Status *s in statues) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status =s;
            [_statusFrames addObject:f];
        }
        
        // 2.刷新表格
        [self.tableView reloadData];
    } failure:nil];
}

#pragma mark 设置界面属性
-(void)buildUI
{
    //1.设置标题
    self.title = @"首页";
    
    //2.左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithIcon:@"navigationbar_compose" highlightedIcon:@"navigationbar_compose_highlighted" target:self action:@selector(compose)];
    //3.右边的item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithIcon:@"navigationbar_pop" highlightedIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    //4.背景颜色
    self.view.backgroundColor = kGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)pop
{
    WXLog(@"pop");
}

-(void)compose
{
    WXLog(@"compose");
}

#pragma mark - Table view data source 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.statusCellFrame = _statusFrames[indexPath.row];
//    cell.textLabel.text = s.text;
//    cell.detailTextLabel.text = s.user.screenName;
    //cell.imageView.image
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusCellFrame *f = _statusFrames[indexPath.row];
//    f.status = _statuses[indexPath.row];
    return  f.cellHeight;
}
@end
