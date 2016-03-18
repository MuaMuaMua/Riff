//
//  AvatarViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/18.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "AvatarViewController.h"

#define winSize [[UIScreen mainScreen]bounds]

@interface AvatarViewController ()<UIScrollViewDelegate> {
    
    UIScrollView *_avatarScrollview;
    
    UIImageView * _avatarImageView;
    
}

@end

@implementation AvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人头像";
    [self loadAvatar];
    [self setupDoubleTapGesture];
    [self addRightBarBtn];
    // Do any additional setup after loading the view from its nib.
}

- (void)addRightBarBtn {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"RightItem"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
}

- (void)clickRightItem {
    NSLog(@"点击了获取摄像头的按钮");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _avatarImageView.image = [UIImage imageNamed:@"CHUANG"];
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
