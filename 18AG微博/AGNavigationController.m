//
//  AGNavigationController.m
//  18AG微博
//
//  Created by again on 16/8/5.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGNavigationController.h"

@interface AGNavigationController ()

@end

@implementation AGNavigationController

//第一次使用会调用，只调用一次
+ (void)initialize{
    [self setupNavBarTheme];
    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textArrs = [NSMutableDictionary dictionary];
    textArrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textArrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textArrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];;
    [item setTitleTextAttributes:textArrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textArrs forState:UIControlStateHighlighted];
        
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[UITextAttributeTextColor] =  [UIColor lightGrayColor];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    NSMutableDictionary *textArrs = [NSMutableDictionary dictionary];
    textArrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textArrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textArrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [navBar setTitleTextAttributes:textArrs];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController: viewController animated:animated];
}
@end
