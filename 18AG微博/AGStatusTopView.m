//
//  AGStatusTopView.m
//  18AG微博
//
//  Created by again on 16/8/8.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGStatusTopView.h"
#import "AGReweetStatusView.h"
#import "AGStatus.h"
#import "AGUser.h"
#import "AGStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "AGPhoto.h"
#import "AGPhotosView.h"


@interface AGStatusTopView ()

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 昵称*/
@property (nonatomic, weak) UILabel *nameLabel;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) AGPhotosView *photosView;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源*/
@property (nonatomic, weak) UILabel *sourceLabel;
@property (weak,nonatomic) UILabel *laiziLabel;
/** 正文/内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/**被转发的微博视图*/
@property (weak,nonatomic) AGReweetStatusView *reweetView;

@end
@implementation AGStatusTopView

#pragma mark 设置视图
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background_os7"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted_os7"];
        
        /** 头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /** 3.会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /** 4.配图 */
        AGPhotosView *photoView = [[AGPhotosView alloc] init];
        [self addSubview:photoView];
        self.photosView = photoView;
        
        /** 5.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = AGStatusNameFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 6.时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = AGColor(240, 140, 19);
        timeLabel.font = AGStatusTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 7.来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.backgroundColor = [UIColor clearColor];
        sourceLabel.font = AGStatusSourceFont;
        sourceLabel.textColor = AGColor(39, 39, 39);
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 8.正文\内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = AGColor(39, 39, 39);
        contentLabel.font = AGStatusContentFont;
        contentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        //被转发的微博的视图
        AGReweetStatusView *retweet = [[AGReweetStatusView alloc] init];
        [self addSubview:retweet];
        self.reweetView = retweet;
    }
    return self;
}

#pragma mark 设置数据
- (void)setStatusFrame:(AGStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    AGStatus *status = statusFrame.status;
    AGUser *user = status.user;
    
    //头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    //昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    //VIP
    if (user.mbtype > 2) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewF;
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    //时间
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + AGStatusCellBorder * 0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:AGStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    //    self.timeLabel.frame = self.statusFrame.timeLabelF;

    //来源
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + AGStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:AGStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    //    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    
    //正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    //配图
    if (status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = self.statusFrame.photoViewF;
        self.photosView.photos = status.pic_urls;
    } else {
        self.photosView.hidden = YES;
    }
    
    //被转发的微博
    AGStatus *retweetStatus = status.retweeted_status;
    if (retweetStatus) {
        self.reweetView.hidden = NO;
        self.reweetView.frame = self.statusFrame.retweetViewF;
        self.reweetView.statusFrame = self.statusFrame;
    } else {
        self.reweetView.hidden = YES;
    }
}
@end
