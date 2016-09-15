//
//  AGComposePhotoView.m
//  again微博
//
//  Created by again on 16/8/10.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGComposePhotoView.h"

@implementation AGComposePhotoView

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    int maxColumns = 4;
    CGFloat imageViewW = 70;
    CGFloat imageViewH = imageViewW;
    CGFloat margin = (self.frame.size.width - maxColumns * imageViewW) / (maxColumns + 1);
    for (int i = 0; i<count; i++) {
        UIImageView *imageView = self.subviews[i];
        CGFloat imageViewX = margin + (i % maxColumns) * (imageViewW + margin);
        CGFloat imageViewY = (i / maxColumns) * (imageViewH + margin);
        
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
}

- (NSArray *)totalImage
{
    NSMutableArray *images = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [images addObject:imageView.image];
    }
    return images;
}
@end
