//
//  MAUser.h
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTUser : NSObject

@property int      userID;
@property int      life;
@property NSString *name;

-(void) incriment;
-(void) decrementLite;
-(void) resetLife;

@end
