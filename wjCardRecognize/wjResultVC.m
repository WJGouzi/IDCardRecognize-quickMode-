//
//  wjResultVC.m
//  wjCardRecognize
//
//  Created by gouzi on 2017/4/17.
//  Copyright © 2017年 wj. All rights reserved.
//

#import "wjResultVC.h"


@interface wjResultVC ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *birthLabel;

@property (weak, nonatomic) IBOutlet UILabel *genderLabel;

@property (weak, nonatomic) IBOutlet UILabel *nationalityLabel;

@property (weak, nonatomic) IBOutlet UILabel *adressLabel;

@end

@implementation wjResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCardInfo];
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
    [self dismissToRootViewController];
}


/** 展示身份证信息*/
- (void)showCardInfo {
    self.nameLabel.text = self.model.name;
    self.numberLabel.text = self.model.code;
    self.birthLabel.text = [self judgeBirthDayWith:self.numberLabel.text];
    self.genderLabel.text = self.model.gender;
    self.nationalityLabel.text = self.model.nation;
    self.adressLabel.text = self.model.address;
}

#pragma mark - 判断生日
- (NSString *)judgeBirthDayWith:(NSString *)idNumber {
    NSInteger year = [[idNumber substringWithRange:NSMakeRange(6, 4)] integerValue];
    NSInteger month = [[idNumber substringWithRange:NSMakeRange(10, 2)] integerValue];
    NSInteger day = [[idNumber substringWithRange:NSMakeRange(12, 2)] integerValue];
    return [NSString stringWithFormat:@"%ld年%ld月%ld日", year, month, day];
}

#pragma mark - 退出到根控制器
-(void)dismissToRootViewController {
    UIViewController *vc = self;
    while (vc.presentingViewController) { // vc是存在一个控制器将其推出
        // 指的是推出vc这个控制器的指针指向了vc
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}


@end
