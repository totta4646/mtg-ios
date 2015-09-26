//
//  MAUser.h
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTUser : NSObject

@property (nonatomic) int      userID;
@property (nonatomic) int      life;
@property (nonatomic) int      win;

@property (nonatomic) NSString *name;

-(void) incriment;
-(void) decrement;
-(void) setLife;
-(void) setGuest;

@end
