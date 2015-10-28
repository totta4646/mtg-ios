//
//  BattleViewController.h
//  Magic
//
//  Created by totta on 2015/09/06.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBattleView.h"

@interface BattleViewController : UIViewController <BattleViewDelegate>

@property MTUserDataSource                   *userData;
@property MTApiManager                       *api;

@property MTBattleView                       *myView;
@property MTBattleView                       *rivalView;

@property UIButton                           *diceButton;
@property UIButton                           *returnButton;
@property UIButton                           *resetButton;


@property (nonatomic) UIView                 *filter;

@property (nonatomic) UIBarButtonItem        *backButton;
@property (nonatomic) UIAlertController      *alert;


@end
