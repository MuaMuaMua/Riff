//
//  AvatarViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/18.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "AvatarViewController.h"
#import "RiffNetworkManager.h"
#import <MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>

#define winSize [[UIScreen mainScreen]bounds]

@interface AvatarViewController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    
    UIScrollView *_avatarScrollview;
    
    UIImageView * _avatarImageView;
    
    UIAlertController * _alertController;
    
    UIImagePickerController * _pickerController;
    
    UIImage * _pickImage;
    
    RiffNetworkManager * _riffNetworkManager;

    MBProgressHUD * _mbpHud;
}

@end

@implementation AvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人头像";
    [self setupNetworkManager];
    [self loadAvatar];
    [self setupDoubleTapGesture];
    [self addRightBarBtn];
    [self setupAlertController];
}

#pragma mark - setupNetworkManager 
- (void)setupNetworkManager {
    _riffNetworkManager = [RiffNetworkManager sharedInstance];
}

- (void)addRightBarBtn {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"RightItem"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
}

- (void)clickRightItem {
    [self presentViewController:_alertController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AvatarData"]) {
        UIImage * savedImage = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"AvatarData"]];
        _avatarImageView.image = savedImage;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - alertController Settings 
- (void)setupAlertController {
    _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了拍照");
        _pickerController = [[UIImagePickerController alloc]init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            _pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            _pickerController.delegate = self;
            _pickerController.allowsEditing = YES;
        }
        [self presentViewController:_pickerController animated:YES completion:nil];
    }];
    UIAlertAction * picAlbumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _pickerController = [[UIImagePickerController alloc]init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            _pickerController.delegate = self;
            _pickerController.allowsEditing = YES;
        }
        [self presentViewController:_pickerController animated:YES completion:nil];
        NSLog(@"点击了相册");
    }];
    [_alertController addAction:cancelAction];
    [_alertController addAction:cameraAction];
    [_alertController addAction:picAlbumAction];
}

#pragma mark - imagepicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 选择完成策略  直接上传.
    [picker dismissViewControllerAnimated:YES completion:nil];
    _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _mbpHud.mode = MBProgressHUDModeIndeterminate;
    _mbpHud.labelText = @"正在上传";
    
    _pickImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    _avatarImageView.image = _pickImage;
    NSData * imageData = UIImageJPEGRepresentation(_pickImage, 1);
    [[NSUserDefaults standardUserDefaults]setObject:imageData forKey:@"AvatarData"];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    [_riffNetworkManager getQNTokenWithDTZSuccessBlock:^(NSDictionary *successBlock) {
        NSLog(@"%@",successBlock);
        NSNumber * code = [successBlock objectForKey:@"code"];
        if (code.intValue == 200) {
            NSString * key = [successBlock objectForKey:@"key"];
            NSString * upToken = [successBlock objectForKey:@"upToken"];
            [_riffNetworkManager uploadAvatarToQNServerWithImageData:imageData Key:key UploadToken:upToken DTZSuccessBlock:^(NSDictionary *successBlock) {
                NSLog(@"%@",successBlock);
                NSString * avatarUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"avatar"];
                if (avatarUrl) {
                    [_riffNetworkManager uploadUserAvatarUrlWithUrl:avatarUrl DTZSuccessBlock:^(NSDictionary *successBlock) {
                        NSNumber * code = [successBlock objectForKey:@"code"];
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                        if (code.intValue == 200) {
                            //上传成功再 设置到avatarUrl 中 否在不算上传成功.
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [[NSUserDefaults standardUserDefaults]setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"avatar"] forKey:@"avatarUrl"];
                            _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            _mbpHud.labelText = @"上传成功";
                            _mbpHud.mode = MBProgressHUDModeText;
                            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            });
                        }else {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            _mbpHud.labelText = @"上传失败";
                            _mbpHud.mode = MBProgressHUDModeText;
                            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                            });
                        }
                    } DTZFailBlock:^(NSDictionary *failBlock) {
                        _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        _mbpHud.labelText = @"服务器故障，请稍后再试";
                        _mbpHud.mode = MBProgressHUDModeText;
                        dispatch_after(popTime, dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                        });
                    }];

                }
                
            } DTZFailBlock:^(NSDictionary *failBlock) {
                
            }];
        }
        
    } DTZFailBlock:^(NSDictionary *failBlock) {
        _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHud.labelText = @"服务器故障,请稍后再试";
        _mbpHud.mode = MBProgressHUDModeText;
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //设置cancel 策略
    
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadAvatar {
    //设定为正方形
    _avatarScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, winSize.size.width, winSize.size.height)];
    _avatarScrollview.bouncesZoom = YES;
    _avatarScrollview.maximumZoomScale = 2.5;
    _avatarScrollview.minimumZoomScale = 1.0;
    _avatarScrollview.multipleTouchEnabled = YES;
    _avatarScrollview.delegate = self;
    _avatarScrollview.scrollsToTop = YES;
    _avatarScrollview.showsHorizontalScrollIndicator = NO;
    _avatarScrollview.showsVerticalScrollIndicator = NO;
    _avatarScrollview.canCancelContentTouches = YES;
    _avatarScrollview.clipsToBounds = YES;
    [self.view addSubview:_avatarScrollview];
    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, winSize.size.height / 2 - winSize.size.width / 2 - 50, winSize.size.width , winSize.size.width)];
    NSString * avatarUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"avatarUrl"];
    if (avatarUrl) {
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:@"CHUANG"] completed:nil];
    }else {
        _avatarImageView.image = [UIImage imageNamed:@"CHUANG"];
    }
    _avatarImageView.userInteractionEnabled = YES;
    _avatarImageView.clipsToBounds = YES;
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_avatarScrollview addSubview:_avatarImageView];
}

- (void)setupDoubleTapGesture {
    UITapGestureRecognizer * doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    _avatarScrollview.userInteractionEnabled = YES;
    [_avatarScrollview addGestureRecognizer:doubleTapGesture];
}

- (void)doubleTap:(UITapGestureRecognizer *)tap {
    if (_avatarScrollview.zoomScale > 1.0) {
        [_avatarScrollview setZoomScale:1.0 animated:YES];
    }else {
        CGPoint touchPoint = [tap locationInView:_avatarImageView];
        CGFloat newZoomScale = _avatarScrollview.maximumZoomScale;
        CGFloat xSize = self.view.frame.size.width / newZoomScale;
        CGFloat ySize = self.view.frame.size.height / newZoomScale;
        [_avatarScrollview zoomToRect:CGRectMake(touchPoint.x - xSize / 2, touchPoint.y - ySize / 2, xSize, ySize) animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _avatarImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (_avatarScrollview.frame.size.width > _avatarScrollview.contentSize.width) ? (_avatarScrollview.frame.size.width - _avatarScrollview.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _avatarImageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY - 50);
}


@end
