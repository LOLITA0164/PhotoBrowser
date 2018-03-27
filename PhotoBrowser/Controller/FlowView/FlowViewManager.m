//
//  FlowViewManager.m
//  PhotoBrowser
//
//  Created by 骆亮 on 2018/3/27.
//  Copyright © 2018年 LOLITA0164. All rights reserved.
//

#import "FlowViewManager.h"

@implementation FlowViewManager

+(void)requestDataResponse:(void(^)(NSArray *resArray,id error))responseBlock{
    NSMutableArray *res = [NSMutableArray array];
    for (int i=0; i<100; i++) {
        FlowViewModel *fvm = [FlowViewModel new];
        fvm.picUrl = [TESTDATA randomUrlString];
        CGFloat width = getRandomNumberFromAtoB(100, 150);
        CGFloat height = getRandomNumberFromAtoB(50, 200);
        fvm.size = CGSizeMake(width, height);
        [res addObject:fvm];
    }
    if (responseBlock) {
        responseBlock(res,nil);
    }
}

@end




@implementation FlowViewModel


@end
