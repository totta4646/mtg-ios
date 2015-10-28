//
//  MAUser.m
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MTUser.h"

@implementation MTUser
 
# pragma mark action

- (id)init
{
    self = [super init];
    if (self) {
        _userID = -1;
        _win = 0;
        _color = 0;
    }
    
    return self;
}

/**
 *  体力を一つ増やす
 */
-(void) incriment {
    self.life++;
}

/**
 *  体力を一つ減らす
 */
-(void) decrement {
    self.life--;
}

/**
 *  毒カウンターを増やす
 */
-(void) poisonIncriment {
    self.poison++;
}

#pragma mark setter

/**
 *  ライフを20に戻す
 */
-(void) setLife {
    self.life = 20;
}
/**
 *  毒カウンターを初期化
 */

-(void) setPoison {
    self.poison = 0;
}

/**
 *  ゲストモードのダミーの値
 */
-(void) setGuest {
    _name = @"player";
    _userID = -10;
}


@end
