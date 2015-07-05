//
//  HomeController.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//
// 导航栏高度
#define NavigationHeight CGRectGetMaxY([self.navigationController navigationBar].frame)

#import "HomeController.h"
#import "Status.h"
#import "StatusTool.h"
#import "User.h"
#import "StatusCellFrame.h"
#import "UIImageView+WebCache.h"
#import "StatusCell.h"
#import "MJRefresh.h"
#import "StatusDetailController.h"

@interface HomeController()
@property (nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation HomeController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.设置界面属性
    [self buildUI];
    
    //2.集成刷新控件
    [self addRefreshViews];
}

#pragma mark 集成刷新控件
-(void)addRefreshViews
{
    _statusFrames = [NSMutableArray array];
    
    //1.下拉加载
    [self headerRefresh];
    //2.上拉刷新
    [self footerRefresh];
}


#pragma mark 下拉加载
-(void)headerRefresh
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}

#pragma mark 上拉刷新
-(void)footerRefresh
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

#pragma mark 加载最新的微博数据
-(void)loadNewData
{
    //1.第一条微博的ID
    StatusCellFrame *f = _statusFrames.count?_statusFrames[0]:nil;
    long long first = [f.status ID];
    
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
        [self.tableView.header endRefreshing];
        
        //5.顶部展示最新微博的数目
        [self showNewStatusCount:statues.count];
    } failure:^(NSError *error){
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark 加载更多的微博数据
-(void)loadMoreData
{
    StatusCellFrame *f = [_statusFrames lastObject];
    long long last = [f.status ID];

    //获取微博数据
    [StatusTool statusesWithSinceId:0 maxId:last-1 success:^(NSArray *statues) {
        // 1.在拿到最新微博数据的同时计算它的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statues) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status =s;
            [newFrames addObject:f];
        }
        
        // 2.将新数据插入到旧数据中
        [_statusFrames addObjectsFromArray:newFrames];
        
        // 3.刷新表格
        [self.tableView reloadData];
        
        // 4.让刷新控件停止刷新状态
        [self.tableView.footer endRefreshing];
    } failure:^(NSError *error){
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark 展示最新微博的数目
-(void)showNewStatusCount:(int)count
{
    //创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.enabled = NO;
    btn.adjustsImageWhenHighlighted = NO;
    
    [btn setBackgroundImage:[UIImage resizedImage:@"timeline_new_status_background.png"] forState:UIControlStateNormal];
    CGFloat w = self.view.frame.size.width;
    CGFloat h = 35;
    btn.frame = CGRectMake(0, NavigationHeight -h, w, h);
    [btn setTitle:count?[NSString stringWithFormat:@"共有%d条新的微博",count]:@"没有新的微博" forState:UIControlStateNormal];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    //2.开始执行动画
    CGFloat duration = 0.5;
    
    [UIView animateWithDuration:duration animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform =CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
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
    
    cell.cellFrame = _statusFrames[indexPath.row];
//    cell.textLabel.text = s.text;
//    cell.detailTextLabel.text = s.user.screenName;
    //cell.imageView.image
    
    return cell;
}

#pragma mark 返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusCellFrame *f = _statusFrames[indexPath.row];
//    f.status = _statuses[indexPath.row];
    return  f.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusDetailController *detail = [[StatusDetailController alloc] init];
    StatusCellFrame *f = _statusFrames[indexPath.row];
    detail.status = f.status;
    
    [self.navigationController pushViewController:detail animated:YES];
}
@end
