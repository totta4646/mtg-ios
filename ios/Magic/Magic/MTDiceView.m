//
//  MTDiceView.m
//  Magic
//
//  Created by Gizumo-002 on 2015/11/04.
//  Copyright © 2015年 totta. All rights reserved.
//

#import "MTDiceView.h"

@implementation MTDiceView

- (id)init
{
    self = [super init];
    if (self) {

        _dice = [[UIButton alloc] init];
# pragma mark TODO:親要素を参照する場合は書き換え
        _dice.frame = CGRectMake(0, 0, 100, 100);
        _dice.backgroundColor = [UIColor hx_colorWithHexString:@"e9e9e9"];
        _dice.tag = 0;
        _dice.layer.cornerRadius = 10;
        
        _stop = [[UIButton alloc] init];
        _stop.frame = CGRectMake(-20, 130, 140, 40);
        _stop.backgroundColor = [UIColor hx_colorWithHexString:@"e9e9e9"];
        _stop.tag = 0;
        [_stop setTitle:@"STOP" forState:UIControlStateNormal];
        [_stop setTitleColor:[UIColor hx_colorWithHexString:@"797979"]
                    forState:UIControlStateNormal];
        
        _stop.titleLabel.font = [UIFont systemFontOfSize:30];
        _stop.layer.cornerRadius = 5;
    
        [self addSubview:_dice];
        [self addSubview:_stop];
        
        
        _shaking = YES;
    }


    return self;
}

#pragma mark method

- (void) setOne {
    
    NSMutableArray *views = [self makeViews:1];
    UIView *point = views[0];
    
    CGFloat size = _dice.frame.size.width;
    CGRect frame = CGRectMake(size / 2 - size / 6,
                              size / 2 - size / 6,
                              size / 3,
                              size / 3);
    
    point.frame = frame;

    [[MTLayoutView sharedInstance] makeCircle:point];
    
    [self addSubview:point];
    [self bringSubviewToFront:point];
}

- (void) setTwo {
    
    NSMutableArray *views = [self makeViews:2];
    CGFloat size = _dice.frame.size.width;
    CGFloat padding = size / 5;
    int sum = (int)[views count];
    
    for (int i = 0; i < sum; i++) {
        if (i) {
            padding = padding * -1;
        }

        UIView *point = views[i];
        CGRect frame = CGRectMake(size / 2 - size / 8 + padding,
                                  size / 2 - size / 8 - padding,
                                  size / 4,
                                  size / 4);
        
        point.frame = frame;
        [[MTLayoutView sharedInstance] makeCircle:point];
        
        [self addSubview:point];
        [self bringSubviewToFront:point];
        
    }
    
    
}

- (void) setThree {
    
    NSMutableArray *views = [self makeViews:3];
    CGFloat size = _dice.frame.size.width;
    
    int sum = (int)[views count];
    for (int i = 0; i < sum; i++) {
        CGFloat padding = size / 5;

        if (i == 0) {
            padding = padding * -1;
        } else if (i == 1) {
            padding = 0;
        } else {
            padding = padding;
        }
        
        UIView *point = views[i];
        CGRect frame = CGRectMake(size / 2 - size / 8 + padding,
                                  size / 2 - size / 8 - padding,
                                  size / 4,
                                  size / 4);
        
        point.frame = frame;
        [[MTLayoutView sharedInstance] makeCircle:point];
        
        [self addSubview:point];
        [self bringSubviewToFront:point];
        
    }
}

- (void) setFour {
    
    NSMutableArray *views = [self makeViews:4];
    CGFloat size = _dice.frame.size.width;
    
    int sum = (int)[views count];
    for (int i = 0; i < sum; i++) {
        CGFloat padding = size / 5;
        CGFloat adjust = 1;
        
        if (i % 2) {
            padding = padding * -1;
        }
        
        if (i / 2) {
            adjust = -1;
        }
        
        
        UIView *point = views[i];
        CGRect frame = CGRectMake(size / 2 - size / 8 + padding * adjust,
                                  size / 2 - size / 8 - padding,
                                  size / 4,
                                  size / 4);
        
        point.frame = frame;
        [[MTLayoutView sharedInstance] makeCircle:point];
        
        [self addSubview:point];
        [self bringSubviewToFront:point];
        
    }
    
    
}

- (void) setFive {
    
    NSMutableArray *views = [self makeViews:5];
    CGFloat size = _dice.frame.size.width;
    
    int sum = (int)[views count];
    for (int i = 0; i < sum; i++) {
        CGFloat padding = size / 5;
        CGFloat adjust = 1;
        
        if (i % 2) {
            padding = padding * -1;

        } else if (i == 4) {
            padding = 0;

        }
        if (i / 2) {
            adjust = -1;
        }
        
        
        UIView *point = views[i];
        CGRect frame = CGRectMake(size / 2 - size / 8 + padding * adjust,
                                  size / 2 - size / 8 - padding,
                                  size / 4,
                                  size / 4);
        
        point.frame = frame;
        [[MTLayoutView sharedInstance] makeCircle:point];
        
        [self addSubview:point];
        [self bringSubviewToFront:point];
        
    }
    
}

- (void) setSix {
    
    NSMutableArray *views = [self makeViews:6];
    CGFloat size = _dice.frame.size.width;
    
    int sum = (int)[views count];
    for (int i = 0; i < sum; i++) {
        CGFloat padding = size / 5;
        CGFloat adjust = 20;
        
        if (i % 3 == 0) {
            padding = padding * 1.3;

        } else if (i % 3 == 1) {
            padding = 0;
            
        } else {
            padding = padding * -1.3;
            
        }

        if (i / 3) {
            adjust = adjust * -1;
        }
        
        
        UIView *point = views[i];
        CGRect frame = CGRectMake(size / 2 - size / 8 - adjust,
                                  size / 2 - size / 8 - padding,
                                  size / 4,
                                  size / 4);
        
        point.frame = frame;
        [[MTLayoutView sharedInstance] makeCircle:point];
        
        [self addSubview:point];
        [self bringSubviewToFront:point];
        
    }
    
}
/**
 *  diceview内にaddviewしたviewを取り払う
 */
- (void) removeViews {
    for (UIView *view in [self subviews]) {
        if (view.tag) {
            [view removeFromSuperview];
            
        }
    }
}

- (void) setTimer {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                              target:self
                                            selector:@selector(resetDice)
                                            userInfo:nil
                                             repeats:YES];
}


#pragma mark private method

- (NSMutableArray *) makeViews:(int) sum {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < sum ; i++) {
        UIView *point = [[UIView alloc] init];
        point.backgroundColor = [UIColor hx_colorWithHexString:@"797979"];
        point.tag = i+1;
        
        [array addObject:point];
    }
    
    return array;
}

- (void) resetDice {
    int random = rand() % 6;
    
    [self removeViews];
    
    if (random == 0) {
        [self setOne];
        
    } else if (random == 1) {
        [self setTwo];
        
    } else if (random == 2) {
        [self setThree];
        
    } else if (random == 3) {
        [self setFour];
        
    } else if (random == 4) {
        [self setFive];
        
    } else if (random == 5) {
        [self setSix];
        
    }
}


@end
