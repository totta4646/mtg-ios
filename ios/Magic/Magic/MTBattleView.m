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

- (void) setColorPallets {
    [_colorPallet addTarget:self action:@selector(palletAction:)forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) setLifeButtons {
    [_up addTarget:self action:@selector(lifeAction:)forControlEvents:UIControlEventTouchUpInside];
    [_up5 addTarget:self action:@selector(lifeAction:)forControlEvents:UIControlEventTouchUpInside];
    [_down addTarget:self action:@selector(lifeAction:)forControlEvents:UIControlEventTouchUpInside];
    [_down5 addTarget:self action:@selector(lifeAction:)forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) setPoisonButtons {
    [_poisonButton addTarget:self action:@selector(poisonAction:)forControlEvents:UIControlEventTouchUpInside];
}

- (void) setPalletViews {
    
    [_color addTarget:self action:@selector(colorAction:)forControlEvents:UIControlEventTouchUpInside];
    [_color1 addTarget:self action:@selector(colorAction:)forControlEvents:UIControlEventTouchUpInside];
    [_color2 addTarget:self action:@selector(colorAction:)forControlEvents:UIControlEventTouchUpInside];
    [_color3 addTarget:self action:@selector(colorAction:)forControlEvents:UIControlEventTouchUpInside];
    [_color4 addTarget:self action:@selector(colorAction:)forControlEvents:UIControlEventTouchUpInside];

    _colorPallet.adjustsImageWhenDisabled = NO;
    
    _palletViews = [[MTPalletColorView alloc] init];
    _palletViews.color.colorView = _color;
    _palletViews.color1.colorView = _color1;
    _palletViews.color2.colorView = _color2;
    _palletViews.color3.colorView = _color3;
    _palletViews.color4.colorView = _color4;
    
    _palletViews.pallet.currentPosition = _colorPallet.frame;
    _palletViews.pallet.palletView = _colorPallet;
    
    
}

#pragma mark private action

- (void) selectpallet {
    [[MTAnimation sharedInstance] startPalletButtonAnimation:_palletViews];
}

- (void) selectColor {
    [[MTAnimation sharedInstance] backPalletButtons:_palletViews];
    
}


#pragma mark delegate

- (void) palletAction:(UIButton *) sender {
    [self.delegate selectPallet:sender];
}

- (void) lifeAction:(UIButton *) sender {
    [self.delegate changeLife:sender];
    
}

- (void) poisonAction:(UIButton *) sender {
    [self.delegate addPoison:sender];
}

-(void) colorAction:(UIButton *) sender {
    [self.delegate selectColor:sender];
    
}


#pragma mark public method
/*
 *  背景の色を変える
 *
 *  @param param 色
 */
- (void) changeColor:(int) param {
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
            _colorPallet.enabled = NO;

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
