//
//  AGComposeToolBar.m
//  18AG微博
//
//  Created by again on 16/8/10.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGComposeToolBar.h"

@implementation AGComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background_os7"]];
        
        [self addButtonWithIcon:@"compose_camerabutton_background_os7" highIcon:@"compose_camerabutton_background_highlighted_os7" tag:AGComposeToolBarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture_os7" highIcon:@"compose_toolbar_picture_highlighted_os7" tag:AGComposeToolBarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background_os7" highIcon:@"compose_mentionbutton_background_highlighted_os7" tag:AGComposeToolBarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background_os7" highIcon:@"compose_trendbutton_background_highlighted_os7" tag:AGComposeToolBarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background_os7" highIcon:@"compose_emoticonbutton_background_highlighted_os7" tag:AGComposeToolBarButtonTypeEmotion];
    }
    
    return self;
}

- (void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(int)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
}

- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
    }
}
@end
