//
//  AGPhotosView.m
//  18AG微博
//
//  Created by again on 16/8/8.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGPhotosView.h"
#import "AGPhoto.h"
#import "AGPhotoView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"


@implementation AGPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i < 9; i++) {
            AGPhotoView *photoView = [[AGPhotoView alloc] init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)photoTap:(UITapGestureRecognizer *)recognizer
{
    NSInteger count = self.photos.count;
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        mjphoto.srcImageView = self.subviews[i];
        
        AGPhoto *agphoto = self.photos[i];
        NSString *photoUrl = [agphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl];
        
        [myphotos addObject:mjphoto];
    }
    
    //显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag;
    browser.photos = myphotos;
    [browser show];
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    for (int i = 0; i<self.subviews.count; i++) {
        //去除i位置对应的ImageView
        AGPhotoView *photoView = self.subviews[i];
        if (i < photos.count) {
            photoView.hidden = NO;
            photoView.photo = photos[i];
            
            int maxColums = (photos.count == 4)?2:3;
            int col = i %maxColums;
            int row = i /maxColums;
            CGFloat photoX = col * (AGPhotoW + AGPhotoMargin);
            CGFloat photoY = row * (AGPhotoH + AGPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, AGPhotoW, AGPhotoH);
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        } else {
            photoView.hidden = YES;
        }
    }
}

+ (CGSize)photosViewSizeWithPhotosCount:(NSInteger)count
{
    NSInteger maxColumns = (count == 4) ? 2:3;
    NSInteger rows = (count + maxColumns - 1)/maxColumns;
    CGFloat photosH = rows * AGPhotoH + (rows - 1) * AGPhotoMargin;
    NSInteger cols = (count >= maxColumns) ? maxColumns : count;
    CGFloat photosW = cols * AGPhotoW + (cols - 1) * AGPhotoMargin;
    return CGSizeMake(photosW, photosH);
}
@end

