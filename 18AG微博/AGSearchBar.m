//
//  AGSearchBar.m
//  18AG微博
//
//  Created by again on 16/8/5.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGSearchBar.h"
#import "UIImage+MJ.h"

@implementation AGSearchBar

+ (instancetype)searchBar{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        {
            self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background_os7"];
            UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
            iconView.contentMode = UIViewContentModeCenter;
            self.leftView = iconView;
            self.leftViewMode = UITextFieldViewModeAlways;
            // 字体
            self.font = [UIFont systemFontOfSize:13];
            // 右边的清除按钮
            self.clearButtonMode = UITextFieldViewModeAlways;
            // 设置提醒文字
            NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
            attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attrs];
           
            // 设置键盘右下角按钮的样式
            self.returnKeyType = UIReturnKeySearch;
            self.enablesReturnKeyAutomatically= YES;
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
}
@end
