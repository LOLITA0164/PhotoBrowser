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
// !!!!: 长按事件
-(void)photoBrowser:(PhotoBrowser *)photoBrowser LongPress:(UILongPressGestureRecognizer*)longPress;

@end




@interface PhotoBrowser : UIView
@property (weak, nonatomic) id <PhotoBrowserDelegate> delegate;
@property (assign ,nonatomic, readonly) NSInteger currentPage;      // 当前页

/**
 加载本地图片，可以是 NSString/UIImage
 @note selectedView 可选参数：一般来说是一个imageView，关闭浏览器时会将这个视图移回原来的位置
 */
+(instancetype)showLocalImages:(NSArray<id>*)images selectedIndex:(NSInteger)index selectedView:(UIView *)selectedView;;

/**
 加载网络图片
 @note selectedView 可选参数：一般来说是一个imageView，关闭浏览器时会将这个视图移回原来的位置
 */
+(instancetype)showURLImages:(NSArray<NSString*>*)images placeholderImage:(UIImage *)image selectedIndex:(NSInteger)index  selectedView:(UIView *)selectedView;


/**
 主动隐藏
 */
-(void)hidden;

/**
 保存当前页面的图片
 */
-(void)saveImageFromCurrentPage;
/**
 识别当前图片中的二维码信息，主线程中，可能导致线程阻塞
 @return 识别结果
 */
-(NSString*)identifyQRCodeFromCurrentPage;
// 异步处理二维码，回调识别结果
-(void)identifyQRCodeFromCurrentPage:(void(^)(NSString*result))completion;
/**
 当前图片是否存在二维码
 */
-(BOOL)existQRCodeFromCurrentPage;





/******************** 一些额外功能 ********************/

/**
 保存网络图片
 @param urlString 网络图片地址
 */
-(void)saveImageWithURLString:(NSString*)urlString;
+(void)saveImageWithURLString:(NSString*)urlString;
/**
 识别网络图片中的二维码信息
 @param urlString 网络图片地址
 @return 识别结果
 */
+(NSString*)identifyQRCodeWithURLString:(NSString*)urlString;
// 异步处理二维码，回调识别结果
+(void)identifyQRCodeWithURLString:(NSString*)urlString completion:(void(^)(NSString*result))completion;
/**
 是否存在二维码
 */
+(BOOL)existQRCodeWithUrl:(NSString*)url;


@end





@interface PhotoBrowserCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@property (strong ,nonatomic) UIScrollView *scrollView;
@end




