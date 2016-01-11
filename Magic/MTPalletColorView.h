//
//  MTPalletColorView.h
//  Magic
//
//  Created by totta on 2015/10/29.
//  Copyright © 2015年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTColorView.h"
#import "MTPalletView.h"

@interface MTPalletColorView : UIView

@property MTColorView *color;
@property MTColorView *color1;
@property MTColorView *color2;
@property MTColorView *color3;
@property MTColorView *color4;

@property MTPalletView *pallet;

+ (instancetype) sharedInstance;
- (NSMutableArray *) getViews;

@end
