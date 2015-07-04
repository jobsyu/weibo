//
//  ImageItemView.m
//  weibo
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "ImageItemView.h"
#import "HttpTool.h"

@interface ImageItemView()
{
    UIImageView *_gifView;
}
@end

@implementation ImageItemView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}

-(void)setUrl:(NSString *)url
{
    _url = url;
    [HttpTool downloadImage:url place:[UIImage imageNamed:@"timeline_image_loading"] imageView:self];
    
    _gifView.hidden = ![url.lowercaseString hasSuffix:@"gif"];
}

-(void)setFrame:(CGRect)frame
{
    //1.设置gifView的frame
    CGRect gifFrame = _gifView.frame;
    gifFrame.origin.x = frame.size.width - gifFrame.size.width;
    gifFrame.origin.y = frame.size.height - gifFrame.size.height;
    _gifView.frame = gifFrame;
    
    [super setFrame:frame];
}

@end
