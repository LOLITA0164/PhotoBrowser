//
//  ListViewController.m
//  PhotoBrowser
//
//  Created by 骆亮 on 2018/3/27.
//  Copyright © 2018年 LOLITA0164. All rights reserved.
//

#import "ListViewController.h"
#import "TESTDATA.h"
#import <UIButton+WebCache.h>
#import <objc/runtime.h>
#import "PhotoBrowser.h"
#import "ListViewManager.h"

#import "ListViewTableViewCell.h"

@interface ListViewController ()<UITabBarDelegate,UITableViewDelegate,PhotoBrowserDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (copy ,nonatomic) NSArray *data;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.table];
    self.table.separatorStyle = NO;
    self.table.tableFooterView = [UIView new];
    
    [ListViewManager requestDataResponse:^(NSArray *resArray, id error) {
        self.data = resArray;
        [self.table reloadData];
    }];
}

// !!!: 列表的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"LOLITA";
    ListViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[ListViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = NO;
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    for (UIView *itemView in cell.mediaView.subviews) {
        [itemView removeFromSuperview];
    }
    ListModel *csm = self.data[indexPath.section];
    for (UIButton *btn in csm.picViews) {
        [btn addTarget:self action:@selector(btnAcion:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(btn, @"images", csm, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [cell.mediaView addSubview:csm.mediaView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListModel *csm = self.data[indexPath.section];
    return csm.cellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    label.text = [NSString stringWithFormat:@"section%ld",section];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    return label;
}










// !!!: 图片点击事件
-(void)btnAcion:(UIButton*)btn{
    ListModel *csm = objc_getAssociatedObject(btn, @"images");
    PhotoBrowser *photoBroser = [PhotoBrowser showURLImages:csm.pics placeholderImage:[UIImage imageNamed:@"zhanweitu"] selectedIndex:btn.tag selectedView:btn];
    photoBroser.delegate = self;
    objc_setAssociatedObject(photoBroser, @"photoBrowser", csm, OBJC_ASSOCIATION_RETAIN);
    photoBroser.delegate = self;
}


// !!!: 浏览器代理
- (UIView *)photoBrowser:(PhotoBrowser *)photoBrowser didScrollToPage:(NSInteger)currentPage{
    ListModel *csm = objc_getAssociatedObject(photoBrowser, @"photoBrowser");
    if(csm){
        UIButton *btn = [csm.picViews objectAtIndex:currentPage];
        if(btn){
            return btn;
        }
    }
    return nil;
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
