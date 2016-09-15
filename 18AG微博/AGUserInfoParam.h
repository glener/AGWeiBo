//
//  AGUserInfoParam.h
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGBaseParam.h"

@interface AGUserInfoParam : AGBaseParam

/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

/**
 *  需要查询的用户昵称。
 */
@property (nonatomic, copy) NSString *screen_name;
@end
