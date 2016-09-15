//
//  AGTextView.m
//  18AG微博
//
//  Created by again on 16/8/9.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGTextView.h"

@interface AGTextView ()

@property (strong,nonatomic) UILabel *placehoderLabel;

@end
@implementation AGTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placehoderLabel = [[UILabel alloc] init];
        placehoderLabel.textColor = [UIColor lightGrayColor];
        placehoderLabel.hidden = YES;
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.backgroundColor = [UIColor clearColor];
        placehoderLabel.font = self.font;
        [self insertSubview:placehoderLabel atIndex:0];
        self.placehoderLabel = placehoderLabel;
        [AGNOtificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)setPlaceHoder:(NSString *)placeHoder
{
    _placeHoder = [placeHoder copy];
    self.placehoderLabel.text = placeHoder;
    if (placeHoder.length) {
        self.placehoderLabel.hidden = NO;
        CGFloat placehoderX = 5;
        CGFloat placehoderY = 7;
        CGFloat maxW = self.frame.size.width - 2 * placehoderX;
        CGFloat maxH = self.frame.size.height - 2 * placehoderY;
        CGSize placehoderSize = [placeHoder boundingRectWithSize:CGSizeMake(maxW, maxH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
        self.placehoderLabel.frame = CGRectMake(placehoderX, placehoderY, placehoderSize.width, placehoderSize.height);
    } else {
        self.placehoderLabel.hidden = YES;
    }
}

- (void)setPlaceHoderColor:(UIColor *)placeHoderColor
{
    _placeHoderColor = placeHoderColor;
    self.placehoderLabel.textColor = placeHoderColor;
}

- (void)textDidChange
{
    self.placehoderLabel.hidden = (self.text.length != 0);
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placehoderLabel.font = font;
    self.placeHoder = self.placeHoder;
}

- (void)dealloc{
    [AGNOtificationCenter removeObserver:self];
}
@end
