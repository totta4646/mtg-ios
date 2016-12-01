//
//  MTTopViewController.m
//  Magic
//
//  Created by totta on 2015/09/06.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MTTopViewController.h"
#import "MTTableViewController.h"
#import "BattleViewController.h"


@interface MTTopViewController ()

@end

@implementation MTTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Magic: The Gathering";
    _connectionFlag = false;
    _api = [[MTApiManager alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        @autoreleasepool{
            NSDictionary *res = [_api rePostDatas];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if([res count] != 0) {
                    [_api deleteTempData];

                }
            });
        }
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark private method

-(void) modalTableView:(NSString *)navTitle
                      :(int)mode {
    MTTableViewController *vc = [[MTTableViewController alloc] init];
    _userData = [[MTUserDataSource alloc] init];
    [SVProgressHUD showWithStatus:@"now loading"];
    
    if (_connectionFlag) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        @autoreleasepool{
            _connectionFlag = true;
            [_userData setUserList:[[_api getAllUser] objectForKey:@"data"]];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                _connectionFlag = false;
                [vc setUserData:_userData];
                [vc setDataSource:_userData.userList];
                [vc setMode:mode];
                
                vc.navigationItem.title = navTitle;

                if([_userData.userList count] != 0) {
                    [SVProgressHUD showWithStatus:@"success"];
                    [SVProgressHUD dismissWithDelay:.5f];
                    [self.navigationController pushViewController:vc animated:YES];
                } else {
                    [SVProgressHUD showWithStatus:@"failed"];
                    [SVProgressHUD dismissWithDelay:.5f];
                    
                }
                
            });
        }
    });
    
}

#pragma mark alert

-(void) showAlert {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"対戦形式"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"1マッチ"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [self therePointmach];
                                                      }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"1本"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [self onePointmach];
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark action

- (void)therePointmach {
    [self modalTableView:@"対戦相手を選んでください。"
                        :BattleModeMatch];
}
- (void)onePointmach {
    [self modalTableView:@"対戦相手を選んでください。"
                        :BattleModeSingle];
}


# pragma mark setter
-(MTUserDataSource *) userData {
    if (!_userData) {
        _userData = [[MTUserDataSource alloc] init];
    }
    
    return _userData;
}


#pragma mark action

- (IBAction)selectUser:(id)sender {
    [self showAlert];
}


- (IBAction)guestBattle:(id)sender {
    BattleViewController *vc = [[BattleViewController alloc] init];
    _userData = [[MTUserDataSource alloc] init];
    [_userData makeGuestUserData];

    [vc setUserData:_userData];
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)resultSelectUser:(id)sender {
    [self modalTableView:@"ユーザーを選んでください。"
                        :TableModeResult];
}
@end
