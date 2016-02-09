//
//  MAApiManager.h
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTApiManager : NSObject

@property (strong, nonatomic) NSMutableArray *tempData;

-(NSDictionary *) getAllUser;
-(NSDictionary *) postResultData:(int)winUserId
                                :(int)loseUserId;
-(NSDictionary *) rePostDatas;
-(NSDictionary *) getResultData:(int) userID;
-(NSDictionary *) postDeviceToken:(NSString *) token;

-(void) updateUserColor:(int) userId
                  color:(int) selectColorId;


-(void) setTempData:(int) winner
                   :(int) loser;
-(void) deleteTempData;

@end
