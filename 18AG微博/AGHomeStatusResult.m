//
//  AGHomeStatusResult.m
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGHomeStatusResult.h"
#import "AGStatus.h"
#import "MJExtension.h"

@implementation AGHomeStatusResult
- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [AGStatus class]};
}
@end
