//
//  MTResultView.h
//  Magic
//
//  Created by Kohei Totani on 2016/01/26.
//  Copyright © 2016年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBCircularProgressBarView.h"

@interface MTResultView : UIView
@property (weak, nonatomic) IBOutlet UILabel *rivalNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateLabel;
@property (weak, nonatomic) IBOutlet MBCircularProgressBarView *resultGraph;
@property (weak, nonatomic) IBOutlet UILabel *winPercentLabel;

@property                            UIColor *color;

+ (instancetype) view;

- (void) setResult:(NSString *) name
                  :(int) win
                  :(int) lose
                  :(float) parcent
                  :(int) color
                  :(NSString *) date;

@end
