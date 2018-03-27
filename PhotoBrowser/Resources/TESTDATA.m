//
//  TESTDATA.m
//  SuperScholar
//
//  Created by LOLITA on 18/3/20.
//  Copyright © 2018年 SuperScholar. All rights reserved.
//

// 获取随机数
#define getRandomNumberFromAtoB(A,B) (int)(A+(arc4random()%(B-A+1)))

#import "TESTDATA.h"

@implementation TESTDATA

+(NSString *)randomContent{
    NSDictionary *dic = [self localDataDictionary];
    NSInteger randomNum = getRandomNumberFromAtoB(0, 49);
    NSArray *contents = [dic objectForKey:@"contents"];
    return contents[randomNum];
}


+(NSArray *)randomContents:(NSInteger)count{
    NSMutableArray *res = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        [res addObject:[self randomContent]];
    }
    return res.copy;
}



+(NSString *)randomUrlString{
    NSDictionary *dic = [self localDataDictionary];
    NSInteger randomNum = getRandomNumberFromAtoB(0, 49);
    NSArray *pics = [dic objectForKey:@"pics"];
    return pics[randomNum];
}


+(NSArray *)randomUrls:(NSInteger)count{
    NSMutableArray *res = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        [res addObject:[self randomUrlString]];
    }
    return res.copy;
}


+(NSDictionary*)localDataDictionary{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testData" ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}


@end
