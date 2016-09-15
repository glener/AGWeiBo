//
//  AccountTool.m
//  18AG微博
//
//  Created by again on 16/8/6.
//  Copyright © 2016年 again. All rights reserved.
//

#define AGAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "AGAccount.h"
#import "AGAccountTool.h"

@implementation AGAccountTool
+ (void)saveAccount:(AGAccount*)account
{
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:AGAccountFile];
}

+ (AGAccount *)account
{
    AGAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AGAccountFile];
    // 判断账号是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) {
        return account;
    } else {
        return nil;//过期
    }
}
@end
