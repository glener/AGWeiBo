//
//  AGBaseParam.m
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGBaseParam.h"
#import "AGAccount.h"
#import "AGAccountTool.h"

@implementation AGBaseParam
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.access_token = [AGAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end
