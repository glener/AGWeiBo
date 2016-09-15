//
//  AGUser.h
//  18AG微博
//
//  Created by again on 16/8/7.
//  Copyright © 2016年 again. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGUser : NSObject
/** 用户的ID*/
@property (copy,nonatomic) NSString *idstr;

/** 用户的昵称*/
@property (copy,nonatomic) NSString *name;

/** 用户的头像*/
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员等级*/
@property (nonatomic, assign) int mbrank;

/** 会员类型*/
@property (nonatomic, assign) int mbtype;
@end
