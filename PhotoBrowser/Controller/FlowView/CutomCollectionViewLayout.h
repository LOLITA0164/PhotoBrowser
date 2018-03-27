//
//  CutomCollectionViewLayout.h
//  瀑布流
//
//  Created by yurong on 2017/8/15.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CutomCollectionViewLayoutDelegate <NSObject>

-(CGSize )itemSizeForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end

@interface CutomCollectionViewLayout : UICollectionViewLayout
@property(nonatomic,copy)NSMutableDictionary *maxYDic;
@property(nonatomic,assign)CGFloat clomnInst;//列间距
@property(nonatomic,assign)UIEdgeInsets contentInset;
@property(nonatomic,weak)id<CutomCollectionViewLayoutDelegate>delegate;
@end
