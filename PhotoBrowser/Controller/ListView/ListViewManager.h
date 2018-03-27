//
//  ListViewManager.h
//  PhotoBrowser
//
//  Created by 骆亮 on 2018/3/27.
//  Copyright © 2018年 LOLITA0164. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppMacro.h"

@class ClassSpaceModel;
@interface ListViewManager : NSObject

+(void)requestDataResponse:(void(^)(NSArray *resArray,id error))responseBlock;

@end











@interface ListModel : NSObject

@property (copy ,nonatomic) NSArray *pics;
@property (strong ,nonatomic) UIView *mediaView;
@property (copy ,nonatomic) NSMutableArray *picViews;

@property (assign ,nonatomic) CGFloat cellHeight;

@end
