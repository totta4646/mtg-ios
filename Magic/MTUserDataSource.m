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
        _gameSet = false;
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
    
    int userID = (int)[[[data objectAtIndex:number] objectForKey:@"id"] integerValue];
    int userColor = (int)[[[data objectAtIndex:number] objectForKey:@"color"] integerValue];
    NSString *userName = [[data objectAtIndex:number] objectForKey:@"name"];
    
    if (_user1.userID == userID) {
        return false;
    }
    
    if( _user1.userID != -1 && _user2.userID == -1) {

        [_user2 setUserID:userID];
        [_user2 setName:userName];
        [_user2 setLife];
        [_user2 setColor:userColor];
        
        return true;

    } else {

        [_user2 setUserID:-1];
        
        [_user1 setUserID:userID];
        [_user1 setName:userName];
        [_user1 setColor:userColor];
        [_user1 setLife];

        return false;
        
    }
}
/**
 *  ゲストモードで情報を初期化
 */
-(void) makeGuestUserData {
    [_user1 setGuest];
    [_user2 setGuest];
    [_user1 setLife];
    [_user2 setLife];

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
