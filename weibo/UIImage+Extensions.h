//
//  UIImage+Extensions.h
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)

#pragma mark 加载全屏的图片
+(UIImage *)fullscreenImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+(UIImage *)resizedImage:(NSString *)imgName;

@end
