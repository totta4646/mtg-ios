//
//  MTResultView.m
//  Magic
//
//  Created by Kohei Totani on 2016/01/26.
//  Copyright © 2016年 totta. All rights reserved.
//

#import "MTResultView.h"

@implementation MTResultView

+ (instancetype) view
{
    UINib *nib = [UINib nibWithNibName:@"MTResultView" bundle:nil];
    MTResultView *view = [nib instantiateWithOwner:self options:nil][0];
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
}

- (void) setResult:(NSString *) name
                  :(int) win
                  :(int) lose
                  :(float) parcent
                  :(int) color
                  :(NSString *) date{
    
    
    _color = [self setUserColor:color];
    _rivalNameLabel.text = name;
    _resultLabel.text = [NSString stringWithFormat:@"勝ち : %d回　負け : %d回", win, lose];
    _lastUpdateLabel.text = date;
    [_resultGraph setValue:parcent animateWithDuration:1];

    [self updateUserColor];
}

- (UIColor *) setUserColor:(int) color {
    switch (color) {
        case 0:
            return COLOR;
            break;
        case 1:
            return COLOR1;
            break;
        case 2:
            return COLOR2;
            break;
        case 3:
            return COLOR3;
            break;
        case 4:
            return COLOR4;
            break;
            
        default:
            return COLOR;
            break;
    }
}

-(void) updateUserColor {
    
    _resultGraph.fontColor = _color;
    _resultGraph.progressStrokeColor = _color;
    _rivalNameLabel.textColor = _color;
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [_color CGColor];
}

@end
