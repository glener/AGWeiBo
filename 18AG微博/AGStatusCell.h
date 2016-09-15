//
//  AGStatusCell.h
//  18AG微博
//
//  Created by again on 15/11/15.
//  Copyright © 2015年 again. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGStatusFrame;
@interface AGStatusCell : UITableViewCell

@property (nonatomic, strong) AGStatusFrame *statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
