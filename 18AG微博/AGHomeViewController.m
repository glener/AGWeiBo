//
//  AGHomeViewController.m
//  18AG微博
//
//  Created by again on 16/8/3.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGHomeViewController.h"
#import "UIBarButtonItem+AG.h"
#import "AGTitleButton.h"
#import "AGStatus.h"
#import "AGStatusCell.h"
#import "AGStatusFrame.h"
#import "AFNetworking.h"
#import "AGAccountTool.h"
#import "AGAccount.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "AGUser.h"
#import "AGBadgeButton.h"
#import "MJRefresh.h"
#import "AGStatusTool.h"
#import "AGUserTool.h"

@interface AGHomeViewController ()<MJRefreshBaseViewDelegate>

@property (weak,nonatomic) AGTitleButton *titleButton;
@property (weak,nonatomic) MJRefreshHeaderView *header;
@property (weak,nonatomic) MJRefreshFooterView *footer;
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation AGHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self setNavBar];
    
    //集成刷新控件
    [self setupRefreshView];
    
    //获取用户信息
    [self setupUserData];
}

- (void)refresh
{
//    if ([self.tabBarItem.badgeValue intValue] != 0) {
        [self.header beginRefreshing];
//    }
}

//设置用户信息
- (void)setupUserData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AGAccountTool account].access_token;
    params[@"uid"] = @([AGAccountTool account].uid);
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        AGUser *user = [AGUser objectWithKeyValues:responseObject];
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        AGAccount *account = [AGAccountTool account];
        account.name = user.name;
        [AGAccountTool saveAccount:account];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)setupRefreshView
{
    //下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate =self;
    [header beginRefreshing];
    self.header = header;
    
//    UIRefreshControl *refreshVc = [[UIRefreshControl alloc] init];
//    [self.tableView addSubview:refreshVc];
//    [refreshVc addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
//    [refreshVc beginRefreshing];
//    [self refreshStateChange:refreshVc];
    
    //上拉刷新（加载更多旧的数据
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
    
}

- (void)dealloc
{
    [self.header free];
    [self.footer free];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        [self loadMoreData];
    } else {
        [self loadNewData];
    }
}
#pragma mark - 刷新加载数据
//上拉刷新
- (void)loadMoreData
{
    AGHomeStatusParam *param = [AGHomeStatusParam param];
    if (self.statusFrames.count) {
        AGStatusFrame *statusFrame = [self.statusFrames lastObject];
        param.max_id = @([statusFrame.status.idstr longLongValue] - 1);
    }
    
    [AGStatusTool homeStatusWithParam:param success:^(AGHomeStatusResult *result) {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        
        for (AGStatus *status in result.statuses) {
            AGStatusFrame *statusFrame = [[AGStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        
        [self.tableView reloadData];
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        [self.footer endRefreshing];
    }];
    
//    [AGHttpTool getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id json) {
//        NSArray *statusArray = [AGStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        
//        for (AGStatus *status in statusArray) {
//            AGStatusFrame *statusFrame = [[AGStatusFrame alloc] init];
//            statusFrame.status = status;
//            [statusFrameArray addObject:statusFrame];
//        }
//        
//        [self.statusFrames addObjectsFromArray:statusFrameArray];
//        
//        [self.tableView reloadData];
//        [self.footer endRefreshing];
//    } failure:^(NSError *error) {
//         [self.footer endRefreshing];
//    }];
    
//    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
//        NSArray *statusArray = [AGStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        
//        for (AGStatus *status in statusArray) {
//            AGStatusFrame *statusFrame = [[AGStatusFrame alloc] init];
//            statusFrame.status = status;
//            [statusFrameArray addObject:statusFrame];
//        }
//        
//        [self.statusFrames addObjectsFromArray:statusFrameArray];
//        
//        [self.tableView reloadData];
//        [self.footer endRefreshing];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self.footer endRefreshing];
//    }];
}

//下拉刷新
- (void)loadNewData
{
    self.tabBarItem.badgeValue = nil;
    AGHomeStatusParam *param = [AGHomeStatusParam param];
    if (self.statusFrames.count) {
        AGStatusFrame *statusFrame = self.statusFrames[0];
        param.since_id = @([statusFrame.status.idstr longLongValue]);
    }
    
    [AGStatusTool homeStatusWithParam:param success:^(AGHomeStatusResult *result) {
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (AGStatus *status in result.statuses) {
            AGStatusFrame *statusFrame = [[AGStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        
        [self.tableView reloadData];
        [self.header endRefreshing];
        [self showNewStatusCount:statusFrameArray.count];
    } failure:^(NSError *error) {
        [self.header endRefreshing];
    }];
    
//    [AGHttpTool getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id json) {
//        NSArray *statusArray = [AGStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        
//        for (AGStatus *status in statusArray) {
//            AGStatusFrame *statusFrame = [[AGStatusFrame alloc] init];
//            statusFrame.status = status;
//            [statusFrameArray addObject:statusFrame];
//        }
//        NSMutableArray *tempArray = [NSMutableArray array];
//        [tempArray addObjectsFromArray:statusFrameArray];
//        [tempArray addObjectsFromArray:self.statusFrames];
//        self.statusFrames = tempArray;
//        
//        [self.tableView reloadData];
//        [self.header endRefreshing];
//        [self showNewStatusCount:statusFrameArray.count];
//    } failure:^(NSError *error) {
//        [self.header endRefreshing];
//    }];
    
//        [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
//             NSArray *statusArray = [AGStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//             NSMutableArray *statusFrameArray = [NSMutableArray array];
//             
//             for (AGStatus *status in statusArray) {
//                 AGStatusFrame *statusFrame = [[AGStatusFrame alloc] init];
//                 statusFrame.status = status;
//                 [statusFrameArray addObject:statusFrame];
//             }
//            NSMutableArray *tempArray = [NSMutableArray array];
//            [tempArray addObjectsFromArray:statusFrameArray];
//            [tempArray addObjectsFromArray:self.statusFrames];
//            self.statusFrames = tempArray;
//             
//             [self.tableView reloadData];
//            [self.header endRefreshing];
//            [self showNewStatusCount:statusFrameArray.count];
//         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////             [refreshController endRefreshing];
//         }];
}

- (void)showNewStatusCount:(NSInteger)count
{
    UIButton *btn = [[UIButton alloc] init];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background_os7"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        [btn setTitle:[NSString stringWithFormat:@"共有%zd条新的微博", count] forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    CGFloat btnH = 30;
    CGFloat btnX = 2;
    CGFloat btnW = self.view.frame.size.width - 2*btnX;
    CGFloat btnY = 64 - btnH;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    [UIView animateWithDuration:0.7 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 delay:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}

//- (void)setupStatusData
//{
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [AGAccountTool account].access_token;
//    params[@"count"] = @50;
//    
//    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
//    {
//        NSArray *statusArray = [AGStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        
//        for (AGStatus *status in statusArray) {
//            AGStatusFrame *statusFrame = [[AGStatusFrame alloc] init];
//            statusFrame.status = status;
//            [statusFrameArray addObject:statusFrame];
//        }
//        self.statusFrames = statusFrameArray;
//
//        [self.tableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
//    
//}

// 设置导航栏内容
- (void)setNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch_os7" highIcon:@"navigationbar_friendsearch_highlighted_os7" target:self action:@selector(findFriend)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop_os7" highIcon:@"navigationbar_pop_highlighted_os7" target:self action:@selector(scan)];
    
    //中间按钮
    AGTitleButton *titleButton = [AGTitleButton titleButton];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
    
    titleButton.frame = CGRectMake(0, 0, 60, 40);
    
    if ([AGAccountTool account].name) {
        [titleButton setTitle:[AGAccountTool account].name forState:UIControlStateNormal];
    } else {
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.tag = 1;
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    self.tableView.backgroundColor = AGColor(226, 226, 226);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, AGStatusTableBoder, 0);
}

//点击中间按钮处理
- (void)titleClick:(AGTitleButton *)titleButton{
    if (titleButton.tag == 1) {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up_os7"] forState:UIControlStateNormal];
        titleButton.tag = 0;
    } else if (titleButton.tag == 0){
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
        titleButton.tag = 1;
    }
}

// 右边导航按钮
- (void)scan{}

//左边导航按钮
- (void)findFriend{}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
//    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AGStatusCell *cell = [AGStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
////    NSDictionary *status = self.statuses[indexPath.row];
//    cell.textLabel.text = status[@"text"];
//    
//    NSDictionary *user = status[@"user"];
//    cell.detailTextLabel.text = user[@"name"];
//    NSString *iconUrl = user[@"profile_image_url"];
//    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"tabbar_compose_button_os7"]];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AGStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    return statusFrame.cellHeight;
}


@end
