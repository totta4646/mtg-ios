//
//  MTTopViewController.h
//  Magic
//
//  Created by totta on 2015/09/06.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTDiceView.h"

@interface MTTopViewController : UIViewController

@property (nonatomic) MTApiManager     *api;
@property (nonatomic) MTUserDataSource *userData;

@property (nonatomic) MTDiceView       *dice;

- (IBAction)selectUser:(id)sender;
- (IBAction)guestBattle:(id)sender;
- (IBAction)resultSelectUser:(id)sender;
@end
