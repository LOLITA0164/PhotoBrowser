//
//  AppMacro.h
//  SuperScholar
//
//  Created by 骆亮 on 2018/3/7.
//  Copyright © 2018年 SuperScholar. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#define kScreenWidth ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define kScreenWidthRatio (kScreenWidth/375.0)
#define AdaptedWidthValue(x) ((x)*kScreenWidthRatio)
#define getRandomNumberFromAtoB(A,B) (int)(A+(arc4random()%(B-A+1)))

#endif /* AppMacro_h */
