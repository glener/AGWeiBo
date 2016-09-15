
//
//  AGStatusFrame.m
//  18AG微博
//
//  Created by again on 15/11/15.
//  Copyright © 2015年 again. All rights reserved.
//
#import "AGStatusFrame.h"
#import "AGStatus.h"
#import "AGUser.h"
#import "AGPhotosView.h"


@implementation AGStatusFrame

//- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
//{
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//}

- (void)setStatus:(AGStatus *)status
{
    _status = status;
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * AGStatusTableBoder;
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 0;
    
    // 头像
    CGFloat iconViewX = AGStatusCellBorder;
    CGFloat iconViewY = AGStatusCellBorder;
    CGFloat iconViewW = 30;
    CGFloat iconViewH = 30;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + AGStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithAttributes:@{NSFontAttributeName:AGStatusNameFont}];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 会员图标
    if (status.user.mbtype > 2) {
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + AGStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    // 时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + AGStatusCellBorder * 0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:AGStatusTimeFont];
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + AGStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithAttributes:@{NSFontAttributeName:AGStatusTimeFont}];
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    //正文
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + AGStatusCellBorder;
    CGFloat contentLabelMaxW = topViewW - 2 * AGStatusCellBorder;
    
    CGSize contentLabelSize = [status.text boundingRectWithSize:CGSizeMake(contentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AGStatusContentFont} context:nil].size;
//    CGSize contentLabelSize = [status.text sizeWithFont:AGStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    //配图
    if (status.pic_urls.count) {
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + AGStatusCellBorder;
//        CGFloat photoViewWH = 70;
        CGSize photosViewSize = [AGPhotosView photosViewSizeWithPhotosCount:status.pic_urls.count];
        _photoViewF = CGRectMake(photoViewX, photoViewY, photosViewSize.width, photosViewSize.height);
    }
    
    //有转发微博（被转发微博的frame）
    if (status.retweeted_status) {
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + AGStatusCellBorder;
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewH = 0;
        
        //被转发微博的昵称
        CGFloat reweetViewNameLabelX = AGStatusCellBorder;
        CGFloat reweetViewNameLabelY = AGStatusCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        CGSize reweetViewNameLabelSize = [name sizeWithAttributes:@{NSFontAttributeName:AGRetweetStatusNameFont}];
        _retweetNameLabelF = (CGRect){{reweetViewNameLabelX, reweetViewNameLabelY}, reweetViewNameLabelSize};

        //被转发微博的正文
        CGFloat reweetViewContentLabelX = reweetViewNameLabelX;
        CGFloat reweetViewContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + AGStatusCellBorder;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * AGStatusCellBorder;
        
        CGSize retweetContentLabelSize = [status.retweeted_status.text boundingRectWithSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AGRetweetStatusContentFont} context:nil].size;
    #warning 待计算
//        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:AGRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{reweetViewContentLabelX, reweetViewContentLabelY}, retweetContentLabelSize};
        
        // 被转发微博的配图
        if (status.retweeted_status.pic_urls.count) {
            CGFloat retweetPhotoViewX = reweetViewContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + AGStatusCellBorder;
//            CGFloat retweetPhotoViewWH = 70;
            CGSize retweetPhotoViewSize = [AGPhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count];
            _retweetPhotoViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewSize.width, retweetPhotoViewSize.height);
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);
            
        } else {
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += AGStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        //有转发微博时topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
    } else {//没有转发微博（原创微博）
        if (status.pic_urls.count) {
            topViewH = CGRectGetMaxY(_photoViewF);
        } else {
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += AGStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 工具条
    CGFloat statusToolBarX = topViewX;
    CGFloat statusToolBarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolBarW = topViewW;
    CGFloat statusToolBarH = 35;
    _statusToolbarF = CGRectMake(statusToolBarX, statusToolBarY, statusToolBarW, statusToolBarH);
    
    //cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + AGStatusTableBoder;
}
@end
