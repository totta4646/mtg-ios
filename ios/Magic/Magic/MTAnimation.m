//
//  MTAnimation.m
//  Magic
//
//  Created by Gizumo-002 on 2015/10/22.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MTAnimation.h"
#import "MTPalletView.h"
#import "MTColorView.h"

@implementation MTAnimation
+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/**
 *  スタートアニメーション
 *
 *  @param color パレットとカラーボタンをまとめたクラス
 */
- (void) startPalletButtonAnimation:(MTPalletColorView *) color {

    UIButton *pallet = color.pallet.palletView;
    
    CGRect parent = [pallet superview].frame;
    CGRect palletFrame = pallet.frame;
    palletFrame.origin.x = (parent.size.width - palletFrame.size.width) / 2;
    palletFrame.origin.y = (parent.size.height - palletFrame.size.height) / 2;
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         pallet.frame = palletFrame;
                     }
                     completion:^(BOOL finished) {
                         for (MTColorView *button in [color getViews]) {
                             [self palletAnimation:button.colorView
                                         positionX:button.movePositionX
                                         positionY:button.movePositionY];
                         }
                     }
     ];
}
/**
 *  エンドアニメーション
 *
 *  @param color パレットとカラーボタンをまとめたクラス
 */

- (void) backPalletButtons:(MTPalletColorView *) color {
    
    UIButton *pallet = color.pallet.palletView;
    
    CGRect parent = [pallet superview].frame;
    CGRect originFrame = pallet.frame;
    originFrame.origin.x = (parent.size.width - originFrame.size.width) / 2;
    originFrame.origin.y = (parent.size.height - originFrame.size.height) / 2;
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         for (MTColorView *button in [color getViews]) {
                             button.colorView.frame = originFrame;
                             button.colorView.layer.opacity = 0;
                         }
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5f
                                          animations:^{
                                              pallet.frame = color.pallet.currentPosition;
                                          }];
                         pallet.enabled = YES;
                         
                     }];
}

/**
 *  カラーボタンのアニメーション
 *
 *  @param color カラーボタン
 *  @param x     座標x
 *  @param y     座標y
 */
- (void) palletAnimation:(UIButton *) color
               positionX: (float) x
               positionY: (float) y {
    
    color.layer.opacity = 0.1;

    [[MTLayoutView sharedInstance] colorPallet:color];
    
    CGRect position = CGRectMake(color.frame.origin.x + x,
                                 color.frame.origin.y + y,
                                 color.frame.size.width,
                                 color.frame.size.height);
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         color.frame = position;
                         color.layer.opacity = 1;
                     }];
}



@end
