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
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

+(UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}
@end
