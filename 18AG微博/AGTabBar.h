//
//  AGTabBar.h
//  18AG微博
//
//  Created by again on 16/8/3.
//  Copyright © 2016年 again. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AGTabBar;

@protocol AGTabBarDelegate <NSObject>

@optional
- (void)tabBar:(AGTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;
- (void)tabBarDidClickplusButton:(AGTabBar *)tabBar;
@end

@interface AGTabBar : UIView

- (void) addTabBarButtonWithItem:(UITabBarItem *)item;
@property (weak,nonatomic) id<AGTabBarDelegate> delegate;
@end
