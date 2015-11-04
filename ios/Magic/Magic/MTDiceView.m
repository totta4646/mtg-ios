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
        _dice.backgroundColor = [UIColor redColor];
        _dice.tag = -1;
        _dice.layer.cornerRadius = 10;
        
        [self addSubview:_dice];
        
    }


    return self;
}

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

- (NSMutableArray *) makeViews:(int) sum {

    NSMutableArray *array = [[NSMutableArray alloc] init];

    for (int i = 0; i < sum ; i++) {
        UIView *point = [[UIView alloc] init];
        point.backgroundColor = [UIColor blackColor];
        point.tag = i+1;
        
        [array addObject:point];
    }
    
    return array;
}



@end
