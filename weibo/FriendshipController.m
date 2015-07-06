//
//  FriendshipController.m
//  weibo
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "FriendshipController.h"
#import "User.h"
#import "HttpTool.h"
#import "AccountTool.h"

@implementation FriendshipController
kHideScroll

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _data = [NSMutableArray array];
}


#pragma mark  - Table View data source 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return _data.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    User *u = _data[indexPath.row];
    //头像
    [HttpTool downloadImage:u.profileImageUrl place:[UIImage imageNamed:@"Icon.png"] imageView:cell.imageView];
    
    //昵称
    cell.textLabel.text = u.screenName;
    
    return cell;
}

@end
