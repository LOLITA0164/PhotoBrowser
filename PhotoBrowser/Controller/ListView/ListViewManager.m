//
//  ListViewManager.m
//  PhotoBrowser
//
//  Created by 骆亮 on 2018/3/27.
//  Copyright © 2018年 LOLITA0164. All rights reserved.
//

#import "ListViewManager.h"
#import <UIButton+WebCache.h>
#import "TESTDATA.h"

@implementation ListViewManager

// !!!: 获取数据
+(void)requestDataResponse:(void(^)(NSArray *resArray,id error))responseBlock{

    NSMutableArray *cells = [NSMutableArray array];
    NSInteger number = 10;
    for (int i=0; i<number; i++) {
        ListModel *csm = [ListModel new];
        NSMutableArray *pics = [NSMutableArray array];
        for (int j=0; j<getRandomNumberFromAtoB(1, 9); j++) {
            [pics addObject:[TESTDATA randomUrlString]];
        }
        csm.pics = pics;
        [self addPicsWithModel:csm];
        csm.cellHeight = csm.mediaView.frame.size.height;
        [cells addObject:csm];
    }
    if (responseBlock) {
        responseBlock(cells,nil);
    }
}


// !!!: 添加图片控件
+(void)addPicsWithModel:(ListModel*)csm{
    if (csm.pics.count==0) {
        return;
    }
    CGFloat space = 5;
    CGFloat width_total = AdaptedWidthValue(355);
    CGFloat width_item = (width_total-space*2)/3.0;
    NSMutableArray *btns = [NSMutableArray array];
    for (int i=0; i<csm.pics.count; i++) {
        NSString *urlString = csm.pics[i];
        NSInteger line = i%3;
        NSInteger row = i/3;
        CGPoint center = CGPointMake(width_item/2.0*(2*line+1)+space*line+5, width_item/2.0*(2*row+1)+space*row);
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width_item, width_item)];
        btn.center = center;
        [btn sd_setImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
        [btns addObject:btn];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.tag = i;
        [csm.mediaView addSubview:btn];
    }
    csm.picViews = btns;
    UIButton *lastBtn = btns.lastObject;
    csm.mediaView.frame = CGRectMake(10, 0, width_total, lastBtn.frame.size.height+lastBtn.frame.origin.y);
    csm.cellHeight = csm.mediaView.frame.size.height;
}

@end












@implementation ListModel

-(NSMutableArray *)picViews{
    if (_picViews==nil) {
        _picViews = [NSMutableArray array];
    }
    return _picViews;
}

-(UIView *)mediaView{
    if (_mediaView==nil) {
        _mediaView = [UIView new];
    }
    return _mediaView;
}

@end

