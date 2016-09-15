//
//  Account.h
//  18AG微博
//
//  Created by again on 16/8/6.
//  Copyright © 2016年 again. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGAccount : NSObject<NSCoding>

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;
@property (nonatomic, strong) NSDate *expiresTime;//账号过期时间
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
