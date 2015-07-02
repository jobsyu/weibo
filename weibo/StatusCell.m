//
//  StatusCell.m
//  weibo
//
//  Created by qianfeng on 15/7/2.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"

@interface StatusCell()
{
    UIImageView *_icon; //头像
    UILabel *_screenName; //昵称
    UILabel *_time; //时间
    UILabel *_source; //来源
    UILabel *_text; //内容
    UIImageView *_image; //配图
    
    UIImageView *_retweeted; //被转发微博的父控件
    UILabel *_retweetedScreenName; //被转发微博作者的昵称
    UILabel *_retweetedText; // 被转发微博的内容
    UIImageView *_retweetedImage; //被转发微博的配图
}
@end

@implementation StatusCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加微博本身所有子控件
        [self addAllSubViews];
        //添加转发所有子控件
        [self addReweetedViews];
    }
    return self;
}


-(void)addAllSubViews
{
    //头像
    _icon = [[UIImageView alloc] init];
    [self.contentView addSubview:_icon];
    
    //昵称
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;  //17号字体
    [self.contentView addSubview:_screenName];
    
    //时间
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;  //13号字体
    [self.contentView addSubview:_time];
    
    //来源
    _source = [[UILabel alloc] init];
    _source.font = kSourceFont; //13号字体
    [self.contentView addSubview:_source];
    
    //内容
    _text = [[UILabel alloc] init];
    _text.font = kTextFont; //15号字体
    _text.numberOfLines = 0; //换行
    [self.contentView addSubview:_text];
    
    //配图
    _image = [[UIImageView alloc] init];
    [self.contentView addSubview:_image];
    
}


-(void)addReweetedViews
{
    //被转发微博的父控件
    _retweeted = [[UIImageView alloc] init];
    [self.contentView addSubview:_retweeted];
    
    //被转发微博作者的昵称
    _retweetedScreenName = [[UILabel alloc] init];
    _retweetedScreenName.font = kRetweetedScreenNameFont; //16号字体
    [_retweeted addSubview:_retweetedScreenName];
    
    // 被转发微博的内容
    _retweetedText = [[UILabel alloc] init];
    _retweetedScreenName.font = kRetweetedTextFont; //16号字体
    _retweetedScreenName.numberOfLines = 0;
    [_retweeted addSubview:_retweetedText];
    
    //被转发微博的配图
    _retweetedImage = [[UIImageView alloc] init];
    [_retweeted addSubview:_retweetedImage];
}

-(void)setStatusCellFrame:(StatusCellFrame *)statusCellFrame
{
    _statusCellFrame = statusCellFrame;
    
    Status *status =statusCellFrame.status;
    
    //1. 头像
    _icon.frame = statusCellFrame.iconFrame;
    NSURL *iconUrl = [NSURL URLWithString:status.user.profileImageUrl];
    [_icon sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"Icon"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
    //2 .昵称
    _screenName.frame = statusCellFrame.screenNameFrame;
    _screenName.text = status.user.screenName;
    
    //3. 时间
    _time.frame = statusCellFrame.timeFrame;
    _time.text = status.createdat;
    
    //4. 来源
    _source.frame = statusCellFrame.sourceFrame;
    _source.text= status.source;
    
    //5. 内容
    _text.frame = statusCellFrame.textFrame;
    _text.text =status.text;
    
    //6. 配图
    if (status.picUrls.count) {
        _image.hidden = NO;
        _image.frame = statusCellFrame.imageFrame;
        NSString *imageStr = status.picUrls[0][@"thumbnail_pic"];
        NSURL *imageUrl = [NSURL URLWithString:imageStr];
        [_image sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    } else {
        _image.hidden = YES;
    }
    
    // 7.被转发微博
    if (status.retweetedStatus) {
        _retweeted.hidden = NO;
        //被转发微博的父控件
        _retweeted.frame = statusCellFrame.RetweetedFrame;
        
        //8.被转发微博作者的昵称
        _retweetedScreenName.frame = statusCellFrame.RetweetedScreenNameFrame;
        _retweetedScreenName.text = status.retweetedStatus.user.screenName;
        
        //9.被转发微博的内容
        _retweetedText.frame = statusCellFrame.RetweetedTextFrame;
        _retweetedText.text = status.retweetedStatus.text;
        
        //10.被转发微博的配图
        if (status.retweetedStatus.picUrls.count) {
            _retweetedImage.hidden = NO;
            _retweetedImage.frame = statusCellFrame.RetweetedImageFrame;
            NSString *retweetImageStr = status.retweetedStatus.picUrls[0][@"thumbnail_pic"];
            NSURL *imageUrl = [NSURL URLWithString:retweetImageStr];
            [_retweetedImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
        } else {
            _retweetedImage.hidden = YES;
        }
    } else {
        _retweeted.hidden = YES;
    }
}
@end
