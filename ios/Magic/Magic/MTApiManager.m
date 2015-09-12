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

-(NSDictionary *) getAllUser {
    NSString *url = [NSString stringWithFormat:@"%@%@",MY_HOST ,@"get_user.php" ];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    return [self post:request];
    
}

-(NSDictionary *) postResultData:(int)winUserId
                                :(int)loseUserId {
    
    NSString *param = [NSString stringWithFormat:@"winner=%d&loser=%d",winUserId, loseUserId];
    NSString *url = [NSString stringWithFormat:@"%@post.php?%@",MY_HOST ,param];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    return [self post:request];
    
}


# pragma mark private method

-(NSDictionary *) post:(NSURLRequest *) request {
    
    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
   
}

@end
