//
//  EFOpenController.h
//  EFOpenController
//
//  Created by EFOpenController on 14/11/25.
//  Copyright (c) 2014年 EFOpenController. All rights reserved.
//

#import <UIKit/UIKit.h>

// pages [{"image":name,"bgcolor":[r,g,b,a]}] 图片名和背景色
// bgcolor [r,g,b,a] 背景色
// pagectrl false 隐藏page控件
// pagecolor [[r,g,b,a],[r,g,b,a]] page当前色，和普通色
// button
//    size [w,h] 尺寸
//    yoff >=1:y中部向下偏移 0<<1:按钮占h百分比 <0 y底部向上偏移
//    color [r,g,b,a] 文字颜色
//    bgcolor [r,g,b,a] 背景颜色
//    title text 按钮标题
//    round flaot 圆角半径
//    frame [r,g,b,a] 外框颜色

@interface EFOpenController : UIViewController<UIScrollViewDelegate>

@property(strong,nonatomic) UIViewController* nextCtrl;
@property(weak,nonatomic) UIView* nextView;

@end
