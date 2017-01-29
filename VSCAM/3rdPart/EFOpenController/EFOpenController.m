//
//  EFOpenController.m
//  EFOpenController
//
//  Created by EFOpenController on 14/11/25.
//  Copyright (c) 2014年 EFOpenController. All rights reserved.
//

#import "EFOpenController.h"

@interface EFOpenController ()<NSObject>
@end

@implementation EFOpenController {
    __weak UIPageControl* page;
}

#define JSON_COLOR(k) [UIColor colorWithRed:[k[0]intValue]/255.0 green:[k[1]intValue]/255.0 blue:[k[2]intValue]/255.0 alpha:[k[3]floatValue]]

- (id)init {
    if (self = [super init]) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:
                              [NSData dataWithContentsOfFile:
                               [[NSBundle mainBundle]pathForResource: @"EFOpenController" ofType: @"json"]]
                                                             options: 0 error: &error];
        CGRect rc = [UIScreen mainScreen].bounds;
        //处理设备方向问题
        if (rc.size.width > rc.size.height) {
            rc = CGRectMake(rc.origin.x, rc.origin.y, rc.size.height, rc.size.width);
        }
        //大背景
        self.view = [[UIView alloc]initWithFrame: rc];
        if (json[@"bgcolor"])
            self.view.backgroundColor = JSON_COLOR(json[@"bgcolor"]);
        //滚动条
        UIScrollView* scroll = [[UIScrollView alloc] initWithFrame: rc];
        scroll.pagingEnabled = YES;
        scroll.bounces = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.delegate = self;
        [self.view addSubview: scroll];

        //page
        if (!(json[@"pagectrl"] && ![json[@"pagectrl"] boolValue])) {
            UIPageControl* newPage = [[UIPageControl alloc]initWithFrame: CGRectMake(0, rc.size.height - 40, rc.size.width, 47)];
            newPage.hidesForSinglePage = YES;
            newPage.userInteractionEnabled = NO;
            [self.view addSubview: newPage];
            page = newPage;
            page.numberOfPages = [json[@"pages"] count];

            if (json[@"pagecolor"]) {
                page.currentPageIndicatorTintColor = JSON_COLOR(json[@"pagecolor"][0]);
                page.pageIndicatorTintColor = JSON_COLOR(json[@"pagecolor"][1]);
            }
        }

        CGFloat x = 0;
        for (NSDictionary* i in json[@"pages"]) {
            UIImage* data;
            /*if ((rc.size.width == 375 && rc.size.height == 667) ||
                (rc.size.width == 320 && rc.size.height == 568) )
                //iphone6 bug
                data = [UIImage imageNamed: [NSString stringWithFormat: @"%@b", i[@"image"]]];
            else*/
                data = [UIImage imageNamed: i[@"image"]];

            UIImageView* img = [[UIImageView alloc] initWithImage: data];
            img.contentMode = UIViewContentModeScaleAspectFit;
            if (i[@"bgcolor"])
                img.backgroundColor = JSON_COLOR(i[@"bgcolor"]);
            img.frame = CGRectOffset(rc, x, 0);
            [scroll addSubview: img];
            x += rc.size.width;
        }
        scroll.contentSize = CGSizeMake(x, rc.size.height);

        __weak NSDictionary* b = json[@"button"];
        UIButton* btn = [UIButton buttonWithType: UIButtonTypeSystem];
        btn.bounds = CGRectMake(0, 0, [b[@"size"][0] floatValue], [b[@"size"][1] floatValue]);
        CGFloat yoff = [b[@"yoff"] floatValue];
        if (yoff >= 1 || yoff == 0)
            btn.frame = CGRectOffset(btn.frame, x - rc.size.width / 2, rc.size.height / 2 + yoff);
        else if (yoff < 1 && yoff > 0)
            btn.frame = CGRectOffset(btn.frame, x - rc.size.width / 2, rc.size.height * yoff - btn.bounds.size.height / 2);
        else
            btn.frame = CGRectOffset(btn.frame, x - rc.size.width / 2, rc.size.height + yoff);
        if (b[@"color"])
            [btn setTitleColor: JSON_COLOR(b[@"color"]) forState: UIControlStateNormal];
        if (b[@"bgcolor"])
            btn.backgroundColor = JSON_COLOR(b[@"bgcolor"]);
        if (b[@"title"])
            [btn setTitle: b[@"title"] forState: UIControlStateNormal];
        if(b[@"round"])
            btn.layer.cornerRadius = [b[@"round"] floatValue];
        if (b[@"frame"]) {
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = JSON_COLOR(b[@"frame"]).CGColor;
        }

        [scroll addSubview: btn];
        [btn addTarget: self action: @selector(click:) forControlEvents: UIControlEventTouchUpInside];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIDevice currentDevice] setValue: [NSNumber numberWithInt: UIInterfaceOrientationPortrait] forKey: @"orientation"];
}

- (void)click: (id)sender {
    //判断内部进入则回到上一页
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated: YES];
        return;
    }

    //设置标志
    [[NSUserDefaults standardUserDefaults] setBool: YES forKey: @"VSCAM_FIRST_RUN"];

    __weak id weakSelf = self;
    __weak UIView *weakSrc = self.view;
    __weak id weakDest = _nextView;

    CGRect rc = [UIScreen mainScreen].bounds;
    CGPoint pot = [weakSrc center];

    [[weakSrc window] addSubview: _nextView];
    _nextView.center = CGPointMake(pot.x + rc.size.width, pot.y);

    [UIView animateWithDuration: 0.3 animations: ^{
        [weakDest setCenter: pot];
        [weakSrc setCenter: CGPointMake(pot.x - rc.size.width, pot.y)];
    } completion: ^(BOOL finished) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [weakSelf nextCtrl];
    }];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (BOOL)naviBarHidden {
    return YES;
}

- (void)scrollViewDidScroll: (UIScrollView *)scrollView {
    [page setCurrentPage: scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5];
}

//隐藏导航栏
- (void)hideNavigationController {
    
}

//只支持竖屏
- (BOOL)shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
