//
//  AGHttpTool.h
//  again微博
//
//  Created by again on 16/8/11.
//  Copyright © 2016年 again. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGHttpTool : NSObject
/**
 *  发送一个post请求
 *
 *  @param url     请求路径
 *  @param params  参数
 *  @param success 成功后的回调
 *  @param failure 失败后的回调
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)parmas success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

// 发送post请求（上传文件数据）
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)parmas formDaraArray:(NSArray *)array success:(void (^)(id json))success failure:(void (^)(NSError *errror))failure;

/**
 *  发送一个get请求
 *
 *  @param url     请求路径
 *  @param params  参数
 *  @param success 成功后的回调
 *  @param failure 失败后的回调
 */
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

@end

@interface AGFormData : NSObject
/**
 *  文件数据
 */
@property (strong,nonatomic) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 * 文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimetype;
@end

