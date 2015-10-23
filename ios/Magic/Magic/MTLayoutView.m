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
    view.layer.borderWidth = 2.0f;
    view.layer.cornerRadius = 5.0f;
    
    return view;
}

- (UILabel *) deleteBalloon:(UILabel *) view {
    view.layer.borderColor = [[UIColor clearColor] CGColor];
    
    return view;
}


- (UIButton *) colorPallet:(UIButton *) view {
    view.layer.cornerRadius = 10.0f;
    
    return view;
}

@end
