//
//  DetailHeader.h
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status,DetailHeader;

typedef enum {
    kDetailHeaderBtnTypeRepost, //转发
    kDetailHeaderBtnTypeComment, //评论
} DetailHeaderBtnType;

@protocol DetailHeaderDelgate <NSObject>

@optional
-(void)detailHeader:(DetailHeader *)header btnClick:(DetailHeaderBtnType)index;

@end

@interface DetailHeader : UIView

@property (weak,nonatomic) IBOutlet UIButton *attitude;
@property (weak,nonatomic) IBOutlet UIButton *repost;
@property (weak,nonatomic) IBOutlet UIButton *comment;
@property (weak,nonatomic) IBOutlet UIImageView *hint;
- (IBAction)btnClick:(UIButton *)sender;
+ (id)header;

@property (nonatomic,strong) Status *status;
@property (nonatomic,weak) id<DetailHeaderDelgate> delegate;

@property (nonatomic,assign,readonly) DetailHeaderBtnType currentBtnType;

@end
