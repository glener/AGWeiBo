//
//  AGUserTool.m
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGUserTool.h"
#import "AGHttpTool.h"
#import "MJExtension.h"

@implementation AGUserTool

+ (void)userInfoWithParam:(AGUserInfoParam *)param success:(void (^)(AGUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [AGHttpTool getWithUrl:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        if (success) {
            AGUserInfoResult *reuslt = [AGUserInfoResult objectWithKeyValues:json];
            success(reuslt);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        };
    }];
}

+ (void)userUnreadCountWithParam:(AGUserUnreadCountParam *)param success:(void (^)(AGUserUnreadCountResult *))success failure:(void (^)(NSError *))failure
{
    [AGHttpTool getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json"  params:param.keyValues success:^(id json) {
        if (success) {
            AGUserUnreadCountResult *result = [AGUserUnreadCountResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
