//
//  BattleViewController.m
//  Magic
//
//  Created by totta on 2015/09/06.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "BattleViewController.h"

@interface BattleViewController ()

@end

@implementation BattleViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark private method
-(void) setLayout {
    
    self.view.transform = CGAffineTransformMakeRotation(M_PI/2 * 3);
    
    _user1Name.text = _userData.user1.name;
    _user2Name.text = _userData.user2.name;
    
    _backButton = [[UIBarButtonItem alloc]initWithTitle:@"←"
                                                  style:UIBarButtonItemStylePlain
                                                 target:self
                                                 action:@selector(backToTop)];
    
    
    self.navigationItem.leftBarButtonItem =  _backButton;
    [self rewriteLifes];
    
}

#pragma mark private action
-(void) backToTop {
    [self.navigationController popToRootViewControllerAnimated:YES];

}

-(void) alert:(NSString *)userName {
    
    NSString *title = [NSString stringWithFormat:@"%@の勝ち",userName];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:@"おめでとー"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [self backToTop];
                                                      }]];

    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) checkLife {
    if (_userData.user1.life <= 0) {
        _userData.user1.life = 1000;
        if (_userData.user1.userID != -10) {
            [self sendResultData:_userData.user2
                                :_userData.user1];
        } else {
            [self alert:_userData.user1.name];

        }
    } else if(_userData.user2.life <= 0) {
        _userData.user2.life = 1000;
        if (_userData.user1.userID != -10) {
            [self sendResultData:_userData.user1
                                :_userData.user2];

        } else {
            [self alert:_userData.user1.name];

        }
    } else {
        [self rewriteLifes];
        
    }

}

-(void) rewriteLifes {
    _user1Life.text = [NSString stringWithFormat:@"%d",_userData.user1.life];
    _user2Life.text = [NSString stringWithFormat:@"%d",_userData.user2.life];
    
}

-(void) sendResultData:(MTUser *) winner
                      :(MTUser *) loser {
    
    _api = [[MTApiManager alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        @autoreleasepool{
            NSDictionary *res = [_api postResultData:winner.userID
                                                    :loser.userID];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                if([res count] == 0) {
                  [_api setTempData:winner.userID
                                   :loser.userID];
                }

                [self alert:winner.name];

            });
        }
    });

    
}

#pragma mark action

- (IBAction)user1up5:(id)sender {
    for (int i = 0; i < 5; i++) {
        [_userData.user1 incriment];
    }
    [self checkLife];
}

- (IBAction)user1up1:(id)sender {
    [_userData.user1 incriment];
    [self checkLife];
}

- (IBAction)user1down1:(id)sender {
    [_userData.user1 decrement];
    [self checkLife];
}

- (IBAction)user1down5:(id)sender {
    for (int i = 0; i < 5; i++) {
        [_userData.user1 decrement];
    }
    [self checkLife];
}

- (IBAction)user2up5:(id)sender {
    for (int i = 0; i < 5; i++) {
        [_userData.user2 incriment];
    }
    [self checkLife];
}

- (IBAction)user2up1:(id)sender {
    [_userData.user2 incriment];

    [self checkLife];
}

- (IBAction)user2down5:(id)sender {
    for (int i = 0; i < 5; i++) {
        [_userData.user2 decrement];
    }
    [self checkLife];
}

- (IBAction)user2down1:(id)sender {
    [_userData.user2 decrement];
    [self checkLife];
}

#pragma mark setter


@end
