//
//  MTTableViewController.m
//  Magic
//
//  Created by totta on 2015/09/06.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MTTableViewController.h"
#import "BattleViewController.h"


@interface MTTableViewController ()

@end

@implementation MTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = _userData.userList;
    
    
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) { // yes
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int corrent = (int)indexPath.row;

    if (_mode == -1) {
        MTResultViewController *vc = [[MTResultViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }

    if ([_userData setUser:_dataSource
                          :corrent]) {
        
        [self showAlert:@"対戦を始めますか？"
                       :@"いいえ"];
    }
}

#pragma mark alert

-(void) showAlert:(NSString *) message
                 :(NSString *) btnTitle {
    
    NSString *title = [NSString stringWithFormat:@"%@ vs %@",_userData.user1.name ,_userData.user2.name];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:btnTitle
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          nil;
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark action

- (void)otherButtonPushed {
    BattleViewController *vc = [[BattleViewController alloc] init];
    [vc setMach:_mode];
    [vc setUserData:_userData];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)cancelButtonPushed {}

# pragma mark setter
-(MTUserDataSource *) userData {
    if (!_userData) {
        _userData = [[MTUserDataSource alloc] init];
    }
    
    return _userData;
}

-(NSArray *) dataSource {
    if (!_dataSource) {
        _dataSource = [[NSArray alloc] init];
    }
    return _dataSource;
}

@end
