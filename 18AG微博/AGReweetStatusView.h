//
//  AGReweetStatusView.h
//  18AG微博
//
//  Created by again on 16/8/8.
//  Copyright © 2016年 again. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGStatusFrame;
@interface AGReweetStatusView : UIImageView
//传递的模型，用于设置数据和视图
@property (strong,nonatomic) AGStatusFrame *statusFrame;
@end
