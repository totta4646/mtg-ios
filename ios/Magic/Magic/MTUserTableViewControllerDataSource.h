//
//  MAUserTableViewControllerDataSource.h
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTUserTableViewControllerDataSource : NSObject

@property (nonatomic) NSArray       *userList;

@property (nonatomic) int           selectUser;
@property (nonatomic) int           selectUser2;


-(void) saveSelectUser:(int)select;

@end
