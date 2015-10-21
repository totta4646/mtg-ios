//
//  MTLayoutView.m
//  Magic
//
//  Created by Gizumo-002 on 2015/10/21.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MTLayoutView.h"

@implementation MTLayoutView

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (UILabel *) makeBalloon:(UILabel *) view {
    view.layer.borderColor = [[UIColor grayColor] CGColor];
    view.layer.borderWidth = 1.0f;
    view.layer.cornerRadius = 5.0f;
    
    return view;
}

@end
