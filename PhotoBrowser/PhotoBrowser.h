//
//  PhotoBrowser.h
//  PhotoBrowser
//
//  Created by LOLITA on 2017/8/31.
//  Copyright © 2017年 LOLITA0164. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowser : UIView

/**
 加载本地图片
 */
+(void)showLocalImages:(NSArray*)images;

/**
 加载网络图片
 */
+(void)showURLImages:(NSArray*)images placeholderImage:(UIImage *)image;

@end

@interface PhotoBrowserCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@property (strong ,nonatomic) UIScrollView *scrollView;
@end




