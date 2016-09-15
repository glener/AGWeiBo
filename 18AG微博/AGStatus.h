//
//  AGStatus.h
//  18AG微博
//
//  Created by again on 15/11/15.
//  Copyright © 2015年 again. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AGUser;

@interface AGStatus : NSObject
/** 微博的内容*/
@property (nonatomic, copy) NSString *text;

/** 微博的来源*/
@property (nonatomic, copy) NSString *source;

/** 微博的时间*/
@property (nonatomic, copy) NSString *created_at;

/** 微博的ID*/
@property (nonatomic, copy) NSString *idstr;

/** 微博的单张配图*/
@property (nonatomic, copy)NSArray *pic_urls;

/** 微博的转发数*/
@property (nonatomic, assign) NSInteger reposts_count;

/** 微博的评论数*/
@property (nonatomic, assign) NSInteger comments_count;
/** 微博的表态数*/
@property (nonatomic, assign) NSInteger attitudes_count;

/** 微博的作者*/
@property (nonatomic, strong) AGUser *user;

/** 被转发的微博*/
@property (nonatomic, strong) AGStatus *retweeted_status;

@end
