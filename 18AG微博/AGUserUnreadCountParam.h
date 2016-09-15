//
//  AGUserUnreadCountParam.h
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGBaseParam.h"

@interface AGUserUnreadCountParam : AGBaseParam
/**
 *  需要查询的用户ID。
 */
@property (strong,nonatomic) NSNumber *uid;
@end
