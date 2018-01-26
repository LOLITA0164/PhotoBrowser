//
//  PhotoBrowser.m
//  PhotoBrowser
//
//  Created by LOLITA on 2017/8/31.
//  Copyright © 2017年 LOLITA0164. All rights reserved.
//

#import "PhotoBrowser.h"
#import <UIImageView+WebCache.h>

typedef NS_ENUM(NSInteger , ImagesType) {
    Image_Local,
    Image_URL
};

@interface PhotoBrowser ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
// !!!: 视图类
@property (strong ,nonatomic) UICollectionView *collectionView;
@property (strong ,nonatomic) UIView *bgView;   // 用来控制渐变而不改变父视图self
@property (strong ,nonatomic) UIPageControl *pageControl;
@property (strong ,nonatomic) UIButton *backBtn;
@property (strong ,nonatomic) UIButton *saveBtn;
@property (strong ,nonatomic) UIActivityIndicatorView *activityIndicator;
// !!!: 数据类
@property (copy ,nonatomic) NSArray *images;
@property (assign ,nonatomic) ImagesType type;
@property (strong ,nonatomic) UIImage *placeholderImage;
@end
@implementation PhotoBrowser

+(void)showImages:(NSArray*)images imageTyep:(ImagesType)type placeholderImage:(UIImage *)image selectedIndex:(NSInteger)index{
    PhotoBrowser *photoBrowser = [[PhotoBrowser alloc] initWithFrame:[UIScreen mainScreen].bounds];
    photoBrowser.images = images;
    photoBrowser.type = type;
    photoBrowser.placeholderImage = image;
    // 添加视图
    [photoBrowser addSubview:photoBrowser.bgView];
    [photoBrowser addSubview:photoBrowser.collectionView];
    if (images.count>1) {
        [photoBrowser addSubview:photoBrowser.pageControl];
    }
    [photoBrowser addSubview:photoBrowser.backBtn];
    if (type==Image_URL) {
        [photoBrowser addSubview:photoBrowser.saveBtn];
        [photoBrowser addSubview:photoBrowser.activityIndicator];
    }
    
    // 添加到keyWindow上
    UIWindow *keyWindow = [[UIApplication sharedApplication].delegate window];
    [keyWindow addSubview:photoBrowser];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.25f;  // 动画之行时间
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    // 将动画添加到layer上
    [photoBrowser.layer addAnimation:animation forKey:@"animation"];
    
    // 设置位置
    [photoBrowser.collectionView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width*index, 0) animated:NO];
    photoBrowser.pageControl.currentPage = index;
}


+(void)showLocalImages:(NSArray *)images selectedIndex:(NSInteger)index{
    [self showImages:images imageTyep:Image_Local placeholderImage:nil selectedIndex:index];
}

+(void)showURLImages:(NSArray *)images placeholderImage:(UIImage *)image selectedIndex:(NSInteger)index{
    [self showImages:images imageTyep:Image_URL placeholderImage:image selectedIndex:index];
}

#pragma mark - <************************** 初始化控件 **************************>
// !!!: collectionView
-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[PhotoBrowserCollectionViewCell class] forCellWithReuseIdentifier:@"LOLITA"];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        pan.delegate = self;
        [_collectionView addGestureRecognizer:pan];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_collectionView addGestureRecognizer:tap];
    }
    return _collectionView;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
    }
    return _bgView;
}
// !!!: 页码视图
-(UIPageControl *)pageControl{
    if (_pageControl==nil) {
        _pageControl=[[UIPageControl alloc]init];
        //注意此方法可以根据页数返回UIPageControl合适的大小
        CGSize size= [_pageControl sizeForNumberOfPages:self.images.count];
        _pageControl.bounds=CGRectMake(0, 0, size.width, size.height);
        _pageControl.center=CGPointMake(self.frame.size.width/2.0, self.frame.size.height-_pageControl.bounds.size.height/2.0);
        //设置颜色
        _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
        //设置当前页颜色
        _pageControl.currentPageIndicatorTintColor=[UIColor cyanColor];
        _pageControl.numberOfPages=self.images.count;
        _pageControl.userInteractionEnabled=NO;
    }
    return _pageControl;
}
// !!!: 返回按钮
-(UIButton *)backBtn{
    if (_backBtn==nil) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 40, 30)];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.tag = 1;
    }
    return _backBtn;
}
// !!!: 保存按钮
-(UIButton *)saveBtn{
    if (_saveBtn==nil) {
        _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-40-10, 25, 40, 30)];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.tag = 2;
    }
    return _saveBtn;
}
// !!!: 活动指示器
-(UIActivityIndicatorView *)activityIndicator{
    if (_activityIndicator==nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:self.saveBtn.frame];
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    }
    return _activityIndicator;
}

#pragma mark - <************************** 代理方法 **************************>
//每组中item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}
//cell的创建和数据的提供
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoBrowserCollectionViewCell *cell = (PhotoBrowserCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"LOLITA" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    switch (self.type) {
        case Image_Local:
        {
            cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row]];
        }
            break;
        case Image_URL:
        {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.images[indexPath.row]] placeholderImage:self.placeholderImage];
        }
            break;
            
        default:
            break;
    }
    cell.scrollView.zoomScale = 1;
    return cell;
}
//设置每个item的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scroll{
    NSInteger pageIndex = scroll.contentOffset.x/self.frame.size.width;
    self.pageControl.currentPage = pageIndex;
}

// !!!: 手势代理
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}


#pragma mark - <************************** 其他方法 **************************>
// !!!: 按钮操作
-(void)btnAction:(UIButton*)btn{
    if (btn.tag==1) {   // 回退
        [self goBackAction];
    }else if (btn.tag==2){  // 保存图片
        [self savBtnAction];
    }
}

-(void)goBackAction{
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)savBtnAction{
    [self.activityIndicator startAnimating];
    self.saveBtn.alpha = 0;
    UIImage *currentImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.images[self.pageControl.currentPage]]]];
    UIImageWriteToSavedPhotosAlbum(currentImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败";
    }else{
        msg = @"保存图片成功";
    }
    [self.activityIndicator stopAnimating];
    self.saveBtn.alpha = 1;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
// !!!: 手势处理
- (void)handleSwipe:(UIPanGestureRecognizer *)swipe{
    NSArray *cellArray =  self.collectionView.visibleCells;
    PhotoBrowserCollectionViewCell *cell = cellArray.firstObject;
    if (cell.scrollView.zoomScale>1||self.collectionView.isDragging) { // 如果已经是放大操作了，或者正在拖拽，则不响应手势
        return;
    }

    CGFloat hideHeight = 150.0; // 设置消失的最大滑动距离
    if (swipe.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [swipe translationInView:self.collectionView];
        CGFloat absX = fabs(translation.x);
        CGFloat absY = fabs(translation.y);
        // 设置滑动有效距离
        if (absX > absY ) { // 左右滑动
            return;
        } else if (absY > absX ) {  // 上下滑动
            // 此时需要禁掉collectionView的滚动能力
            self.collectionView.scrollEnabled = NO;
            self.bgView.alpha = (hideHeight*3 - absY)/ (hideHeight*3);
            self.backBtn.alpha = self.bgView.alpha;
            self.saveBtn.alpha = self.bgView.alpha;
            CGRect newFrame = self.collectionView.frame;
            newFrame.origin.y = translation.y;
            self.collectionView.frame = newFrame;
        }
    }
    else if (swipe.state == UIGestureRecognizerStateEnded){
        // 当手势结束，重新开启collectionView的滚动能力
        self.collectionView.scrollEnabled = YES;
        // 如果超过了最大滑动距离
        if (fabs(self.collectionView.frame.origin.y)>hideHeight) {
            [UIView animateWithDuration:0.5 animations:^{
                self.alpha = 0;
                if (self.collectionView.frame.origin.y<0) {
                    CGRect newFrame = self.collectionView.frame;
                    newFrame.origin.y = self.collectionView.frame.origin.y - self.frame.size.height;
                    self.collectionView.frame = newFrame;
                }else{
                    CGRect newFrame = self.collectionView.frame;
                    newFrame.origin.y = self.collectionView.frame.origin.y + self.frame.size.height;
                    self.collectionView.frame = newFrame;
                }
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }else{  // 重新回复到最初位置
            [UIView animateWithDuration:0.25 animations:^{
                CGRect newFrame = self.collectionView.frame;
                newFrame.origin.y = 0;
                self.collectionView.frame = newFrame;
                self.bgView.alpha = 1;
                self.backBtn.alpha = self.bgView.alpha;
                self.saveBtn.alpha = self.bgView.alpha;
            }];
        }
    }
}

-(void)handleTap:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect newFrame = self.collectionView.frame;
        newFrame.origin.y = self.collectionView.frame.origin.y + self.frame.size.height;
        self.collectionView.frame = newFrame;
        self.bgView.alpha = 0;
        self.collectionView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end





#pragma mark - <************************** collectionViewCell **************************>
@interface PhotoBrowserCollectionViewCell ()<UIScrollViewDelegate>
@end
@implementation PhotoBrowserCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}

-(UIImageView *)imageView{
    if (_imageView==nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

// !!!: scrollView
-(UIScrollView *)scrollView{
    if (_scrollView==nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.bounds;
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [_scrollView addSubview:self.imageView];
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}
// !!!: UIScrollView的代理
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}


//控制缩放时在中心
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
}

@end







