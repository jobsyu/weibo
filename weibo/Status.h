//
//  Status.h
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseText.h"
@interface Status : BaseText
@property (nonatomic,strong) NSArray *picUrls; //微博配图
@property (nonatomic,strong) Status *retweetedStatus;//被转发微博
@property (nonatomic,copy) NSString *source; //微博来源
@property (nonatomic,assign) int attitudesCount; //点赞数
@property (nonatomic,assign) int commentsCount; //评论数
@property (nonatomic,assign) int repostsCount; //转发数
@end
