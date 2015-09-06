//
//  MATopViewController.m
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MATopViewController.h"

@interface MATopViewController ()

@end

@implementation MATopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _api = [[MAApiManager alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)selectBattle:(id)sender {

    [_api apiConnection];
    
}
@end
