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

    _view1 = [MTBattleView view];
    _view2 = [MTBattleView view];

    _view1.tag = 0;
    _view2.tag = 1;
    
    [_view1.up addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];
    [_view1.up5 addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];
    [_view1.down addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];
    [_view1.down5 addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];

    [_view2.up addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];
    [_view2.up5 addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];
    [_view2.down addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];
    [_view2.down5 addTarget:self action:@selector(changeLife:)forControlEvents:UIControlEventTouchUpInside];

    [_view1.poisonButton addTarget:self action:@selector(changePoison:)forControlEvents:UIControlEventTouchUpInside];
    [_view2.poisonButton addTarget:self action:@selector(changePoison:)forControlEvents:UIControlEventTouchUpInside];

    [_view1.colorPallet addTarget:self action:@selector(selectAimation:)forControlEvents:UIControlEventTouchUpInside];
    [_view2.colorPallet addTarget:self action:@selector(selectAimation:)forControlEvents:UIControlEventTouchUpInside];

    
    UIView *optionView = [UIView new];
    CGRect sc = [UIScreen mainScreen].bounds;

    optionView.frame = CGRectMake(0,
                                  self.view1.bounds.size.height,
                                  sc.size.width,
                                  sc.size.height - (2 * self.view1.bounds.size.height));

    optionView.backgroundColor = [UIColor hx_colorWithHexString:@"f7f7f7"];
    static int imageSize = 30;

    CGRect returnFrame = CGRectMake(sc.size.width / 3 - imageSize / 2 * 3,
                                    (optionView.bounds.size.height - imageSize) / 2 ,
                                    imageSize,
                                    imageSize);
    
    CGRect diceFrame = CGRectMake((sc.size.width - imageSize) / 2 ,
                                  (optionView.bounds.size.height - imageSize) / 2 ,
                                  imageSize,
                                  imageSize);

    CGRect resetFrame = CGRectMake(sc.size.width / 3 * 2 - imageSize / 2 + imageSize,
                                   (optionView.bounds.size.height - imageSize) / 2 ,
                                   imageSize,
                                   imageSize);
    
    
    _returnButton = [[UIButton alloc] initWithFrame:returnFrame];
    _diceButton = [[UIButton alloc] initWithFrame:diceFrame];
    _resetButton = [[UIButton alloc] initWithFrame:resetFrame];
    
    UIImage *returnImage = [UIImage imageNamed:@"return.png"];
    UIImage *diceImage = [UIImage imageNamed:@"dice.png"];
    UIImage *resetImage = [UIImage imageNamed:@"reset.png"];
    
    [_returnButton setBackgroundImage:returnImage forState:UIControlStateNormal];
    [_diceButton setBackgroundImage:diceImage forState:UIControlStateNormal];
    [_resetButton setBackgroundImage:resetImage forState:UIControlStateNormal];
    
    [_returnButton addTarget:self action:@selector(returnAction:)forControlEvents:UIControlEventTouchUpInside];
    [_diceButton addTarget:self action:@selector(diceAction:)forControlEvents:UIControlEventTouchUpInside];
    [_resetButton addTarget:self action:@selector(resetAction:)forControlEvents:UIControlEventTouchUpInside];

    
    [optionView addSubview:_returnButton];
    [optionView addSubview:_diceButton];
    [optionView addSubview:_resetButton];
    
    [self.view addSubview:_view1];
    [self.view addSubview:_view2];
    [self.view addSubview:optionView];

    [self setLayout];
   
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

    CGFloat angle = 180.0 * M_PI / 180.0;
    _view1.transform = CGAffineTransformMakeRotation(angle);
    _view2.frame = CGRectMake(0,
                              self.view.frame.size.height - 310,
                              self.view.frame.size.width,
                              310);

    _view1.userName.text = _userData.user1.name;
    _view2.userName.text = _userData.user2.name;
    
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
    
    [[MTLayoutView sharedInstance] deleteBalloon:_view1.poisonLabel];
    [[MTLayoutView sharedInstance] deleteBalloon:_view2.poisonLabel];

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

    _view1.userLife.text = [NSString stringWithFormat:@"%d",_userData.user1.life];
    _view2.userLife.text = [NSString stringWithFormat:@"%d",_userData.user2.life];
    if (_userData.user1.poison) {
        [[MTLayoutView sharedInstance] makeBalloon:_view1.poisonLabel];
        user1Life = [NSString stringWithFormat:@"%d",_userData.user1.poison];
    }
    if (_userData.user2.poison) {
        [[MTLayoutView sharedInstance] makeBalloon:_view2.poisonLabel];
        user2Life = [NSString stringWithFormat:@"%d",_userData.user2.poison];
    }
    _view1.poisonLabel.text = user1Life;
    _view2.poisonLabel.text = user2Life;
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
/**
 *  ライフの書き換え
 *
 *  @param sender 押されたボタンの情報
 */
- (void) changeLife:(id) sender {
    int point = (int)[sender tag];
    if (![sender superview].tag) {
        _userData.user1.life += point;
    } else {
        _userData.user2.life += point;
    }

    [self checkLife];
}
/**
 *  毒カウンターの書き換え
 *
 *  @param sender 押されたボタンの情報
 */
- (void) changePoison:(id) sender {
    if (![sender superview].tag) {
        _userData.user1.poison++;
    } else {
        _userData.user2.poison++;
    }
    [self checkLife];
    
}
/**
 *  戻るボタン
 *
 *  @param sender 押されたボタンの情報
 */
- (void) returnAction:(id) sender {
    [self backToTop];
}

- (void) diceAction:(id) sender {
    
}
/**
 *  リセットボタン
 *
 *  @param sender 押されたボタンの情報
 */
- (void) resetAction:(id) sender {
    [self reset];
    
}
/**
 *  パレットボタン
 *
 *  @param sender 押されたボタンの情報
 */
- (void) selectAimation:(id) sender {
    MTBattleView *parentView;
    if (![sender superview].tag) {
        parentView = _view1;
    } else {
        parentView = _view2;
        
    }
    [[MTAnimation sharedInstance] palletAnimation:parentView.color1
                                        positionX:0
                                        positionY:60];
    
    [[MTAnimation sharedInstance] palletAnimation:parentView.color2
                                        positionX:45
                                        positionY:45];
    
    [[MTAnimation sharedInstance] palletAnimation:parentView.color3
                                        positionX:60
                                        positionY:0];
    
    [[MTAnimation sharedInstance] palletAnimation:parentView.color4
                                        positionX:45
                                        positionY:-45];
    
    [[MTAnimation sharedInstance] palletAnimation:parentView.color5
                                        positionX:0
                                        positionY:-60];
}

#pragma mark setter


@end
