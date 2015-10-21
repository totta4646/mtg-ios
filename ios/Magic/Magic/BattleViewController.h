//
//  BattleViewController.h
//  Magic
//
//  Created by totta on 2015/09/06.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BattleViewController : UIViewController

@property MTUserDataSource                   *userData;
@property MTApiManager                       *api;

@property (weak, nonatomic) IBOutlet UILabel *user1Name;
@property (weak, nonatomic) IBOutlet UILabel *user1Life;
@property (weak, nonatomic) IBOutlet UILabel *user2Name;
@property (weak, nonatomic) IBOutlet UILabel *user2Life;
@property (weak, nonatomic) IBOutlet UILabel *user1Poison;
@property (weak, nonatomic) IBOutlet UILabel *user2Poison;

@property (weak, nonatomic) IBOutlet UIView  *user1View;
@property (weak, nonatomic) IBOutlet UIView  *user2View;

@property (nonatomic) UIBarButtonItem        *backButton;
@property (nonatomic) UIAlertController      *alert;

@property (weak, nonatomic) IBOutlet UIButton *user2color1;
@property (weak, nonatomic) IBOutlet UIButton *user2color2;
@property (weak, nonatomic) IBOutlet UIButton *user2color3;
@property (weak, nonatomic) IBOutlet UIButton *user2color4;
@property (weak, nonatomic) IBOutlet UIButton *user2color5;

- (IBAction)user1PoisonUp:(id)sender;
- (IBAction)user2PoisonUp:(id)sender;

- (IBAction)user1up5:(id)sender;
- (IBAction)user1up1:(id)sender;
- (IBAction)user1down5:(id)sender;
- (IBAction)user1down1:(id)sender;

- (IBAction)user2up5:(id)sender;
- (IBAction)user2up1:(id)sender;
- (IBAction)user2down5:(id)sender;
- (IBAction)user2down1:(id)sender;

- (IBAction)user2pallet:(id)sender;
@end
