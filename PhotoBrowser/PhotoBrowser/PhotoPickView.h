//
//  PhotoPickView.h
//  PhotoBrowser
//
//  Created by 骆亮 on 2018/10/22.
//  Copyright © 2018年 LOLITA0164. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoPickItem;
@interface PhotoPickView : UIView
+(void)showOnView:(UIView*)baseView Options:(NSArray<PhotoPickItem*>*)ops;
@end









#pragma mark - <************************** 选项 **************************>
typedef void(^pickBlock)();
@interface PhotoPickItem : NSObject
@property (strong ,nonatomic) NSString *title;
@property (nonatomic,copy) pickBlock picked;
+(PhotoPickItem*)itemWithTitle:(NSString*)title picked:(pickBlock)picked;
@end










