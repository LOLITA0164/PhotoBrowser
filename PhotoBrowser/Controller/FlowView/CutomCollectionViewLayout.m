//
//  CutomCollectionViewLayout.m
//  瀑布流
//
//  Created by yurong on 2017/8/15.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import "CutomCollectionViewLayout.h"
@interface CutomCollectionViewLayout ()
{
    NSMutableDictionary *maxDic;
    NSMutableArray *attributesArray;
}

@end
@implementation CutomCollectionViewLayout
-(void)prepareLayout{
    [super prepareLayout];
    attributesArray = [NSMutableArray array];
    for (int index = 0; index < [self.collectionView numberOfItemsInSection:0]; index++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [attributesArray addObject:attributes];
//        NSLog(@"%f %f %f %f",attributes.frame.origin.x,attributes.frame.origin.y,attributes.frame.size.width,attributes.frame.size.height);
    }
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    maxDic = [NSMutableDictionary dictionary];
    //第一列和第二列的起始高度都为0
    [maxDic setObject:@(0) forKey:@"maxO"];
    [maxDic setObject:@(0) forKey:@"maxS"];
    
    _clomnInst = 10;//列间距
    _contentInset = UIEdgeInsetsMake(10, 10, 10, 10);//边距
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return attributesArray;
}

-(CGSize)collectionViewContentSize{
    CGFloat width = 0;
    CGFloat height;
    //比较那一列比较Y大
    CGFloat maxO = [[maxDic objectForKey:@"maxO"]floatValue];
    CGFloat maxS = [[maxDic objectForKey:@"maxS"]floatValue];
    if (maxO>maxS) {
        height = maxO+_contentInset.bottom;
    }else{
        height = maxS+_contentInset.bottom;
    }
    return CGSizeMake(width, height);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat borderInsetX = _contentInset.left;
    CGFloat borderInsetY = _contentInset.top;
    CGSize itemsize = [self.delegate itemSizeForCollectionView:self.collectionView indexPath:indexPath];
    CGFloat width = itemsize.width;
    CGFloat height = itemsize.height;
    
    CGFloat left ;
    CGFloat top ;
    
    CGFloat maxO = [[maxDic objectForKey:@"maxO"]floatValue];
    CGFloat maxS = [[maxDic objectForKey:@"maxS"]floatValue];
    CGFloat maxY ;
    //比较
    if (maxO<maxS||maxO==maxS) {                        // 第一列
        //小于 等于
        maxY = maxO;
        left = borderInsetX;
        top = maxY + borderInsetY;
        [maxDic setObject:@(top+height) forKey:@"maxO"];    // 第二列
    }else{
        //大于
        maxY = maxS;
        left = borderInsetX+itemsize.width+_clomnInst;
        top = maxY + borderInsetY;
        [maxDic setObject:@(top+height) forKey:@"maxS"];
    }
    [maxDic setObject:@(maxY) forKey:@"maxY"];
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(left, top, width, height) ;//CGRectMake(left, top, width, height)
    return attributes;
}
@end
