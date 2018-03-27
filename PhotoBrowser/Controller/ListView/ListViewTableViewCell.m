//
//  ListViewTableViewCell.m
//  PhotoBrowser
//
//  Created by 骆亮 on 2018/3/27.
//  Copyright © 2018年 LOLITA0164. All rights reserved.
//

#import "ListViewTableViewCell.h"

@implementation ListViewTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.mediaView];
    }
    return self;
}


-(UIView *)mediaView{
    if (_mediaView==nil) {
        _mediaView = [[UIView alloc] initWithFrame:self.bounds];
    }
    return _mediaView;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.mediaView.frame = self.bounds;
}

@end
