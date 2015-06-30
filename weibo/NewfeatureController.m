//
//  NewfeatureController.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "NewfeatureController.h"
#import "MainController.h"

#pragma 几张广告图
#define kCount 4

@interface NewfeatureController() <UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView  *scrollView;
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation NewfeatureController

#pragma mark 自定义view
-(void)loadView
{
    UIImageView *backImage =[[UIImageView alloc] init];
    backImage.image = [UIImage imageNamed:@"new_feature_background"];
    
    backImage.frame = [UIScreen mainScreen].applicationFrame;
    backImage.userInteractionEnabled = YES;
    self.view = backImage;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加滚动条
    [self addScrollView];
    //添加滚动图片
    [self addScrollImages];
    //添加分页控件
    [self addPageControl];
}

#pragma mark - UI界面初始化
//添加滚动条控件(UIScrollView)
-(void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    //scrollView.alwaysBounceHorizontal = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    //scrollView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    scrollView.frame = self.view.bounds;
    CGSize size = scrollView.frame.size;
    scrollView.contentSize = CGSizeMake(size.width * kCount, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}

//添加滚动条图片
-(void)addScrollImages
{
    CGSize size = _scrollView.frame.size;
    for (int i= 0; i<kCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *imageStr = [NSString stringWithFormat:@"new_feature_%i",i+1];
        imageView.image = [UIImage imageNamed:imageStr];
        CGFloat x = size.width * i;
        CGFloat y = 0;
        imageView.frame = CGRectMake(x, y, size.width, size.height);
        [_scrollView addSubview:imageView];
        
        if (i == kCount - 1) {
            UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *imageStart = [UIImage imageNamed:@"new_feature_finish_button"];
            [start setImage:imageStart forState:UIControlStateNormal];
            [start setImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
            start.center = CGPointMake(size.width * 0.5, size.height * 0.8);
            start.bounds = (CGRect){CGPointZero,imageStart.size};
            [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:start];
            
            UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *imageShare = [UIImage imageNamed:@"new_feature_share_false"];
            [share setImage:imageShare forState:UIControlStateNormal];
            [share setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
            share.center = CGPointMake(size.width * 0.5, size.height *0.9);
            share.bounds = (CGRect){CGPointZero,imageShare.size};
            [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            //[start addTarget:self action:<#(SEL)#> forControlEvents:<#(UIControlEvents)#>]
            //[self.view addSubview:share];
            
            //设置选中
            share.selected = YES;
            
            //按钮在高亮的时候不需要变灰色
            share.adjustsImageWhenHighlighted = NO;
            
            [imageView addSubview:share];
            
            imageView.userInteractionEnabled = YES;
        }
    }
}

-(void)start
{
    WXLog(@"开始微博");
    
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[MainController alloc] init];
}

//点击分享
-(void)share:(UIButton *)btn
{
    btn.selected = !btn.selected;

}
//添加分页控件UIPageControl
-(void)addPageControl
{
    CGSize size = self.view.bounds.size;
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = kCount;
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
    pageControl.bounds = CGRectMake(0, 0, 150, 0);
    pageControl.center = CGPointMake(size.width * 0.5, size.height * 0.95);
    [self.view addSubview:pageControl];
    _pageControl = pageControl;
}

#pragma mark －UIScrollViewDelegate 代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float page = scrollView.contentOffset.x / scrollView.size.width;
    _pageControl.currentPage = (int)(page +0.5);
}

#pragma mark -销毁
-(void)dealloc
{
    WXLog(@"...");
}
@end
