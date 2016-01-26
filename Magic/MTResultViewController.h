//
//  MTResultViewController.h
//  Magic
//
//  Created by Kohei Totani on 2016/01/25.
//  Copyright © 2016年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTResultView.h"

@interface MTResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet MBCircularProgressBarView *winGraph;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property float padding;
@end
