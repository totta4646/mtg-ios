//
//  MTTableViewController.h
//  Magic
//
//  Created by totta on 2015/09/06.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTTableViewController : UITableViewController

@property (strong, nonatomic) MTUserDataSource             *userData;
@property (nonatomic) MTApiManager                         *api;
@property (strong, nonatomic) NSArray                      *dataSource;
@property (readwrite, assign) BOOL                                 *result;

@end
