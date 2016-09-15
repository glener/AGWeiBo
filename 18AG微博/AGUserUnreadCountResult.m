//
//  AGUserUnreadCountResult.m
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGUserUnreadCountResult.h"

@implementation AGUserUnreadCountResult
- (int)messageCount
{
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
}

- (int)count{
    return self.messageCount + self.status + self.follower;
}
@end
