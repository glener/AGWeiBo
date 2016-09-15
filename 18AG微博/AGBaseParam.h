//
//  AGBaseParam.h
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGBaseParam : NSObject
@property (nonatomic, copy) NSString *access_token;
+ (instancetype)param;
@end
