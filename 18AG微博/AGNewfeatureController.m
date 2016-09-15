//
//  AGNewfeatureController.m
//  18AG微博
//
//  Created by again on 16/8/5.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGNewfeatureController.h"
#import "AGTabBarViewController.h"

@interface AGNewfeatureController ()<UIScrollViewDelegate>
@property (weak,nonatomic) UIPageControl *pageControl;
@end

@implementation AGNewfeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self scrollView];
    [self setupPageController];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}

- (void)setupPageController{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 3;
    CGFloat centerX = self.view.frame.size.width *0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1.0];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0];
}

- (void)scrollView{
    
    UIScrollView *src = [[UIScrollView alloc] init];
    src.frame = self.view.bounds;
    src.delegate = self;
    [self.view addSubview:src];
    CGFloat srcW = src.frame.size.width;
    CGFloat srcH = src.frame.size.height;
    
    for (int index = 0; index<3; index++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d-568h", index + 1]]];
        
        imageView.frame = CGRectMake(srcW * index, 0, srcW, srcH);
        
        [src addSubview:imageView];
        if (index == 2) {
            [self setupLastImageView:imageView];
        }
    }
    src.contentSize = CGSizeMake(srcW * 3, 0);
    src.showsHorizontalScrollIndicator = NO;
    src.pagingEnabled = YES;
    src.bounces = NO;
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    //设置frame
    CGFloat centerX = imageView.frame.size.width * .5;
    CGFloat centerY = imageView.frame.size.height * .6;
    button.center = CGPointMake(centerX, centerY);
    button.bounds = (CGRect){CGPointZero, button.currentBackgroundImage.size};
//设置文字
    [button setTitle:@"开始微博" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];
    
    UIButton *checkBox = [[UIButton alloc] init];
    checkBox.selected = YES;
    [checkBox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    //设置checkBox 的frame
    checkBox.bounds = CGRectMake(0, 0, 200, 50);
    CGFloat checkBoxCenterX = centerX;
    CGFloat checkBoxCenterY = imageView.frame.size.height * .5;
    checkBox.center = CGPointMake(checkBoxCenterX, checkBoxCenterY);
    
    [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkBox.titleLabel.font = [UIFont systemFontOfSize:15];
    checkBox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [checkBox addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkBox];
}

- (void)checkBoxClick:(UIButton *)checkBox{
    checkBox.selected = !checkBox.isSelected;
}

- (void)start{
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[AGTabBarViewController alloc] init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
