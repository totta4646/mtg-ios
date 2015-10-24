//
//  MTBattleView.h
//  Magic
//
//  Created by totta on 2015/10/23.
//  Copyright © 2015年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTBattleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userLife;
@property (weak, nonatomic) IBOutlet UILabel *poisonLabel;

@property (weak, nonatomic) IBOutlet UIButton *poisonButton;
@property (weak, nonatomic) IBOutlet UIButton *colorPallet;

@property (weak, nonatomic) IBOutlet UIButton *up;
@property (weak, nonatomic) IBOutlet UIButton *down;
@property (weak, nonatomic) IBOutlet UIButton *up5;
@property (weak, nonatomic) IBOutlet UIButton *down5;

@property (weak, nonatomic) IBOutlet UIButton *color1;
@property (weak, nonatomic) IBOutlet UIButton *color2;
@property (weak, nonatomic) IBOutlet UIButton *color3;
@property (weak, nonatomic) IBOutlet UIButton *color4;
@property (weak, nonatomic) IBOutlet UIButton *color5;


+ (instancetype) view;

@end