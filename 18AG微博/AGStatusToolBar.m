//
//  AGStatusToolBar.m
//  18AG微博
//
//  Created by again on 16/8/8.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGStatusToolBar.h"
#import "AGStatus.h"

@interface AGStatusToolBar()
//转发按钮
@property (weak,nonatomic) UIButton *reweetBtn;
//评论按钮
@property (weak,nonatomic) UIButton *commentBtn;
//点赞按钮
@property (weak,nonatomic) UIButton *attitudeBtn;
//分割线
@property (strong,nonatomic) NSMutableArray *dividers;
@property (strong,nonatomic) NSMutableArray *btns;


@end
@implementation AGStatusToolBar

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        //设置图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background_os7"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted_os7"];
      
        //添加按钮
        self.reweetBtn = [self setBtnTitle:@"转发" image:@"timeline_icon_retweet_os7" bgImage:@"timeline_card_leftbottom_highlighted_os7"];
        self.commentBtn = [self setBtnTitle:@"评论" image:@"timeline_icon_comment_os7" bgImage:@"timeline_card_middlebottom_highlighted_os7"];
        self.attitudeBtn = [self setBtnTitle:@"赞" image:@"timeline_icon_unlike_os7" bgImage:@"timeline_card_rightbottom_highlighted_os7"];
        
        [self setupDivider];
        [self setupDivider];
        
    }
    return self;
}

- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line_os7"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

- (UIButton *)setBtnTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted = NO;
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat BtnY = 0;
    CGFloat BtnH = self.frame.size.height;
    NSInteger btnCount = self.btns.count;
    NSInteger dividerCount = self.dividers.count;
    CGFloat dividerW = 2;
    CGFloat BtnW = (self.frame.size.width - dividerCount * dividerW) / btnCount;
    
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
       CGFloat BtnX = i * (BtnW + dividerW);
        btn.frame = CGRectMake(BtnX, BtnY, BtnW, BtnH);
    }
    
    CGFloat dividerH = BtnH;
    CGFloat dividerY = 0;
    
    for (int j = 0; j<dividerCount; j++) {
        UIImageView *divider = self.dividers[j];
        UIButton *btn = self.btns[j];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}

- (void)setStatus:(AGStatus *)status
{
    _status = status;
    
    [self setupBtn:self.reweetBtn originalTitle:@"转发" count:status.reposts_count];
    
    [self setupBtn:self.commentBtn originalTitle:@"评论" count:status.comments_count];
    
    [self setupBtn:self.attitudeBtn originalTitle:@"赞" count:status.attitudes_count];
    
    
}

- (void)setupBtn:(UIButton *)btn originalTitle:(NSString *)originalTitle count:(NSInteger)count
{
    if (count) {
        NSString *title = nil;
        if (count<10000) {
            title = [NSString stringWithFormat:@"%zd", count];
        } else {
            double countDouble = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", countDouble];
            
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    } else{
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}
@end
