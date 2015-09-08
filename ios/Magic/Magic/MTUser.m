//
//  MAUser.m
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MTUser.h"

@implementation MTUser

# pragma mark private action

/**
 *  体力を一つ増やす
 */
-(void) incriment {
    self.life++;
}

/**
 *  体力を一つ減らす
 */
-(void) decrementLite {
    self.life--;
}
/**
 *  ライフを20に戻す
 */

-(void) resetLife {
    self.life = 20;
}

@end
