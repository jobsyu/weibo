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
@property (nonatomic,strong) NSMutableArray *statuses;

@end

@implementation HomeController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.设置界面属性
    [self buildUI];
    
    //2.获得用户的微博数据
    [self loadStatusData];
}

#pragma mark 加载微博数据
-(void)loadStatusData
{
    _statuses = [NSMutableArray array];
    
    //获取微博数据
    [StatusTool statusesWithSuccess:^(NSArray *statues) {
        [_statuses addObjectsFromArray:statues];
        
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
    self.view.backgroundColor = [UIColor whiteColor];
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
    return _statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    StatusCellFrame *f = [[StatusCellFrame alloc] init];
    f.status = _statuses[indexPath.row];
    cell.statusCellFrame = f;
//    cell.textLabel.text = s.text;
//    cell.detailTextLabel.text = s.user.screenName;
    //cell.imageView.image
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusCellFrame *f = [[StatusCellFrame alloc] init];
    f.status = _statuses[indexPath.row];
    return  f.cellHeight;
}
@end
