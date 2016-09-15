//
//  AGBadgeButton.m
//  18AG微博
//
//  Created by again on 16/8/5.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGBadgeButton.h"

@implementation AGBadgeButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = [badgeValue copy];
    if (badgeValue && [badgeValue intValue]) {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        CGRect frame = self.frame;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}

@end
