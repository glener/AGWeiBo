//
//  AGPhotoView.m
//  18AG微博
//
//  Created by again on 16/8/8.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGPhotoView.h"
#import "AGPhoto.h"
#import "UIImageView+WebCache.h"

@interface AGPhotoView()
@property (weak,nonatomic) UIImageView *gifView;
@end
@implementation AGPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(AGPhoto *)photo
{
    _photo = photo;
    //控制gifview的可见性
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}

@end
