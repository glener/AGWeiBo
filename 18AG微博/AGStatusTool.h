//
//  AGStatusTool.h
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGHomeStatusParam.h"
#import "AGHomeStatusResult.h"
#import "AGSendStatusParam.h"
#import "AGSendStatusResult.h"

@interface AGStatusTool : NSObject
/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)homeStatusWithParam:(AGHomeStatusParam *)param success:(void (^)(AGHomeStatusResult *result))success failure:(void(^)(NSError *error))failure;
                                                                
                                                                
+ (void)sendStatusWithParam:(AGSendStatusParam *)param success:(void (^)(AGSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
@end
