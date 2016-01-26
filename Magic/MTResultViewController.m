//
//  MTResultViewController.m
//  Magic
//
//  Created by Kohei Totani on 2016/01/25.
//  Copyright © 2016年 totta. All rights reserved.
//

#import "MTResultViewController.h"

@interface MTResultViewController ()

@end

@implementation MTResultViewController


- (void)viewWillLoad {
    _padding = 3;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRivals];
    self.navigationItem.title = @"とったー";

    int count = 4;
    float height = [MTResultView view].frame.size.height;

    CGSize scrollSize = self.view.frame.size;
    scrollSize.height = count * (height + _padding);
    _scrollView.contentSize = scrollSize;
}

- (void) setRivals {
    MTResultView *hoge = [MTResultView view];
    CGRect frame = hoge.frame;
    frame.origin = CGPointMake(0,0);
    hoge.frame = frame;
    [hoge setResult:@"osam38"
                   :10
                   :20
                   :33
                   :1
                   :@"2015"];
    
    MTResultView *hoge2 = [MTResultView view];
    hoge2.frame = [self optimallyPosition:hoge
                                         :hoge2];

    [hoge2 setResult:@"osam38"
                   :10
                   :20
                   :33
                   :4
                   :@"2015"];

    MTResultView *hoge3 = [MTResultView view];
    hoge3.frame = [self optimallyPosition:hoge2
                                         :hoge3];
    
    [hoge3 setResult:@"osam38"
                    :10
                    :20
                    :33
                    :5
                    :@"2015"];

    MTResultView *hoge4 = [MTResultView view];
    hoge4.frame = [self optimallyPosition:hoge3
                                         :hoge4];
    
    [hoge4 setResult:@"osam38"
                    :10
                    :20
                    :33
                    :2
                    :@"2015"];

    [_scrollView addSubview:hoge];
    [_scrollView addSubview:hoge2];
    [_scrollView addSubview:hoge3];
    [_scrollView addSubview:hoge4];

}
- (void) viewWillAppear:(BOOL)animated {
    [_winGraph setValue:80.f animateWithDuration:0];
    
}

- (CGRect) optimallyPosition:(UIView *) baseView
                          :(UIView *) setView {

    CGRect frame = setView.frame;
    frame.origin = CGPointMake(0, baseView.frame.origin.y + baseView.frame.size.height + _padding);
    return frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
