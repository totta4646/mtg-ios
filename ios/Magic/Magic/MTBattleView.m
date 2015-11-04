//
//  MTBattleView.m
//  Magic
//
//  Created by totta on 2015/10/23.
//  Copyright © 2015年 totta. All rights reserved.
//

#import "MTBattleView.h"

@implementation MTBattleView

+ (instancetype) view
{
    UINib *nib = [UINib nibWithNibName:@"MTBattleView" bundle:nil];
    MTBattleView *view = [nib instantiateWithOwner:self options:nil][0];
    return view;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) {

    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {

    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setLifeButtons];
    [self setColorPallets];
    [self setPoisonButtons];
    [self setPalletViews];
    
    
    
    _disappearFilter = YES;
}


#pragma mark setAction

- (void) setDices {
    
    [self setAlphaFilter:false];
    
    CGFloat size = 100;
    _dice = [[MTDiceView alloc] init];
    _dice.frame = CGRectMake((self.frame.size.width - size) / 2,
                             (self.frame.size.height - size * 2) / 2 ,
                             size,
                             self.frame.size.height);
    _dice.tag = 100;
    
    [self addSubview:_dice];
    
    [_dice.stop addTarget:self action:@selector(stopDice:)forControlEvents:UIControlEventTouchUpInside];
    
    [_dice setTimer];
    
}

- (void) removeDices {

    if ([_dice.timer isValid]) {
        [_dice.timer invalidate];
    }

    [self setAlphaFilter:false];
    [[self viewWithTag:100] removeFromSuperview];
    
    _dice = nil;
    
}

- (void) setColorPallets {
    [_colorPallet addTarget:self action:@selector(changePallet:)forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) setLifeButtons {
    [_up addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];
    [_up5 addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];
    [_down addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];
    [_down5 addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) setPoisonButtons {
    [_poisonButton addTarget:self action:@selector(changePoison:)forControlEvents:UIControlEventTouchUpInside];
}

- (void) setPalletViews {
    
    [_color addTarget:self action:@selector(changeColor:)forControlEvents:UIControlEventTouchUpInside];
    [_color1 addTarget:self action:@selector(changeColor:)forControlEvents:UIControlEventTouchUpInside];
    [_color2 addTarget:self action:@selector(changeColor:)forControlEvents:UIControlEventTouchUpInside];
    [_color3 addTarget:self action:@selector(changeColor:)forControlEvents:UIControlEventTouchUpInside];
    [_color4 addTarget:self action:@selector(changeColor:)forControlEvents:UIControlEventTouchUpInside];

    
    _palletViews = [[MTPalletColorView alloc] init];
    _palletViews.color.view = _color;
    _palletViews.color1.view = _color1;
    _palletViews.color2.view = _color2;
    _palletViews.color3.view = _color3;
    _palletViews.color4.view = _color4;
    
    _palletViews.pallet.currentPosition = _colorPallet.frame;
    _palletViews.pallet.view = _colorPallet;
    
}

#pragma mark private action
/**
 *  パレットのアニメーション管理メソッド
 *
 */
- (void) selectpallet {
    [[MTAnimation sharedInstance] startPalletButtonAnimation:_palletViews];
}

- (void) selectColor {
    [[MTAnimation sharedInstance] backPalletButtons:_palletViews];
}


#pragma mark delegate

- (void) changePallet:(UIButton *) sender {
    [self.delegate changeColor:sender];
}

- (void) changeLife:(UIButton *) sender {
    [self.delegate changeLife:sender];
    
}

- (void) changePoison:(UIButton *) sender {
    [self.delegate changePoison:sender];
}

- (void) changeColor:(UIButton *) sender {
    [self.delegate selectPalletColor:sender];
    
}

- (void) stopDice:(UIButton *) sender {
    [_dice.timer invalidate];
    _dice.shaking = false;
}


#pragma mark method
/*
 *  背景の色を変える
 *
 *  @param param 色
 */
- (void) selectColor:(int) param {
    UIColor *color = nil;
    if (param == 0) {
        color = COLOR;
    } else if (param == 1) {
        color = COLOR1;
    } else if (param == 2) {
        color = COLOR2;
    } else if (param == 3) {
        color = COLOR3;
    } else if (param == 4) {
        color = COLOR4;
    
    }
    
    self.backgroundColor = color;
    
}
/*
 *  フィルター表示非表示のメソッド
 *
 *  @param selected 選択されたかどうか
 */
- (void) setAlphaFilter:(BOOL) selected {
    int filterZindex = (int)[self.subviews indexOfObject:_filter];
    int palletZindex = (int)[self.subviews indexOfObject:_colorPallet];
    
    
    
    if (_disappearFilter) {
        _filter.alpha = 0.3;
        _disappearFilter = NO;

        if (!selected) {
            [self exchangeSubviewAtIndex:filterZindex withSubviewAtIndex:palletZindex];
            
        } else {
            [self selectpallet];

        }

        _selectedView = selected;

    } else  {
        _filter.alpha = 0;
        _disappearFilter = YES;

        if (!_selectedView){
            [self exchangeSubviewAtIndex:filterZindex withSubviewAtIndex:palletZindex];
            _selectedView = selected;
            
        }

    }
    
}
@end
