//
//  ImageListView.m
//  weibo
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#define kCount 9

#define kOneW 120
#define kOneH 120

#define kMutiW 80
#define kMutiH 80

#define kMargin 10

#import "ImageListView.h"
#import "ImageItemView.h"

@interface ImageListView()

@end

@implementation ImageListView


-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i<kCount; i++) {
            ImageItemView *imageView = [[ImageItemView alloc] init];
            [self addSubview:imageView];
        }
    }
    return self;
}

-(void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
    
    int count = imageUrls.count;
    
    for (int i = 0; i<kCount; i++) {
        //1.取出对应位置的子控件
        ImageItemView *child = self.subviews[i];
        
        //2.不要显示图片
        if (i >= count) {
            child.hidden = YES;
            break;
        }
        
        // 需要显示图片
        child.hidden = NO;
        
        // 3.设置显示图片
        child.url = imageUrls[i][@"thumbnail_pic"];
        //NSURL *url = [NSURL URLWithString:imageUrls[i][@"thumbnail_pic"]];
//        [child sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Icon.png"] options: SDWebImageLowPriority | SDWebImageRetryFailed];
        
        // 4.设置frame
        if (count == 1) {//1张
            child.contentMode = UIViewContentModeScaleAspectFit;
            child.frame = CGRectMake(0, 0, kOneW, kOneH);
            break;
        }
        
        //超出边界的减掉
        child.clipsToBounds = YES;
        child.contentMode = UIViewContentModeScaleAspectFill;
        
        
        int temp = (count == 4) ? 2 : 3;
        CGFloat row = i/temp; //行号
        CGFloat column = i%temp; //列号
        CGFloat x = (kMutiW + kMargin) * column;
        CGFloat y = (kMutiH + kMargin) * row;
        child.frame = CGRectMake(x, y, kMutiW, kMutiH);
    }
}

+(CGSize)imageListSizeWithCount:(int)count
{
   //1.只有1张图片
    if (count == 1) {
        return CGSizeMake(kOneW, kOneH);
    }
    
    //2.至少2张图片
    CGFloat countRow = (count == 4) ? 2 :3;
    //总行数
    int rows =(count + countRow -1) /countRow;
    //总列数
    int columns = (count >= 3) ? 3 :2;
    
    CGFloat width = columns * kMutiW + (columns - 1) * kMargin;
    CGFloat height = rows * kMutiH + (rows - 1) * kMargin;
    return CGSizeMake(width, height);
}

@end
