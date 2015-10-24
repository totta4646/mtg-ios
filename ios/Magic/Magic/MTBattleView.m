//
//  MTBattleView.m
//  Magic
//
//  Created by totta on 2015/10/23.
//  Copyright © 2015年 totta. All rights reserved.
//

#import "MTBattleView.h"

@implementation MTBattleView

- (void)_init
{

}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        [self _init];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        [self _init];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [_colorPallet addTarget:self action:@selector(aaa:)forControlEvents:UIControlEventTouchUpInside];
    
}

+ (instancetype) view
{
    UINib *nib = [UINib nibWithNibName:@"MTBattleView" bundle:nil];
    MTBattleView *view = [nib instantiateWithOwner:self options:nil][0];
    return view;
}

- (void) aaa:(UIButton *) sender {
    [self.delegate hoge];
}

@end
