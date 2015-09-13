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


#pragma mark private method

-(void) modalTableView:(NSString *)navTitle
                      :(BOOL)resultMode {
    MTTableViewController *vc = [[MTTableViewController alloc] init];
    _userData = [[MTUserDataSource alloc] init];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        @autoreleasepool{
            [_userData setUserList:[[_api getAllUser] objectForKey:@"data"]];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [vc setUserData:_userData];
                [vc setDataSource:_userData.userList];
                [vc setResult:resultMode];
                
                vc.navigationItem.title = navTitle;

                [self.navigationController pushViewController:vc animated:YES];
                
            });
        }
    });
    
}

#pragma mark action

- (IBAction)selectUser:(id)sender {
    [self modalTableView:@"対戦相手を選んでください。"
                        :NO];
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
                        :YES];
}
@end
