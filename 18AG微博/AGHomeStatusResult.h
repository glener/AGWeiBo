//
//  AGHomeStatusResult.h
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGHomeStatusResult : NSObject
/**
 *  statuses数组里面放的都是IWStatus模型
 */
@property (nonatomic, strong) NSArray *statuses;

@property (nonatomic, assign) long long previous_cursor;
@property (nonatomic, assign) long long next_cursor;

/**
 *  总数
 */
@property (nonatomic, assign) long long total_number;

@end
