//
//  AccountTool.h
//  18AG微博
//
//  Created by again on 16/8/6.
//  Copyright © 2016年 again. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AGAccount;

@interface AGAccountTool : NSObject
+ (void)saveAccount:(AGAccount*)account;

+ (AGAccount *)account;
@end
