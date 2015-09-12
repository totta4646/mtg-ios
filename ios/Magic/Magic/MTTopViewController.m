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
    _api = [[MTApiManager alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)selectUser:(id)sender {
    MTTableViewController *vc = [[MTTableViewController alloc] init];
    _userData = [[MTUserDataSource alloc] init];
    

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        @autoreleasepool{

            [vc setUserData:_userData];
            [vc setDataSource:_userData.userList];
            vc.navigationItem.title = @"対戦相手を選んでください。";
            [_userData setUserList:[[_api getAllUser] objectForKey:@"data"]];

            dispatch_sync(dispatch_get_main_queue(), ^{

                [self.navigationController pushViewController:vc animated:YES];

            });
        }
    });
    
    
}

- (IBAction)guestBattle:(id)sender {
    BattleViewController *vc = [[BattleViewController alloc] init];
    _userData = [[MTUserDataSource alloc] init];
    [_userData makeGuestUserData];

    [vc setUserData:_userData];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
