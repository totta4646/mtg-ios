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
    
    _filter.backgroundColor = [UIColor redColor];

    _disappearFilter = YES;

}


#pragma mark setAction

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

#pragma mark provate action
/**
 *  パレットボタン
 *
 *  @param sender 押されたボタンの情報
 */
- (void) selectpallet {
    [[MTAnimation sharedInstance] moveCenter:_colorPallet];
    
    [[MTAnimation sharedInstance] palletAnimation:_color1
                                        positionX:-60
                                        positionY:-30];
    
    [[MTAnimation sharedInstance] palletAnimation:_color2
                                        positionX:-45
                                        positionY:45];
    
    [[MTAnimation sharedInstance] palletAnimation:_color3
                                        positionX:45
                                        positionY:45];
    
    [[MTAnimation sharedInstance] palletAnimation:_color4
                                        positionX:60
                                        positionY:-30];
    
    [[MTAnimation sharedInstance] palletAnimation:_color5
                                        positionX:0
                                        positionY:-90];
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

#pragma mark method

- (void) selectColor:(int) param {
    UIColor *color = nil;
    if (param == 0) {
        color = [UIColor hx_colorWithHexString:@"4D4B57"];
    } else if (param == 1) {
        color = [UIColor hx_colorWithHexString:@"ED584B"];
    } else if (param == 2) {
        color = [UIColor hx_colorWithHexString:@"45D16E"];
    } else if (param == 3) {
        color = [UIColor hx_colorWithHexString:@"F0D529"];
    } else if (param == 4) {
        color = [UIColor hx_colorWithHexString:@"4197F5"];
    
    }
    
    self.backgroundColor = color;
    
}

- (BOOL) setAlphaFilter:(BOOL) selected {
    int filterZindex = (int)[self.subviews indexOfObject:_filter];
    int palletZindex = (int)[self.subviews indexOfObject:_colorPallet];

    if (selected == YES && _selectedView == YES) {
        return false;
    }
    
    
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
            _selectedView = !selected;
            
        }

    }
    
    return true;
}
@end
