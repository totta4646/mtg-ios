//
//  BattleViewController.m
//  Magic
//
//  Created by totta on 2015/09/06.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "BattleViewController.h"
#import "MTBattleView.h"

@interface BattleViewController ()

@end

@implementation BattleViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayout];
    
    CGFloat angle = 180.0 * M_PI / 180.0;

    MTBattleView *view1 = [MTBattleView view];
    MTBattleView *view2 = [MTBattleView view];

    view1.transform = CGAffineTransformMakeRotation(angle);
    
    view2.frame = CGRectMake(0,
                             self.view.frame.size.height - 310,
                             self.view.frame.size.width,
                             310);
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


#pragma mark private method
-(void) setLayout {
    
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

/**
 *  試合終了のアラート
 *
 *  @param user 勝ったユーザーの情報
 */

-(void) alert:(MTUser *) winner
             :(MTUser *) loser {
    
    NSString *userName = winner.name;
    winner.win++;
    BOOL gameSet = false;
    if (winner.win == 2 || winner.userID == -10) {
        gameSet = true;
    }

    NSString *title = [NSString stringWithFormat:@"%@ win",userName];
    NSString *message = [NSString stringWithFormat:@"%@:%d勝 %@:%d勝",winner.name,winner.win,loser.name,loser.win];
    if (gameSet) {
        message = @"おめでとー";
        [self sendResultData:winner :loser];
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          if (gameSet) {
                                                              [self backToTop];
                                                          } else {
                                                              [self reset];
                                                          }
                                                      }]];

    [self presentViewController:alertController animated:YES completion:nil];
}
/**
 *  ライフなどの試合情報をリセットする
 */
-(void) reset {
    
    [_userData.user1 setLife];
    [_userData.user2 setLife];
    [_userData.user1 setPoison];
    [_userData.user2 setPoison];

    _userData.gameSet = false;
    
    [self rewriteLifes];
}

/**
 *  ライフが1以下になっていないかチェック
 */
-(void) checkLife {
    if ((_userData.user1.life <= 0  || _userData.user1.poison == 10 ) && !_userData.gameSet) {
        _userData.gameSet = true;
        [self alert:_userData.user2
                   :_userData.user1];

    } else if((_userData.user2.life <= 0 || _userData.user2.poison == 10 ) && !_userData.gameSet) {
        _userData.gameSet = true;
        [self alert:_userData.user1
                   :_userData.user2];

    } else {
        [self rewriteLifes];
        
    }

}

/**
 *  ライフを書き換える
 */
-(void) rewriteLifes {
    NSString *user1Life = nil;
    NSString *user2Life = nil;
    _user1Life.text = [NSString stringWithFormat:@"%d",_userData.user1.life];
    _user2Life.text = [NSString stringWithFormat:@"%d",_userData.user2.life];
    if (_userData.user1.poison) {
        [[MTLayoutView sharedInstance] makeBalloon:_user1Poison];
        user1Life = [NSString stringWithFormat:@"%d",_userData.user1.poison];
    }
    if (_userData.user2.poison) {
        [[MTLayoutView sharedInstance] makeBalloon:_user2Poison];
        user2Life = [NSString stringWithFormat:@"%d",_userData.user2.poison];
    }
    _user1Poison.text = user1Life;
    _user2Poison.text = user2Life;
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
            });
        }
    });

    
}

#pragma mark action

- (IBAction)user1PoisonUp:(id)sender {
    [_userData.user1 poisonIncriment];
    [self checkLife];

}

- (IBAction)user2PoisonUp:(id)sender {
    [_userData.user2 poisonIncriment];
    [self checkLife];

}

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


- (IBAction)user2pallet:(id)sender {
    
    [[MTAnimation sharedInstance] palletAnimation:_user2color1
                                        positionX:0
                                        positionY:60];
    
    [[MTAnimation sharedInstance] palletAnimation:_user2color2
                                        positionX:45
                                        positionY:45];
    
    [[MTAnimation sharedInstance] palletAnimation:_user2color3
                                        positionX:60
                                        positionY:0];

    [[MTAnimation sharedInstance] palletAnimation:_user2color4
                                        positionX:45
                                        positionY:-45];

    [[MTAnimation sharedInstance] palletAnimation:_user2color5
                                        positionX:0
                                        positionY:-60];


}

#pragma mark setter


@end
