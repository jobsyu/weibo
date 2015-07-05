//
//  BaseStatusCell.m
//  weibo
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "BaseStatusCell.h"
#import "BaseStatusCellFrame.h"
#import "IconView.h"
#import "ImageItemView.h"
#import "ImageListView.h"
#import "Status.h"
#import "User.h"

@interface BaseStatusCell()
{
    IconView *_icon; //头像
    UILabel *_screenName; //昵称
    UIImageView *_mbIcon; //会员图标
    UILabel *_time; //时间
    UILabel *_source; //来源
    UILabel *_text; //内容
    ImageListView *_image; //配图
    
    UILabel *_retweetedScreenName; //被转发微博作者的昵称
    UILabel *_retweetedText; // 被转发微博的内容
    ImageListView *_retweetedImage; //被转发微博的配图
}
@end

@implementation BaseStatusCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加微博本身所有子控件
        [self addAllSubViews];
        //添加被转发微博的子控件
        [self addReweetedViews];
        //设置背景
        [self setBg];
    }
    return self;
}

#pragma mark 设置背景
-(void)setBg
{
    //默认背景
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage resizedImage:@"common_card_background"]];
    //长按背景
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage resizedImage:@"common_card_background_highlighted"]];
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = kTableBorderWidth;
    frame.origin.y += kTableBorderWidth;
    frame.size.width -= kTableBorderWidth * 2;
    frame.size.height -= kCellMargin;
    
    [super setFrame:frame];
}

#pragma mark 添加微博本身所有子控件
-(void)addAllSubViews
{
    //头像
    _icon = [[IconView alloc] init];
    [self.contentView addSubview:_icon];
    
    //昵称
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;  //17号字体
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    //会员图标
    _mbIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership.png"]];
    [self.contentView addSubview:_mbIcon];
    
    //时间
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;  //13号字体
    _time.textColor = kColor(246, 165, 68);
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    //来源
    _source = [[UILabel alloc] init];
    _source.font = kSourceFont; //13号字体
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];
    
    //内容
    _text = [[UILabel alloc] init];
    _text.font = kTextFont; //15号字体
    _text.numberOfLines = 0; //换行
    _text.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_text];
    
    //配图
    _image = [[ImageListView alloc] init];
    [self.contentView addSubview:_image];
}

#pragma mark - 添加被转发微博的子控件
-(void)addReweetedViews
{
    //被转发微博的父控件
    _retweeted = [[UIImageView alloc] init];
    [_retweeted setImage:[UIImage resizedImage:@"timeline_retweet_background" xPos:0.9 yPos:0.5]];
    _retweeted.userInteractionEnabled = YES;
    [self.contentView addSubview:_retweeted];
    
    //被转发微博作者的昵称
    _retweetedScreenName = [[UILabel alloc] init];
    _retweetedScreenName.font = kRetweetedScreenNameFont; //16号字体
    _retweetedScreenName.textColor = kRetweetedScreenNameColor;
    _retweetedScreenName.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedScreenName];
    
    // 被转发微博的内容
    _retweetedText = [[UILabel alloc] init];
    _retweetedText.numberOfLines = 0;
    _retweetedText.font = kRetweetedTextFont;
    _retweetedText.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedText];
    
    //被转发微博的配图
    _retweetedImage = [[ImageListView alloc] init];
    [_retweeted addSubview:_retweetedImage];
}


-(void)setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    Status *status =cellFrame.status;
    
    //0.底部的操作条
    //_statusDock.status = status;
    //1. 头像
    _icon.frame = cellFrame.iconFrame;
    [_icon setUser:status.user type:kIconTypeSmall];
    
    //2 .昵称
    _screenName.frame = cellFrame.screenNameFrame;
    _screenName.text = status.user.screenName;
    
    //会员图标
    if (status.user.mbtype == kMBTypeNone) {
        _mbIcon.hidden = YES;
        _screenName.textColor = kScreenNameColor;
    } else {
        _mbIcon.hidden = NO;
        _mbIcon.frame =cellFrame.mbIconFrame;
        _screenName.textColor = kMBScreenNameColor;
    }
    
    //3. 时间
    _time.text = status.createdat;
    CGFloat _timeX = cellFrame.screenNameFrame.origin.x;
    CGFloat _timeY = CGRectGetMaxY(cellFrame.screenNameFrame) + kCellBorderWidth;
    CGSize _timeSize = [_time.text sizeWithFont:kTimeFont];
    _time.frame = (CGRect){_timeX,_timeY,_timeSize};
    
    
    //4. 来源
    _source.text= status.source;
    CGFloat _sourceX = CGRectGetMaxX(_time.frame) +kCellBorderWidth;
    CGFloat _sourceY = _timeY;
    CGSize _sourceSize = [_source.text sizeWithFont:kTextFont];
    _source.frame = (CGRect){_sourceX,_sourceY,_sourceSize};
    
    
    //5. 内容
    _text.frame = cellFrame.textFrame;
    _text.text =status.text;
    
    //6. 配图
    if (status.picUrls.count) {
        _image.hidden = NO;
        _image.frame = cellFrame.imageFrame;
        //        NSString *imageStr = status.picUrls[0][@"thumbnail_pic"];
        //        NSURL *imageUrl = [NSURL URLWithString:imageStr];
        //        [_image sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
        [_image setImageUrls:status.picUrls];
    } else {
        _image.hidden = YES;
    }
    
    // 7.被转发微博
    if (status.retweetedStatus) {
        _retweeted.hidden = NO;
        //被转发微博的父控件
        _retweeted.frame = cellFrame.RetweetedFrame;
        
        
        //8.被转发微博作者的昵称
        _retweetedScreenName.frame =cellFrame.RetweetedScreenNameFrame;
        _retweetedScreenName.text = [NSString stringWithFormat:@"@%@",status.retweetedStatus.user.screenName];
        
        //9.被转发微博的内容
        _retweetedText.frame = cellFrame.RetweetedTextFrame;
        _retweetedText.text = status.retweetedStatus.text;
        
        //10.被转发微博的配图
        if (status.retweetedStatus.picUrls.count) {
            _retweetedImage.hidden = NO;
            _retweetedImage.frame = cellFrame.RetweetedImageFrame;
            //            NSString *retweetImageStr = status.retweetedStatus.picUrls[0][@"thumbnail_pic"];
            //            NSURL *imageUrl = [NSURL URLWithString:retweetImageStr];
            //            [_retweetedImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
            [_retweetedImage setImageUrls:status.retweetedStatus.picUrls];
        } else {
            _retweetedImage.hidden = YES;
        }
    } else {
        _retweeted.hidden = YES;
    }
}



@end
