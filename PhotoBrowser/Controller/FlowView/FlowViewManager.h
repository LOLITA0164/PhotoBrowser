//
//  FlowViewManager.h
//  PhotoBrowser
//
//  Created by 骆亮 on 2018/3/27.
//  Copyright © 2018年 LOLITA0164. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TESTDATA.h"
#import "AppMacro.h"

@class FlowViewModel;
@interface FlowViewManager : NSObject

// !!!: 获取数据
+(void)requestDataResponse:(void(^)(NSArray *resArray,id error))responseBlock;


@end



@interface FlowViewModel : NSObject
@property (copy ,nonatomic) NSString *picUrl;
@property (assign ,nonatomic) CGSize size;
@end


