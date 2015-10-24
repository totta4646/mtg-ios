//
//  MTAnimation.m
//  Magic
//
//  Created by Gizumo-002 on 2015/10/22.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MTAnimation.h"

@implementation MTAnimation
+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void) moveCenter:(UIButton *) pallet {
    CGRect parent = [pallet superview].frame;
    CGRect palletFrame = pallet.frame;
    palletFrame.origin.x = (parent.size.width - palletFrame.size.width) / 2;
    palletFrame.origin.y = (parent.size.height - palletFrame.size.height) / 2;
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         pallet.frame = palletFrame;
                     }];

}

- (void) palletAnimation:(UIButton *) color
               positionX: (float) x
               positionY: (float) y {
    
    [[MTLayoutView sharedInstance] colorPallet:color];
    
    CGRect position = CGRectMake(color.frame.origin.x + x,
                                 color.frame.origin.y + y,
                                 color.frame.size.width,
                                 color.frame.size.height);
    color.layer.opacity = 0.1;
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         color.frame = position;
                         color.layer.opacity = 1;
                     }];
}

@end
