//
//  ImageListView.h
//  weibo
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageListView : UIView

@property (nonatomic,strong) NSArray *imageUrls;

+(CGSize)imageListSizeWithCount:(int)count;

@end
