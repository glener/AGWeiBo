//
//  AGStatusCell.m
//  18AG微博
//
//  Created by again on 15/11/15.
//  Copyright © 2015年 again. All rights reserved.
//

#import "AGStatusCell.h"
#import "AGStatus.h"
#import "AGStatusFrame.h"
#import "AGUser.h"
#import "UIImage+MJ.h"
#import "AGStatusToolBar.h"
#import "AGStatusTopView.h"

@interface AGStatusCell()

/** 顶部的view（父控件） */
@property (nonatomic, weak) AGStatusTopView *topView;


/** 微博的工具条 */
@property (nonatomic, weak) AGStatusToolBar *statusToolbar;


@end
@implementation AGStatusCell

#pragma mark 初始化
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //原创微博内部的子控件
        [self setupTopView];
        
        //微博工具条
        [self setupStatusToolBar];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += AGStatusTableBoder;
    frame.origin.x = AGStatusTableBoder;
    frame.size.width -= 2 * AGStatusTableBoder;
    frame.size.height -= AGStatusTableBoder;
    [super setFrame:frame];
}

#pragma mark cell里view的设置
/**微博的子控件*/
- (void)setupTopView
{
    self.selectedBackgroundView = [[UIView alloc] init];
    self.backgroundColor = [UIColor clearColor];
    
    AGStatusTopView *topView = [[AGStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

/**微博工具条View的设置*/
- (void)setupStatusToolBar
{
    AGStatusToolBar *statusToolBar = [[AGStatusToolBar alloc] init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolbar = statusToolBar;
}

#pragma mark 数据的传递
//传递微博模型数据
- (void)setStatusFrame:(AGStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //原创微博
    [self setupTopViewData];
    //微博工具条数据传递
    [self setupStatusToolBarData];
}

/** 设置微博工具条数据*/
- (void)setupStatusToolBarData{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
    self.statusToolbar.status = self.statusFrame.status;
}

/** 原创微博的数据传递 */
- (void)setupTopViewData
{
    
    self.topView.frame = self.statusFrame.topViewF;
    
    self.topView.statusFrame = self.statusFrame;
}

//- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
//{
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    AGStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[AGStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    return cell;
}

@end
