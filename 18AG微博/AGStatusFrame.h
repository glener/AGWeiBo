//
//  AGStatusFrame.h
//  18AG微博
//
//  Created by again on 15/11/15.
//  Copyright © 2015年 again. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class AGStatus;

@interface AGStatusFrame : NSObject
/**内部有微博模型，方便计算frame*/
@property (nonatomic, strong) AGStatus *status;

/** 顶部的view（父控件） */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 昵称*/
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 来源*/
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photoViewF;
/** 正文/内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;

/** 被转发微博的view（父控件） */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/** 被转发微博的作者的昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/** 被转发微博的正文/内容 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/** 被转发微博的配图 */
@property (nonatomic, assign, readonly) CGRect retweetPhotoViewF;

/** 微博的工具条 */
@property (nonatomic, assign, readonly) CGRect statusToolbarF;

/** 微博的行高 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end

