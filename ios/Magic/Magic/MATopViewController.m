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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)selectBattle:(id)sender {
    NSString *url = @"http://dev.totta.click/get_user.php";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *res = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",res);
}

# pragma mark setter

-(MAApiManager *) api {
    if (!_api) {
        _api = [[MAApiManager alloc] init];
    }
    return _api;
}
@end
