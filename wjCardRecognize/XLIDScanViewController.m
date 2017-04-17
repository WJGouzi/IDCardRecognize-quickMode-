//
//  XLIDScanViewController.m
//  IDAndBankCard
//
//  Created by  on 2017/3/28.
//  Copyright © 2017年 mxl. All rights reserved.
//

#import "XLIDScanViewController.h"
#import "IDOverLayerView.h"
#import "wjResultVC.h"

@interface XLIDScanViewController ()

@property (nonatomic, strong) IDOverLayerView *overlayView;

@end

@implementation XLIDScanViewController

-(IDOverLayerView *)overlayView {
    if(!_overlayView) {
        CGRect rect = [IDOverLayerView getOverlayFrame:[UIScreen mainScreen].bounds];
        _overlayView = [[IDOverLayerView alloc] initWithFrame:rect];
    }
    return _overlayView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 插入提示框
    [self.view insertSubview:self.overlayView atIndex:0];
    
    [self startOpenCameraInitialization];
    
    [self quitCurrentControllerViewSettings];
    
}


/** 退出按钮*/
- (void)quitCurrentControllerViewSettings {
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnX = self.view.frame.size.width - 50;
    CGFloat btnY = 50;
    quitBtn.frame = CGRectMake(btnX, btnY, 30, 30);
    quitBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [quitBtn setTitle:@"退出" forState:UIControlStateNormal];
    quitBtn.backgroundColor = [UIColor redColor];
    quitBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [quitBtn addTarget:self action:@selector(quitControllerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitBtn];
    
}


/** 退出事件*/
- (void)quitControllerAction {
   [self dismissViewControllerAnimated:YES completion:^{
       [self.cameraManager stopSession];
   }];
}

/** 摄像头的初始化*/
- (void)startOpenCameraInitialization {
    self.cameraManager.sessionPreset = AVCaptureSessionPresetHigh;
    
    if ([self.cameraManager configIDScanManager]) {
        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:view atIndex:0];
        AVCaptureVideoPreviewLayer *preLayer = [AVCaptureVideoPreviewLayer layerWithSession: self.cameraManager.captureSession];
        preLayer.frame = [UIScreen mainScreen].bounds;
        
        preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [view.layer addSublayer:preLayer];
        
        [self.cameraManager startSession];
    }
    else {
        NSLog(@"打开相机失败");
        [self.navigationController popViewControllerAnimated:YES];
    }
    // 扫描成功的处理方法
    [self.cameraManager.idCardScanSuccess subscribeNext:^(id result) {
        NSLog(@"result is %@", result);
        wjResultVC *vc = [[wjResultVC alloc] init];
        vc.model = (XLScanResultModel *)result;
        [self presentViewController:vc animated:YES completion:^{
            [self.cameraManager stopSession];
        }];
    }];
    
    
    [self.cameraManager.scanError subscribeNext:^(id x) {
        // 扫描失败的提醒
    }];
}


@end
