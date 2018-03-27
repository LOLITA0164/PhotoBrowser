//
//  PhotoBrowser.h
//  PhotoBrowser
//
//  Created by LOLITA on 2017/8/31.
//  Copyright © 2017年 LOLITA0164. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoBrowser;

@protocol PhotoBrowserDelegate <NSObject>

@optional
/**
 @param photoBrowser 图片浏览器
 @param currentPage 当前图片下标
 */

// !!!: 主线程
-(UIView *)photoBrowser:(PhotoBrowser *)photoBrowser didScrollToPage:(NSInteger)currentPage;
// !!!: 配合视图滚动使用
-(void)photoBrowser:(PhotoBrowser *)photoBrowser didScrollToPage:(NSInteger)currentPage completion:(void(^)(UIView *))completion;

// !!!: 结束显示
-(void)photoBrowser:(PhotoBrowser *)photoBrowser didHidden:(NSInteger)currentPage;

@end




@interface PhotoBrowser : UIView

@property (weak, nonatomic) id <PhotoBrowserDelegate> delegate;

/**
 加载本地图片
 
 @note selectedView 可选参数：一般来说是一个imageView，关闭浏览器时会将这个视图移回原来的位置
 */
+(instancetype)showLocalImages:(NSArray*)images selectedIndex:(NSInteger)index selectedView:(UIView *)selectedView;;

/**
 加载网络图片
 
 @note selectedView 可选参数：一般来说是一个imageView，关闭浏览器时会将这个视图移回原来的位置
 */
+(instancetype)showURLImages:(NSArray*)images placeholderImage:(UIImage *)image selectedIndex:(NSInteger)index  selectedView:(UIView *)selectedView;

@end





@interface PhotoBrowserCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@property (strong ,nonatomic) UIScrollView *scrollView;
@end




