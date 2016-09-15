//
//  AGWeiboTool.m
//  18AG微博
//
//  Created by again on 16/8/6.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGWeiboTool.h"
#import "AGTabBarViewController.h"
#import "AGNewfeatureController.h"
#import "AGAccount.h"

@implementation AGWeiboTool

+ (void)chooseRootViewController
{    
    NSString *key = @"CFBundleVersion";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[AGTabBarViewController alloc] init];
    } else {
       [UIApplication sharedApplication].keyWindow.rootViewController = [[AGNewfeatureController alloc] init];
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}
@end
