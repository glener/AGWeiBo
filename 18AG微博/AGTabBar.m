//
//  AGTabBar.m
//  18AG微博
//
//  Created by again on 16/8/3.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGTabBar.h"
#import "AGTabBarButton.h"

@interface AGTabBar()
@property (weak,nonatomic) AGTabBarButton *selectedButton;
@property (weak,nonatomic) UIButton *plusButton;
@property (strong,nonatomic) NSMutableArray *tabBarButton;
@end

@implementation AGTabBar

- (NSMutableArray *)tabBarButton{
    if (!_tabBarButton) {
        _tabBarButton = [NSMutableArray array];
    }
    return _tabBarButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    // 添加一个加号按钮
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_os7"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"] forState:UIControlStateHighlighted];
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_os7"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateHighlighted];
    plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
    [self addSubview:plusButton];
    self.plusButton = plusButton;
    [self.plusButton addTarget:self action:@selector(plusButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

- (void)plusButtonDidClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickplusButton:)]) {
        [self.delegate tabBarDidClickplusButton:self];
    }
}
//添加按钮到tabbar
- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    AGTabBarButton *btn = [[AGTabBarButton alloc] init];
    [self addSubview:btn];
    [self.tabBarButton addObject:btn];
    
    btn.item = item;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    if (self.tabBarButton.count == 1) {
        [self buttonClick:btn];
    }
}

//显示tabbar
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonH = self.frame.size.height;
    CGFloat W = self.frame.size.width;
    self.plusButton.center = CGPointMake(W * 0.5, buttonH * 0.5);
    
    CGFloat buttonY = 0;
    
    CGFloat buttonW = W/self.subviews.count;
    for (int index = 0; index<self.tabBarButton.count; index++) {
        AGTabBarButton *btn = self.tabBarButton[index];
        CGFloat buttonX = index * buttonW;
        if (index>1) {
            buttonX += buttonW;
        }
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        btn.tag = index;
    }
}

//选中标签的代理方法
- (void)buttonClick:(AGTabBarButton *)button{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

@end


