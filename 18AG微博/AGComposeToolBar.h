//
//  AGComposeToolBar.h
//  18AG微博
//
//  Created by again on 16/8/10.
//  Copyright © 2016年 again. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGComposeToolBar;
typedef enum {
    AGComposeToolBarButtonTypeCamera,
    AGComposeToolBarButtonTypePicture,
    AGComposeToolBarButtonTypeMention,
    AGComposeToolBarButtonTypeTrend,
    AGComposeToolBarButtonTypeEmotion
} AGComposeToolBarButtonType;

@protocol AGComposeToolBarDelegate <NSObject>

@optional

- (void)composeToolbar:(AGComposeToolBar *)boolbar didClickButton:(AGComposeToolBarButtonType)buttonType;
@end

@interface AGComposeToolBar : UIView
@property (weak,nonatomic) id<AGComposeToolBarDelegate> delegate;
@end
