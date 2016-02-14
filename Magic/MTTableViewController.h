//
//  MTTableViewController.h
//  Magic
//
//  Created by totta on 2015/09/06.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTResultViewController.h"

@interface MTTableViewController : UITableViewController

@property (strong, nonatomic) MTUserDataSource             *userData;
@property (nonatomic) MTApiManager                         *api;
@property (strong, nonatomic) NSArray                      *dataSource;
@property (nonatomic) int                                  mode;
@property BOOL connectionFlag;

typedef NS_ENUM(NSInteger, AlertType)
{
    NormalAlertType = 0,
    UserSelectAlertType
};

@end
