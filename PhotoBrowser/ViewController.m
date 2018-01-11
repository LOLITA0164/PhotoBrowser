//
//  ViewController.m
//  PhotoBrowser
//
//  Created by LOLITA on 2017/9/5.
//  Copyright © 2017年 LOLITA0164. All rights reserved.
//

#import "ViewController.h"
#import "PhotoBrowser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *localBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    localBtn.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    [localBtn setTitle:@"本地图片" forState:UIControlStateNormal];
    [localBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [localBtn addTarget:self action:@selector(localBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:localBtn];
    
    
    UIButton *networkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    networkBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    [networkBtn setTitle:@"网络图片" forState:UIControlStateNormal];
    [networkBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [networkBtn addTarget:self action:@selector(networkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:networkBtn];
}



-(void)localBtnAction{
    // 显示本地图片
    [PhotoBrowser showLocalImages:@[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"] selectedIndex:3];
}


-(void)networkBtnAction{
    // 显示网络图片
    [PhotoBrowser showURLImages:@[@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ]
               placeholderImage:[UIImage imageNamed:@"zhanweitu"] selectedIndex:2];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
