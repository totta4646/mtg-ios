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

    _me = _userData.user1;
    _rival = _userData.user2;

    [self setBattleViews];
    [self setOptionView];
    [self setLayout];
    
    _api = [[MTApiManager alloc] init];
    
    [self reset];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}


#pragma mark private method

- (void) setBattleViews {
    _myView = [MTBattleView view];
    _rivalView = [MTBattleView view];
    
    _myView.delegate = self;
    _rivalView.delegate = self;
    
    _myView.tag = 0;
    _rivalView.tag = 1;
    
    [_myView changeColor:_me.color];
    [_rivalView changeColor:_rival.color];
}

-(void) setOptionView {
    UIView *optionView = [UIView new];
    CGRect sc = [UIScreen mainScreen].bounds;
    
    optionView.frame = CGRectMake(0,
                                  _myView.bounds.size.height,
                                  sc.size.width,
                                  sc.size.height - (2 * _myView.bounds.size.height));
    
    optionView.backgroundColor = [UIColor hx_colorWithHexString:@"fff"];
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
    
    [self.view addSubview:_myView];
    [self.view addSubview:_rivalView];
    [self.view addSubview:optionView];

}

-(void) setLayout {

    CGFloat angle = 180.0 * M_PI / 180.0;
    _myView.transform = CGAffineTransformMakeRotation(angle);
    _rivalView.frame = CGRectMake(0,
                              self.view.frame.size.height - 310,
                              self.view.frame.size.width,
                              310);

    _myView.userName.text = _me.name;
    _rivalView.userName.text = _rival.name;
    
    [self rewriteLifes];
    
}

#pragma mark private action

-(void) backToTop {
    
//    NSInteger hoge = [self.navigationController.viewControllers count];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0]
                                          animated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];

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
    if (winner.win == _mach || winner.userID == -10) {
        gameSet = true;
    }

    NSString *title = [NSString stringWithFormat:@"%@ win",userName];
    NSString *message = [NSString stringWithFormat:@"%@:%d勝 %@:%d勝",winner.name,winner.win,loser.name,loser.win];
    if (gameSet) {
        message = @"おめでとー";
        if (winner.userID != -10) {
            [self sendResultData:winner :loser];
        }
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
    
    [_me setLife];
    [_rival setLife];
    [_me setPoison];
    [_rival setPoison];
    [_me setInvincible];
    [_rival setInvincible];
    
    [[MTLayoutView sharedInstance] deleteBalloon:_myView.poisonLabel];
    [[MTLayoutView sharedInstance] deleteBalloon:_rivalView.poisonLabel];

    
    [self rewriteLifes];
}

/**
 *  ライフが1以下になっていないかチェック
 */
-(void) checkLife {
    if ([self isLose:_me]) {
        [self alert:_rival
                   :_userData.user1];

    } else if([self isLose:_rival]) {
        [self alert:_me
                   :_rival];

    } else {
        [self rewriteLifes];
        
    }

}

- (BOOL) isLose:(MTUser *) user {
    return ((user.life <= 0  || user.poison == 10) && !user.invincible);
}

/**
 *  ライフを書き換える
 */
-(void) rewriteLifes {
    NSString *user1Life = nil;
    NSString *user2Life = nil;

    _myView.userLife.text = [NSString stringWithFormat:@"%d",_me.life];
    _rivalView.userLife.text = [NSString stringWithFormat:@"%d",_rival.life];
    if (_me.poison) {
        [[MTLayoutView sharedInstance] makeBalloon:_myView.poisonLabel];
        user1Life = [NSString stringWithFormat:@"%d",_me.poison];
    }
    if (_rival.poison) {
        [[MTLayoutView sharedInstance] makeBalloon:_rivalView.poisonLabel];
        user2Life = [NSString stringWithFormat:@"%d",_rival.poison];
    }
    _myView.poisonLabel.text = user1Life;
    _rivalView.poisonLabel.text = user2Life;
}
/**
 *  戦績を送信
 *
 *  @param winner 勝ったユーザーの情報
 *  @param loser 負けたユーザーの情報
 */
-(void) sendResultData:(MTUser *) winner
                      :(MTUser *) loser {
    
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
 *  戻るボタン
 *
 *  @param sender 押されたボタンの情報
 */
- (void) returnAction:(id) sender {
    [self backToTop];
}

- (void) diceAction:(id) sender {
    if (!_myView.dice) {
        [_myView setDices];
        [_rivalView setDices];
    } else {
        [_myView removeDices];
        [_rivalView removeDices];
    }
}
/**
 *  リセットボタン
 *
 *  @param sender 押されたボタンの情報
 */
- (void) resetAction:(id) sender {
    [self reset];
    
}


#pragma mark setter

#pragma mark delegate
/**
 *  ライフの書き換え
 *
 *  @param sender 押されたボタンの情報
 */
- (void) changeLife:(id) sender {
    int point = (int)[sender tag];
    if (![sender superview].tag) {
        _me.life += point;
    } else {
        _rival.life += point;
    }
    
    [self checkLife];
}
/**
 *  毒カウンターの書き換え
 *
 *  @param sender 押されたボタンの情報
 */
- (void) addPoison:(id) sender {
    if (![sender superview].tag) {
        _me.poison++;
    } else {
        _rival.poison++;
    }
    [self checkLife];
    
}
/**
 *  無敵モードに変更
 *
 *  @param sender 押されたボタンの情報
 */
- (void) invincible:(id)sender {
    if (![sender superview].tag) {
        _me.invincible = !_me.invincible;
        _myView.nonGameSetButton.selected = _me.invincible;
    } else {
        _rival.invincible = !_rival.invincible;
        _rivalView.nonGameSetButton.selected = _rival.invincible;
    }
    [self checkLife];
    
}

/**
 *  カラーパレットをタップ
 *
 *  @param sender 押されたボタンの情報
 */
- (void) selectPallet:(id) sender {
    if (![sender superview].tag) {

        [_myView setAlphaFilter:YES];
        [_rivalView setAlphaFilter:NO];
        

    } else {

        [_rivalView setAlphaFilter:YES];
        [_myView setAlphaFilter:NO];
    }
}

/**
 *  カラーパレットの色をタップ
 *
 *  @param sender 押されたボタンの情報
 */
- (void) selectColor:(id) sender {

    int color = (int) [sender tag];
    
    if (![sender superview].tag) {
        [_myView changeColor:color];
        [_myView selectColor];

        if (_me.userID != -10) {
            _me.color = color;
            [_api updateUserColor:_me.userID
                            color:color];
        }
            
    } else {
        [_rivalView changeColor:color];
        [_rivalView selectColor];

        if (_rival.userID != -10) {
            _rival.color = color;
            [_api updateUserColor:_rival.userID
                            color:color];
        }        
    }

    [_myView setAlphaFilter:NO];
    [_rivalView setAlphaFilter:NO];
    
}



@end
