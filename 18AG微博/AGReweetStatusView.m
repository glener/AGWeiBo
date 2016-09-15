//
//  AGReweetStatusView.m
//  18AG微博
//
//  Created by again on 16/8/8.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGReweetStatusView.h"
#import "AGStatusFrame.h"
#import "AGStatus.h"
#import "AGUser.h"
#import "UIImageView+WebCache.h"
#import "AGPhoto.h"
#import "AGPhotosView.h"

@interface AGReweetStatusView()

/** 被转发微博的作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文/内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) AGPhotosView *retweetPhotoView;

@end

@implementation AGReweetStatusView

#pragma mark 设置视图
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        /**设置图片*/
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background_os7" left:0.9 top:0.5];
        
        /**被转发微博作者的昵称*/
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = AGRetweetStatusNameFont;
        retweetNameLabel.textColor = AGColor(67, 107, 163);
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        /**被转发微博正文*/
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.font = AGRetweetStatusContentFont;
        retweetContentLabel.textColor = AGColor(90, 90, 90);
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        retweetContentLabel.numberOfLines = 0;
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        /**被转发微博的配图*/
        AGPhotosView *retweetPhotoView = [[AGPhotosView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
    }
    return self;
}

#pragma mark 设置数据
- (void)setStatusFrame:(AGStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    AGStatus *retweetStatus = statusFrame.status.retweeted_status;
    AGUser *user = retweetStatus.user;
        
        //昵称
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        //正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        //配图
        if (retweetStatus.pic_urls.count) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
            self.retweetPhotoView.photos = retweetStatus.pic_urls;
        } else {
            self.retweetPhotoView.hidden = YES;
        }
}
@end
