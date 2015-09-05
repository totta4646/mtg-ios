//
//  ViewController.h
//  mtgCounter
//
//  Created by totta on 2015/09/02.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 


- (IBAction)countUpA:(id)sender;
- (IBAction)countDownA:(id)sender;
- (IBAction)countUpB:(id)sender;
- (IBAction)countDownB:(id)sender;
- (IBAction)retry:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *playerACount;
@property (weak, nonatomic) IBOutlet UILabel *playerBCount;
@property (weak, nonatomic) IBOutlet UILabel *playerLabelA;
@property (weak, nonatomic) IBOutlet UILabel *playerLabelB;

@property (weak, nonatomic) IBOutlet UILabel *gameoverTitle;

@property (weak, nonatomic) IBOutlet UIButton *upButtonA;
@property (weak, nonatomic) IBOutlet UIButton *upButtonB;
@property (weak, nonatomic) IBOutlet UIButton *downButtonB;
@property (weak, nonatomic) IBOutlet UIButton *downButtonA;
@property (weak, nonatomic) IBOutlet UIButton *retryButton;

@end

