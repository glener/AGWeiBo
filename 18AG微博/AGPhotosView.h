//
//  AGPhotosView.h
//  18AG微博
//
//  Created by again on 16/8/8.
//  Copyright © 2016年 again. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGPhotosView : UIView
/**
 *  需要展示的托图片，数组里装的是AGPhoto模型
 */
@property (strong,nonatomic) NSArray *photos;
/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(NSInteger)count;
@end
