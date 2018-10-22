//
//  FlowViewViewController.m
//  PhotoBrowser
//
//  Created by 骆亮 on 2018/3/27.
//  Copyright © 2018年 LOLITA0164. All rights reserved.
//

#import "FlowViewViewController.h"
#import "CustomCollectionViewCell.h"
#import "PhotoBrowser.h"
#import "PhotoPickView.h"
#import "CutomCollectionViewLayout.h"
#import "FlowViewManager.h"
#import <UIImageView+WebCache.h>

@interface FlowViewViewController ()<CutomCollectionViewLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,PhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet CutomCollectionViewLayout *layout;
@property (copy ,nonatomic) NSArray *data;
@end

@implementation FlowViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [FlowViewManager requestDataResponse:^(NSArray *resArray, id error) {
        self.data = resArray;
        [self.collectionView reloadData];
    }];
    
    
    self.layout.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
    [self.view addSubview:self.collectionView];

}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionViewCell" forIndexPath:indexPath];
    FlowViewModel *cem = self.data[indexPath.item];
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:cem.picUrl] placeholderImage:[UIImage imageNamed:@"zhanweifu"]];
    cell.imageview.frame = cell.bounds;
    return cell;
}
-(CGSize)itemSizeForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    FlowViewModel *fvm = self.data[indexPath.item];
    CGFloat width = self.view.frame.size.width;
    CGFloat realItemWidth = (width-10*2-10)/2;
    return CGSizeMake(realItemWidth,fvm.size.height/fvm.size.width*realItemWidth);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray* images = [NSMutableArray array];
    for (FlowViewModel *model in self.data) {
        [images addObject:model.picUrl];
    }
    CustomCollectionViewCell *cell = (CustomCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    PhotoBrowser *photoBrower = [PhotoBrowser showURLImages:images placeholderImage:[UIImage imageNamed:@"zhanweifu"] selectedIndex:indexPath.row selectedView:cell];
    photoBrower.delegate = self;
}



// !!!: 图片浏览器代理
-(void)photoBrowser:(PhotoBrowser *)photoBrowser didScrollToPage:(NSInteger)currentPage completion:(void (^)(UIView *))completion{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentPage inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CustomCollectionViewCell *cell = (CustomCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
        completion(cell);
    });
}

// !!!!: 长按手势
-(void)photoBrowser:(PhotoBrowser *)photoBrowser LongPress:(UILongPressGestureRecognizer *)longPress{
    PhotoPickItem* item1 = [PhotoPickItem itemWithTitle:@"操作1" picked:^{
        
    }];
    PhotoPickItem* item2 = [PhotoPickItem itemWithTitle:@"操作2" picked:^{
        
    }];
    PhotoPickItem* item3 = [PhotoPickItem itemWithTitle:@"操作3" picked:^{
        
    }];
    [PhotoPickView showOnView:photoBrowser Options:@[item1,item2,item3]];
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
