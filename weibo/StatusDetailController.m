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
#import "RepostCell.h"
#import "CommentCell.h"
#import "RepostCellFrame.h"
#import "StatusTool.h"
#import "CommentCellFrame.h"
#import "MJRefresh.h"

@interface StatusDetailController ()<DetailHeaderDelgate>
{
    StatusDetailCellFrame *_detailFrame;
    NSMutableArray *_repostFrames; //转发
    NSMutableArray *_commentFrames; //评论
    
    DetailHeader *_detailHeader;
    
    BOOL _commentLastPage; //评论数据是否为最后一页
    BOOL _repostLastPage; //转发数据是否为最后一页
}
@end

@implementation StatusDetailController
kHideScroll

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
    self.view.backgroundColor = kGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTableBorderWidth, 0);
    
    _detailFrame = [[StatusDetailCellFrame alloc] init];
    _detailFrame.status =_status;
    
    _repostFrames = [NSMutableArray array];
    _commentFrames = [NSMutableArray array];
    
    [self headerRefresh];
    [self footerRefresh];
    
    _detailHeader = [DetailHeader header];
    _detailHeader.delegate =self;
    
    //默认点击了“评论”
    [self detailHeader:nil btnClick:kDetailHeaderBtnTypeComment];
}

#pragma mark 下拉加载
-(void)headerRefresh
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
          [weakSelf loadNewStatus];
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
        if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeRepost) {
            [weakSelf loadMoreRepost];
        } else {
            [weakSelf loadMoreComment];
        }
    }];
}

#pragma mark 返回当前的数组Frame
-(NSMutableArray *)currentFrame
{
    if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment) {
        return _commentFrames;
    } else {
        return _repostFrames;
    }
}

#pragma mark - Table view data source

#pragma mark 1.有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    // 1.判断上拉加载更多控件要不要显示
    if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment) {
        self.tableView.footer.hidden = _commentLastPage;
    } else {
        self.tableView.footer.hidden = _repostLastPage;
    }
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
    // Return the number of rows in the section.
    return section ? [[self currentFrame] count]:1;
}

#pragma mark 4.indexPath这行的cell有多高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _detailFrame.cellHeight;
    } else {
        return [self.currentFrame[indexPath.row] cellHeight];
    }
}

#pragma mark 5.indexPath这行的cell长什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) { //微博详情
        static NSString *CellIdentifier = @"DetailCell";
        StatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[StatusDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.cellFrame = _detailFrame;
        
        return cell;
    } else if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeRepost){
        //转发cell
        static NSString *CellIdentifier=@"RepostCell";
        RepostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[RepostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.myTableView = tableView;
        }
        
        cell.indexPath = indexPath;
        cell.cellFrame = _repostFrames[indexPath.row];
        return cell;
    } else{
        //评论cell
        static NSString *CellIdentifier = @"CommentCell";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.myTableView =tableView;
        }
        
        cell.indexPath =indexPath;
        cell.cellFrame = _commentFrames[indexPath.row];
        return cell;
    }
}

#pragma mark 6.第section组头部显示什么控件
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;

    _detailHeader.status = _status;
    return _detailHeader;
}

#pragma mark 解析模型数据为frame数据
-(NSMutableArray *)framesWithModels:(NSArray *)models class:(Class)class
{
    NSMutableArray *newFrames = [NSMutableArray array];
    for (BaseText *s in models) {
        BaseTextCellFrame *f = [[class alloc] init];
        f.baseText = s;
        [newFrames addObject:f];
    }
    return newFrames;
}

#pragma mark － DetailHeader的代理方法
-(void)detailHeader:(DetailHeader *)header btnClick:(DetailHeaderBtnType)index
{
   //1.先刷新表格（马上显示对应的旧数据）
    [self.tableView reloadData];
    
    if (index == kDetailHeaderBtnTypeRepost) {
        [self loadNewRepost];
    } else if (index == kDetailHeaderBtnTypeComment){
        [self loadNewComment];
    }
}

#pragma mark 加载最新的微博数据
-(void)loadNewStatus
{
    [StatusTool statusWithId:_status.ID success:^(Status *status) {
        _status = status;
        _detailFrame.status = status;
        
        //刷新表格
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark 加载最新的转发数据
-(void)loadNewRepost
{
    long long firstId = _repostFrames.count?[[_repostFrames[0] baseText] ID]:0;
    
    [StatusTool repostsWithSinceId:firstId maxId:0 statusId:_status.ID success:^(NSArray *reposts, int totalNumber, long long nextCursor) {
        NSMutableArray *newFrames = [self framesWithModels:reposts class:[RepostCellFrame class]];
        
        _status.repostsCount =totalNumber;
        
        //2添加数据
        [_repostFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        
        _repostLastPage = nextCursor == 0;
        
        //3.刷新表格
        [self.tableView reloadData];
        
        //success(reposts);
    } failure:nil];
}

#pragma mark 加载最新的评论数据
-(void)loadNewComment
{
    long long firstId = _commentFrames.count?[[_commentFrames[0] baseText] ID]:0;
    
    [StatusTool commentsWithSinceId:firstId maxId:0 statusId:_status.ID success:^(NSArray *comments, int totalNumber, long long nextCursor) {
        NSMutableArray *newFrames = [self framesWithModels:comments class:[CommentCellFrame class]];
        
        _status.commentsCount =totalNumber;
        
        //2添加数据
        [_commentFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        
        _commentLastPage = nextCursor == 0;
        
        //3.刷新表格
        [self.tableView reloadData];
        
     //success(reposts);
    } failure:nil];

}

#pragma mark 加载更多的转发数据
-(void)loadMoreRepost
{
    long long lastId = [[_repostFrames lastObject] baseText].ID - 1;
    
    [StatusTool repostsWithSinceId:0 maxId:lastId statusId:_status.ID success:^(NSArray *reposts, int totalNumber, long long nextCursor) {
        NSMutableArray *newFrames = [self framesWithModels:reposts class:[RepostCellFrame class]];
        
        _status.repostsCount =totalNumber;
        
        //2添加数据
        [_repostFrames addObjectsFromArray:newFrames];
        
        _repostLastPage = nextCursor == 0;
        
        //3.刷新表格
        [self.tableView reloadData];
        
        [self.tableView.footer endRefreshing];
        //success(reposts);
    } failure:^(NSError *error) {
        if (error == nil) return;
        
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark 加载更多的评论数据
-(void)loadMoreComment
{
    long long lastId = [[_commentFrames lastObject] baseText].ID - 1;
    
    [StatusTool repostsWithSinceId:0 maxId:lastId statusId:_status.ID success:^(NSArray *comments, int totalNumber, long long nextCursor) {
        NSMutableArray *newFrames = [self framesWithModels:comments class:[CommentCellFrame class]];
        
        _status.commentsCount =totalNumber;
        
        //2添加数据
        [_commentFrames addObjectsFromArray:newFrames];
        
        
        _commentLastPage = nextCursor == 0;
        //3.刷新表格
        [self.tableView reloadData];
        
        [self.tableView.footer endRefreshing];
        //success(reposts);
    } failure:^(NSError *error) {
        if (error == nil) return;
        
        [self.tableView.footer endRefreshing];
    }];
}
@end
