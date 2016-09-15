//
//  AGStatusTool.m
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGStatusTool.h"
#import "AGHttpTool.h"
#import "MJExtension.h"

@implementation AGStatusTool

+ (void)homeStatusWithParam:(AGHomeStatusParam *)param success:(void (^)(AGHomeStatusResult *))success failure:(void (^)(NSError *))failure
{
    [AGHttpTool getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
        if (success) {
            AGHomeStatusResult *result = [AGHomeStatusResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)sendStatusWithParam:(AGSendStatusParam *)param success:(void (^)(AGSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [AGHttpTool postWithUrl:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id json) {
        if (success) {
            AGSendStatusResult *result = [AGSendStatusResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
