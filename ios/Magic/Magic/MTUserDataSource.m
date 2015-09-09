//
//  MAUserTableViewControllerDataSource.m
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MTUserDataSource.h"

@implementation MTUserDataSource

# pragma mark private method

- (id)init
{
    self = [super init];
    if (self) {
        _user1 = [[MTUser alloc] init];
        _user2 = [[MTUser alloc] init];
    }
    
    return self;
}

/**
 *  datasorceに値をセット
 *
 *  @param data   Array
 *  @param number 選択したセル
 *
 *  @return 1つめか2つめか
 */
-(BOOL) setUser:(NSArray *)data
               :(int)number {
    
    if(( _user1.userID != -1 && _user2.userID == -1) ) {

        [_user2 setUserID:number];
        [_user2 setName:[[data objectAtIndex:number] objectForKey:@"name"]];
        [_user2 resetLife];
        
        return true;

    } else {

        [_user2 setUserID:-1];
        
        [_user1 setUserID:number];
        [_user1 setName:[[data objectAtIndex:number] objectForKey:@"name"]];
        [_user1 resetLife];

        return false;
        
    }
}

# pragma mark setter

-(NSArray *) userList {
    if (!_userList) {
        _userList = [[NSArray alloc] init];
    }

    return _userList;

}

-(MTUser *) user1 {
    if (!_user1) {
        _user1 = [[MTUser alloc] init];
    }
    return _user1;
}

-(MTUser *) user2 {
    if (!_user2) {
        _user2 = [[MTUser alloc] init];
    }
    return _user2;
}


@end
