//
//  AGTabBarViewController.m
//  18AG微博
//
//  Created by again on 16/8/3.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGTabBarViewController.h"
#import "AGHomeViewController.h"
#import "AGMessageViewController.h"
#import "AGDiscoverViewController.h"
#import "AGMeViewController.h"
#import "AGTabBar.h"
#import "AGNavigationController.h"
#import "AGComposeViewController.h"
#import "AGUserUnreadCountParam.h"
#import "AGAccountTool.h"
#import "AGAccount.h"
#import "AGUserTool.h"

@interface AGTabBarViewController ()<AGTabBarDelegate>
@property (weak,nonatomic) AGTabBar *customTabBar;
@property (strong,nonatomic) AGHomeViewController *home;
@property (strong,nonatomic) AGMessageViewController *message;
@property (strong,nonatomic) AGDiscoverViewController *discover;
@property (strong,nonatomic) AGMeViewController *me;
@end

@implementation AGTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabbar];
    [self setupChildViewController];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}
//定时检查未读数
- (void)checkUnreadCount
{
    AGUserUnreadCountParam *param = [AGUserUnreadCountParam param];
    param.uid = @([AGAccountTool account].uid);
    [AGUserTool userUnreadCountWithParam:param success:^(AGUserUnreadCountResult *result) {
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        //设置图标右上角数字
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.count;
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

//监听加号按钮点击

- (void)tabBarDidClickplusButton:(AGTabBar *)tabBar
{
    AGComposeViewController *compose = [[AGComposeViewController alloc] init];
    AGNavigationController *nav = [[AGNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}
//初始化tabbar
- (void)setupTabbar{
    AGTabBar *customTabbar = [[AGTabBar alloc] init];
    customTabbar.frame = self.tabBar.bounds;
    customTabbar.delegate = self;
    [self.tabBar addSubview:customTabbar];
    self.customTabBar = customTabbar;
    
}

//初始化所有子控制器
- (void)setupChildViewController{
    
    AGHomeViewController *home = [[AGHomeViewController alloc] init];
    self.home = home;
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home_os7" selectImageName:@"tabbar_home_selected_os7"];
    
    AGMessageViewController *message = [[AGMessageViewController alloc] init];
    self.message = message;
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center_os7" selectImageName:@"tabbar_message_center_selected_os7"];
    
    AGDiscoverViewController *discover = [[AGDiscoverViewController alloc] init];
    self.discover = discover;
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover_os7" selectImageName:@"tabbar_discover_selected_os7"];
    
    AGMeViewController *me = [[AGMeViewController alloc] init];
    self.me = me;
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile_os7" selectImageName:@"tabbar_profile_selected_os7"];
    
}

- (void)setupChildViewController:(UIViewController *)Vc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName{
    Vc.title = title;
    Vc.tabBarItem.image = [UIImage imageNamed:imageName];
    Vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    AGNavigationController *nav = [[AGNavigationController alloc] initWithRootViewController:Vc];
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithItem:Vc.tabBarItem];
}

- (void)tabBar:(AGTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to{
    self.selectedIndex = to;
//    NSLog(@"%d%d", fr)
    if (from == to && to == 0) {
        [self.home refresh];
    }
}
@end
