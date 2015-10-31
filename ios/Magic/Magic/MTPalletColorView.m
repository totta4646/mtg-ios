//
//  MTPalletColorView.m
//  Magic
//
//  Created by totta on 2015/10/29.
//  Copyright © 2015年 totta. All rights reserved.
//

#import "MTPalletColorView.h"

@implementation MTPalletColorView
+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _color = [[MTColorView alloc] init];
        _color1 = [[MTColorView alloc] init];
        _color2 = [[MTColorView alloc] init];
        _color3 = [[MTColorView alloc] init];
        _color4 = [[MTColorView alloc] init];

        _pallet = [[MTPalletView alloc] init];
        
        [self setLayoutFrames];
    }
    
    return self;
}


- (void) setLayoutFrames {
    _color.movePositionX = 0;
    _color.movePositionY = -90;
    
    _color1.movePositionX = 60;
    _color1.movePositionY = -30;

    _color2.movePositionX = 45;
    _color2.movePositionY = 45;

    _color3.movePositionX = -45;
    _color3.movePositionY = 45;

    _color4.movePositionX = -60;
    _color4.movePositionY = -30;

}

- (NSMutableArray *) getViews {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:_color];
    [array addObject:_color1];
    [array addObject:_color2];
    [array addObject:_color3];
    [array addObject:_color4];
    
    return array;
}
@end
