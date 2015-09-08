//
//  MTTopViewController.m
//  Magic
//
//  Created by totta on 2015/09/06.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MTTopViewController.h"
#import "MTTableViewController.h"

@interface MTTopViewController ()

@end

@implementation MTTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _api = [[MTApiManager alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)selectUser:(id)sender {
    MTTableViewController *vc = [[MTTableViewController alloc] init];
    _userData = [[MTUserTableViewControllerDataSource alloc] init];
    

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
//        @autoreleasepool{
            [_userData setUserList:[[_api getAllUser] objectForKey:@"data"]];

//            dispatch_sync(dispatch_get_main_queue(), ^{
                [vc setUserData:_userData];
//    [vc setDataSource:_userData.userList];
    
//            });
//        }
//    });
//    
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
