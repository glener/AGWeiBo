//
//  AGTabBarButton.m
//  18AG微博
//
//  Created by again on 16/8/3.
//  Copyright © 2016年 again. All rights reserved.
//
// 图标的比例
#define AGTabBarButtonImageRatio 0.6

// 按钮的默认文字颜色
#define  AGTabBarButtonTitleColor [UIColor blackColor]
// 按钮的选中文字颜色
#define  AGTabBarButtonTitleSelectedColor AGColor(234.0, 103.0, 7.0)

#import "AGTabBarButton.h"
#import "AGBadgeButton.h"

@interface AGTabBarButton()
@property (weak,nonatomic) AGBadgeButton *badgeBtn;

@end
@implementation AGTabBarButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [self setTitleColor:AGTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:234/255.0 green:103/255.0 blue:7/255.0 alpha:1.0] forState:UIControlStateSelected];
    }
    
    AGBadgeButton *badgeBtn = [[AGBadgeButton alloc] init];
    badgeBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:badgeBtn];
    self.badgeBtn = badgeBtn;
    
    return self;
}

//设置item
- (void)setItem:(UITabBarItem *)item{
    _item = item;
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)dealloc{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    self.badgeBtn.badgeValue = self.item.badgeValue;
    
    CGFloat badgeX = self.frame.size.width - self.badgeBtn.frame.size.width - 10;
    CGFloat badgeY = 5;
    CGRect badgeF = self.badgeBtn.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    

    self.badgeBtn.frame = badgeF;
}

//内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * AGTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

//内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * AGTabBarButtonImageRatio;
    CGFloat titleH = contentRect.size.height - titleY;
    CGFloat titleW = contentRect.size.width;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted{
}
@end
