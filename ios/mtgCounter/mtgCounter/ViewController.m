//
//  ViewController.m
//  mtgCounter
//
//  Created by totta on 2015/09/02.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIApplication *application = [UIApplication sharedApplication];
    application.idleTimerDisabled = YES;

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)countUpA:(id)sender {
    [self changeCount:_playerACount
               action:true];
}

- (IBAction)countDownA:(id)sender {
    [self changeCount:_playerACount
               action:false];
}
- (IBAction)countUpB:(id)sender {
    [self changeCount:_playerBCount
               action:true];
}

- (IBAction)countDownB:(id)sender {
    [self changeCount:_playerBCount
               action:false];
}

- (IBAction)retry:(id)sender {
    _playerACount.text = @"20";
    _playerBCount.text = @"20";

    [_gameoverTitle setHidden:YES];
    [_retryButton setHidden:YES];
    
    [_playerACount setHidden:NO];
    [_playerBCount setHidden:NO];
    [_upButtonA setHidden:NO];
    [_upButtonB setHidden:NO];
    [_downButtonA setHidden:NO];
    [_downButtonB setHidden:NO];
    [_playerLabelA setHidden:NO];
    [_playerLabelB setHidden:NO];


}

-(void) changeCount:(UILabel *) player
          action:(BOOL) status
{
    int currentScore = [player.text intValue];
    if (status) {
        currentScore++;
    } else {
        currentScore--;
    }
    if(currentScore == 0) {
        [self gameover];
    }
    player.text = [NSString stringWithFormat:@"%d", currentScore];

}

-(void) gameover {
    [_gameoverTitle setHidden:NO];
    [_retryButton setHidden:NO];
    
    [_playerACount setHidden:YES];
    [_playerBCount setHidden:YES];
    [_upButtonA setHidden:YES];
    [_upButtonB setHidden:YES];
    [_downButtonA setHidden:YES];
    [_downButtonB setHidden:YES];
    [_playerLabelA setHidden:YES];
    [_playerLabelB setHidden:YES];
}


     
@end
