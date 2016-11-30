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
    
    _user = [_res objectForKey:@"user"];
    _users = [_res objectForKey:@"users"];
    
    [self setRivals:_users];
    self.navigationItem.title = [_user objectForKey:@"name"];

    int count = (int)[_users count];
    float height = [MTResultView view].frame.size.height;

    CGSize scrollSize = self.view.frame.size;
    scrollSize.height = count * (height + _padding);
    _scrollView.contentSize = scrollSize;
}

- (void) setRivals:(NSDictionary *) users {

    MTResultView *tempResultView = nil;
    for (NSDictionary *user in users) {
        NSDictionary *rivalUser = [user objectForKey:@"user"];
        NSDictionary *rivalResults = [user objectForKey:@"results"];

        MTResultView *resultView = [MTResultView view];
        CGRect frame = resultView.frame;
        frame.origin = CGPointMake(0,0);
        if (tempResultView) {
            resultView.frame = [self optimallyPosition:tempResultView
                                                 :resultView];
        } else {
            resultView.frame = frame;
        }
        
        [resultView setResult:[rivalUser objectForKey:@"name"]
                             :[[rivalResults objectForKey:@"win"] floatValue]
                             :[[rivalResults objectForKey:@"lose"] floatValue]
                             :[[rivalResults objectForKey:@"win_average"] floatValue] * 100
                             :[[rivalUser objectForKey:@"color"] intValue]
                             :nil];

        tempResultView = resultView;
        [_scrollView addSubview:resultView];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    float winAverage = [[_user objectForKey:@"win_average"] floatValue] * 100;
    UIColor *color = [self getColor:[[_user objectForKey:@"color"] intValue]];
//    _winGraph.fontColor = color;
//    _winGraph.progressStrokeColor = color;
//    _winGraph.progressColor = color;
    _allWinLabel.textColor = color;
    _allLoseLabel.textColor = color;
    _allWins.textColor = color;
    _allLoses.textColor = color;
    _allWins.text = [NSString stringWithFormat:@"%d回",[[_user objectForKey:@"wins"] intValue]];
    _allLoses.text = [NSString stringWithFormat:@"%d回",[[_user objectForKey:@"loses"] intValue]];
//    [_winGraph setValue:winAverage animateWithDuration:0];
    
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

- (UIColor *) getColor:(int) color {
    switch (color) {
        case 0:
            return COLOR;
            break;
        case 1:
            return COLOR1;
            break;
        case 2:
            return COLOR2;
            break;
        case 3:
            return COLOR3;
            break;
        case 4:
            return COLOR4;
            break;
            
        default:
            return COLOR;
            break;
    }
}

@end
