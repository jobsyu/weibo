//
//  DetailHeader.h
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;

@interface DetailHeader : UIView

@property (weak,nonatomic) IBOutlet UIButton *attitude;
@property (weak,nonatomic) IBOutlet UIButton *repost;
@property (weak,nonatomic) IBOutlet UIButton *comment;
@property (weak,nonatomic) IBOutlet UIImageView *hint;
- (IBAction)btnClick:(UIButton *)sender;
+ (id)header;

@property (nonatomic,strong) Status *status;
@end
