//
//  Account.m
//  18AG微博
//
//  Created by again on 16/8/6.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGAccount.h"

@implementation AGAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc ]initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
//将对象写入文件时调用
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
}
//从文件中解析对象时候调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.expiresTime = [aDecoder decodeObjectForKey:@"expiresTime"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
