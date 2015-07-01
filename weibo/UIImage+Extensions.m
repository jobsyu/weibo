//
//  UIImage+Extensions.m
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "UIImage+Extensions.h"

@implementation UIImage (Extensions)

+(UIImage *)fullscreenImage:(NSString *)imgName
{
    
    return [self imageNamed:imgName];
}

+(UIImage *)resizedImage:(NSString *)imgName
{
    UIImage *image = [UIImage imageNamed:imgName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height *0.5];
}
@end
