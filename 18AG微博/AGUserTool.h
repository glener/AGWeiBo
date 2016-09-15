//
//  AGUserTool.h
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGUserInfoParam.h"
#import "AGUserInfoResult.h"
#import "AGUserUnreadCountParam.h"
#import "AGUserUnreadCountResult.h"

@interface AGUserTool : NSObject
/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userInfoWithParam:(AGUserInfoParam *)param success:(void (^)(AGUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载用户的消息未读数
 */
+ (void)userUnreadCountWithParam:(AGUserUnreadCountParam *)param success:(void (^)(AGUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;
@end
