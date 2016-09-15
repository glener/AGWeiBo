//
//  AGOAuthViewController.m
//  18AG微博
//
//  Created by again on 16/8/6.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGOAuthViewController.h"
#import "AFNetworking.h"
#import "AGAccount.h"
#import "AGWeiboTool.h"
#import "AGAccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface AGOAuthViewController ()<UIWebViewDelegate>

@end

@implementation AGOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webVeiw = [[UIWebView alloc] init];
    webVeiw.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:webVeiw];
    webVeiw.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3242818194&redirect_uri=https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webVeiw loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [MBProgressHUD hideHUD];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        NSInteger loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3242818194";
    params[@"client_secret"] = @"dc3624f15c735a518d8aae4778358246";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"https://www.baidu.com";
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        AGAccount *account = [AGAccount accountWithDict:responseObject];
        
        //存储模型数据
        [AGAccountTool saveAccount:account];
        
        // 去首页或是新特性
        
        [AGWeiboTool chooseRootViewController];
        
        [MBProgressHUD hideHUD];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@", error);
    }];
}

@end
