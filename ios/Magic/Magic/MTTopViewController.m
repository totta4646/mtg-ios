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
    [vc setDataSource:[[_api getAllUser] objectForKey:@"data"]];
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
