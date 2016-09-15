//
//  AGComposeViewController.m
//  18AG微博
//
//  Created by again on 16/8/9.
//  Copyright © 2016年 again. All rights reserved.
//

#import "AGComposeViewController.h"
#import "AGTextView.h"
#import "AFNetworking.h"
#import "AGAccountTool.h"
#import "AGAccount.h"
#import "MBProgressHUD+MJ.h"
#import "AGComposeToolBar.h"
#import "AGComposePhotoView.h"
#import "AGSendStatusParam.h"
#import "AGStatusTool.h"
#import "AGHttpTool.h"

@interface AGComposeViewController ()<UITextViewDelegate, AGComposeToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak,nonatomic) AGTextView *textView;
@property (weak,nonatomic) AGComposeToolBar *toolBar;
@property (weak,nonatomic) AGComposePhotoView *photoView;
@end

@implementation AGComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNavBar];
    //设置输入栏
    [self setupTextView];
    
    //设置工具条
    [self setupToolBar];
    
    //设置选择后的图片显示
    [self setupImageView];
}

- (void)setupImageView
{
    AGComposePhotoView *photoView = [[AGComposePhotoView alloc] init];
    CGFloat photosW = self.textView.frame.size.width;
    CGFloat photosH = self.textView.frame.size.height;
    CGFloat photosY = 80;
    photoView.frame = CGRectMake(0, photosY, photosW, photosH);
    [self.textView addSubview:photoView];
    self.photoView = photoView;
}

/**添加工具条*/
- (void)setupToolBar
{
    AGComposeToolBar *toolBar = [[AGComposeToolBar alloc] init];
    toolBar.delegate = self;
    CGFloat toolbarX = 0;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolBarH = 44;
    CGFloat toolbarY = self.view.frame.size.height - toolBarH;
    toolBar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolBarH);
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark toolbar的代理方法
- (void)composeToolbar:(AGComposeToolBar *)boolbar didClickButton:(AGComposeToolBarButtonType)buttonType
{
    switch (buttonType) {
        case AGComposeToolBarButtonTypeCamera:
            [self openCamera];
            break;
        case AGComposeToolBarButtonTypePicture:
            [self openPicture];
        default:
            break;
    }
}
//打开相机
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

//打开相册
- (void)openPicture
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photoView addImage:image];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

//设置textView
- (void)setupTextView
{
    AGTextView *textView = [[AGTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    textView.placeHoder = @"分享新鲜事...";
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    [AGNOtificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    [AGNOtificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidBeginEditingNotification object:textView];
    
    [AGNOtificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [AGNOtificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 键盘弹出处理
- (void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)note
{
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];

}

- (void)dealloc
{
    [AGNOtificationCenter removeObserver:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

//监听文字改变
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
}

- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.title = @"发微博";

}

- (void)cancel{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//发微博
- (void)send
{
    if (self.photoView.totalImage.count) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 发微博
- (void)sendWithImage
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AGAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    NSMutableArray *formDataArray = [NSMutableArray array];
    NSArray *images = [self.photoView totalImage];
    for (UIImage *image in images) {
        AGFormData *formData = [[AGFormData alloc] init];
        formData.data = UIImageJPEGRepresentation(image, 0.5);
        formData.name = @"pic";
        formData.mimetype = @"image/jpeg";
        formData.filename = @"";
        [formDataArray addObject:formData];
    }
    [AGHttpTool postWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params formDaraArray:formDataArray success:^(id json) {
        [MBProgressHUD showMessage:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
//    
//         [mgr POST:@"https://api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSArray *images = [self.photoView totalImage];
//        
//        for (UIImage *image in images) {
//            NSData *data = UIImageJPEGRepresentation(image, 0.1);
//            [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
//        }
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD showError:@"发送失败"];
//    }];
}

//发没有图片的微博
- (void)sendWithoutImage
{
    AGSendStatusParam *param = [AGSendStatusParam param];
    param.sataus = self.textView.text;
    [AGStatusTool sendStatusWithParam:param success:^(AGSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [AGAccountTool account].access_token;
//    params[@"status"] = self.textView.text;
//    
//    [AGHttpTool postWithUrl:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id json) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"发送失败"];
//    }];
    
//    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD showError:@"发送失败"];
//    }];
}
@end
