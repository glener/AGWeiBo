//
//  AGSendStatusParam.h
//  again微博
//
//  Created by again on 16/8/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import "Foundation/Foundation.h"
#import "AGBaseParam.h"

@interface AGSendStatusParam : AGBaseParam
/**
 *  要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@property (nonatomic, copy) NSString *sataus;
@end
