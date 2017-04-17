//
//  ViewController.m
//  wjCardRecognize
//
//  Created by gouzi on 2017/4/17.
//  Copyright © 2017年 wj. All rights reserved.
//

#import "ViewController.h"
#import "XLIDScanViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightTextColor];
}



- (IBAction)scanIDCardAction:(UIButton *)sender {
//    [self.navigationController pushViewController:[[XLIDScanViewController alloc] init] animated:YES];
    [self presentViewController:[[XLIDScanViewController alloc] init] animated:YES completion:nil];
}


@end
