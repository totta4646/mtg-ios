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

}


#pragma mark setAction

- (void) setColorPallets {
    [_colorPallet addTarget:self action:@selector(selectColor:)forControlEvents:UIControlEventTouchUpInside];
    
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
- (void) selectColor:(id) sender {
    [[MTAnimation sharedInstance] moveCenter:sender];
    
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

//- (void) selectColor:(UIButton *) sender {
//    [self.delegate changeColor:sender];
//}

- (void) changeLife:(UIButton *) sender {
    [self.delegate changeLife:sender];
    
}

- (void) changePoison:(UIButton *) sender {
    [self.delegate changePoison:sender];
    
}

@end
