//
//  CustomCollectionViewCell.m
//  瀑布流
//
//  Created by yurong on 2017/8/16.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageview = [[UIImageView alloc]init];
        _imageview.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageview];
        self.layer.cornerRadius = 2;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}


@end
