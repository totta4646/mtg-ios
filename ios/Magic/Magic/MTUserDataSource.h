//
//  MAUserTableViewControllerDataSource.h
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTUser.h"

@interface MTUserDataSource : NSObject

@property (nonatomic) NSArray       *userList;
@property (nonatomic) MTUser        *user1;
@property (nonatomic) MTUser        *user2;

-(BOOL) setUser:(NSArray *)data
               :(int)number;
-(void) makeGuestUserData;

@end
