//
//  NormalViewViewController.m
//  PhotoBrowser
//
//  Created by 骆亮 on 2018/3/27.
//  Copyright © 2018年 LOLITA0164. All rights reserved.
//

#import "NormalViewViewController.h"
#import "AppMacro.h"
#import "TESTDATA.h"
#import <UIButton+WebCache.h>
#import "PhotoBrowser.h"
#import "PhotoPickView.h"

@interface NormalViewViewController ()<PhotoBrowserDelegate>
@property (strong ,nonatomic) NSMutableArray *btns;
@property (strong ,nonatomic) NSArray *pics;
@end

@implementation NormalViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.btns = [NSMutableArray array];
    self.pics = [TESTDATA randomUrls:getRandomNumberFromAtoB(5, 15)];
    
    CGFloat space = 5;
    CGFloat width_total = AdaptedWidthValue(355);
    CGFloat width_item = (width_total-space*2)/3.0;
    for (int i=0; i<self.pics.count; i++) {
        NSString *urlString = self.pics[i];
        NSInteger line = i%3;
        NSInteger row = i/3;
        CGPoint center = CGPointMake(width_item/2.0*(2*line+1)+space*line + 10, width_item/2.0*(2*row+1)+space*row + 74);
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width_item, width_item)];
        btn.center = center;
        [btn sd_setImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
        [self.btns addObject:btn];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.tag = i;
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnAcion:) forControlEvents:UIControlEventTouchUpInside];
    }
}




// !!!: 图片点击事件
-(void)btnAcion:(UIButton*)btn{
    PhotoBrowser *photoBroser = [PhotoBrowser showURLImages:self.pics placeholderImage:[UIImage imageNamed:@"zhanweitu"] selectedIndex:btn.tag selectedView:btn];
    photoBroser.delegate = self;
}

// !!!: 浏览器代理
- (UIView *)photoBrowser:(PhotoBrowser *)photoBrowser didScrollToPage:(NSInteger)currentPage{
    return self.btns[currentPage];
}

// !!!!: 长按手势
-(void)photoBrowser:(PhotoBrowser *)photoBrowser LongPress:(UILongPressGestureRecognizer *)longPress{
    NSMutableArray* items = [NSMutableArray array];
    PhotoPickItem* item1 = [PhotoPickItem itemWithTitle:@"保存图片" picked:^{
        [photoBrowser saveImageFromCurrentPage];
    }];
    [items addObject:item1];
    if ([photoBrowser existQRCodeFromCurrentPage]) {
        PhotoPickItem* item2 = [PhotoPickItem itemWithTitle:@"识别二维码" picked:^{
            NSString* urlString = [photoBrowser identifyQRCodeFromCurrentPage];
            [[[UIAlertView alloc] initWithTitle:@"二维码"
                                        message:urlString
                                       delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil] show];
            [photoBrowser hidden];
            NSURL* url = [NSURL URLWithString:urlString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [items addObject:item2];
    }
    [PhotoPickView showOnView:photoBrowser Options:items];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
