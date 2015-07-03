//
//  NSString+Extensions.m
//  weibo
//
//  Created by qianfeng on 15/7/2.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

-(NSString *)fileAppend:(NSString *)append
{
    //1.1. 获得文件拓展名
    NSString *ext = [self pathExtension];
    
    //1.2. 删除最后面的扩展名
    NSString *imgName = [self stringByDeletingPathExtension];
    
    //1.3. 拼接-
    imgName = [imgName stringByAppendingString:append];
    
    //1.4. 拼接扩展名
    return [imgName stringByAppendingPathExtension:ext];
}

@end
