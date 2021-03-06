//
//  MTDiceView.h
//  Magic
//
//  Created by Gizumo-002 on 2015/11/04.
//  Copyright © 2015年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTDiceView : UIView

@property (nonatomic) UIButton                      *dice;
@property (nonatomic) UIButton                      *stop;

@property (nonatomic) NSTimer                       *timer;

@property (nonatomic) BOOL                          shaking;

- (void) removeViews;
- (void) setTimer;

@end
