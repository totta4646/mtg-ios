//
//  MTLayoutView.h
//  Magic
//
//  Created by Gizumo-002 on 2015/10/21.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTLayoutView : NSObject
+ (instancetype) sharedInstance;
- (UILabel *) makeBalloon:(UILabel *) view;
- (UILabel *) deleteBalloon:(UILabel *) view;
- (UIButton *) colorPallet:(UIButton *) view;
- (UIView *) makeCircle:(UIView *) view;

@end
