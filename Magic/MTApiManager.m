//
//  MAApiManager.m
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MTApiManager.h"

@implementation MTApiManager

# pragma mark grobal method

/**
 *  保存されているユーザーの情報を取得するAPIを叩く
 *
 *  @return ユーザー一覧
 */
-(NSDictionary *) getAllUser {
    NSString *url = [NSString stringWithFormat:@"%@%@",URI ,UESRS];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    return [self post:request];
}

/**
 *  ユーザーの色を変えるAPIを叩く
 *
 *  @param userId        色を変えるユーザーのID
 *  @param selectColorId 色のID
 *
 */
-(void) updateUserColor:(int) userId
                  color:(int) selectColorId {

    NSString *param = [NSString stringWithFormat:@"?color=%d", selectColorId];
    NSString *url = [NSString stringWithFormat:@"%@%@%d%@",URI,UESR ,userId,param];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"PUT";
    [self post:request];
}

/**
 *  対戦結果を送信するAPIを叩く
 *
 *  @param winUserId  勝ったユーザーのユーザーID
 *  @param loseUserId 負けたユーザーのユーザーID
 *
 *  @return 送信結果
 */
-(NSDictionary *) postResultData:(int)winUserId
                                :(int)loseUserId {
    NSString *param = [NSString stringWithFormat:@"?winner=%d&loser=%d",winUserId, loseUserId];
    NSString *url = [NSString stringWithFormat:@"%@%@create%@",URI ,RESULT,param ];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    return [self post:request];
    
}
/**
 *  対戦結果を取得
 *
 *  @param userID  ユーザーのID
 *
 *  @return 対戦結果
 */
-(NSDictionary *) getResultData:(int)userID {
    NSString *url = [NSString stringWithFormat:@"%@%@%d",URI ,RESULT, userID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    return [self post:request];
    
}

/**
 *  push用のデバイストークンを送信するAPI
 *
 *  @param token device token
 *
 *  @return status
 */

-(NSDictionary *) postDeviceToken:(NSString *)token {
    NSString *param = [NSString stringWithFormat:@"?device_token=%@",token];
    NSString *url = [NSString stringWithFormat:@"%@token%@",URI, param];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    
    return [self post:request];
    
}

/**
 *  電波などの影響で送信できていなかった情報の再び送信
 *
 *  @return response
 */
-(NSDictionary *) rePostDatas {
    NSUserDefaults *ud = [[NSUserDefaults alloc] init];
    _tempData = [[ud objectForKey:TEMP_ARRAY] mutableCopy];
    if (_tempData == nil || [_tempData count] == 0) {
        return false;
    }
    
    NSArray *temp = _tempData[0];
    NSDictionary *res = [self postResultData:[temp[0] intValue]
                                            :[temp[1] intValue]];
    return res;
}

/**
 *  電波の影響で送信できなかった対戦結果を端末側で保存しておくメソッド
 *
 *  @param winner 勝ったユーザーのID
 *  @param loser  負けたユーザーのID
 */
-(void) setTempData:(int) winner
                   :(int) loser {
    NSUserDefaults *ud = [[NSUserDefaults alloc] init];
    _tempData = [[ud objectForKey:TEMP_ARRAY] mutableCopy];
    
    if (_tempData == nil) {
        _tempData = [[NSMutableArray alloc] init];
    }
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    [data addObject:[NSNumber numberWithInt:winner]];
    [data addObject:[NSNumber numberWithInt:loser]];

    [_tempData addObject:data];

    [ud setObject:_tempData forKey:TEMP_ARRAY];
    [ud synchronize];
}

/**
 *  一時保存していた試合結果の削除
 */
-(void) deleteTempData {
    NSUserDefaults *ud = [[NSUserDefaults alloc] init];
    _tempData = [[ud objectForKey:TEMP_ARRAY] mutableCopy];
    
    if (_tempData == nil) {
        _tempData = [[NSMutableArray alloc] init];
    }
    [_tempData removeObjectAtIndex:0];
    
    [ud setObject:_tempData forKey:TEMP_ARRAY];
    [ud synchronize];
}



# pragma mark private method

/**
 *  APIの基盤
 *
 *  @param request 叩きたいURL情報の入ったrequest
 *
 *  @return レスポンス
 */
-(NSDictionary *) post:(NSURLRequest *) request {
    
    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (!json) {
        return false;
    }
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
    return res;
}

#pragma mark setter

-(NSMutableArray *) tempData {
    if(!_tempData) {
        _tempData = [[NSMutableArray alloc] init];
    }
    return _tempData;
}

@end
