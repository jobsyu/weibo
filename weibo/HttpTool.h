//
//  HttpTool.h
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpSuccessBlock)(id JSON);
typedef void (^HttpFailureBlock)(NSError *error);

@interface HttpTool : NSObject
+(void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
+(void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

+(void)downloadImage:(NSString *)url place:(UIImage *)place imageView:(UIImageView *)imageView;
@end
