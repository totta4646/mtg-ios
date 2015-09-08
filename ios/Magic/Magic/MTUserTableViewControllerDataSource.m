//
//  MAUserTableViewControllerDataSource.m
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MTUserTableViewControllerDataSource.h"

@implementation MTUserTableViewControllerDataSource

- (id) init {
    if (self = [super init]) {
        
    }
    return self;
}

# pragma mark private method
/**
 *  選択されたユーザー情報を保持
 *
 *  @param select 選択されたユーザーID
 */

-(void) saveSelectUser:(int) select {
    if (_selectUser != -1 && _selectUser2 == -1) {
        _selectUser2 = select;
    } else {
        _selectUser = select;
        _selectUser2 = -1;
    }
}


# pragma mark setter

-(NSArray *) userList {
    if (_userList) {
        _userList = [[NSArray alloc] init];
    }

    return _userList;

}

-(int) selectUser {
    if (_selectUser) {
        _selectUser = -1;
    }
    
    return _selectUser;
}

-(int) selectUser2 {
    if (_selectUser2) {
        _selectUser2 = -1;
    }
    
    return _selectUser2;
}

@end
