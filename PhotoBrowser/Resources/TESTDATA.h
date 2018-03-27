//
//  TESTDATA.h
//  SuperScholar
//
//  Created by LOLITA on 18/3/20.
//  Copyright © 2018年 SuperScholar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TESTDATA : NSObject

+(NSString*)randomContent;                  // 随机一条内容

+(NSArray*)randomContents:(NSInteger)count; // 随机一组内容

+(NSString*)randomUrlString;                // 随机一张图片

+(NSArray*)randomUrls:(NSInteger)count;     // 随机一组图片

@end
