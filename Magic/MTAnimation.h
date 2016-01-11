//
//  MTAnimation.h
//  Magic
//
//  Created by Gizumo-002 on 2015/10/22.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTPalletColorView.h"

@interface MTAnimation : NSObject
+ (instancetype) sharedInstance;
- (void) palletAnimation:(UIButton *) color
               positionX: (float) x
               positionY: (float) y;

- (void) startPalletButtonAnimation:(MTPalletColorView *) color;
- (void) backPalletButtons:(MTPalletColorView *) color;

@end
