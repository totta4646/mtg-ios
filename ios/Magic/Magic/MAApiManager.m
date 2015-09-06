//
//  MAApiManager.m
//  Magic
//
//  Created by totta on 2015/09/05.
//  Copyright (c) 2015年 totta. All rights reserved.
//

#import "MAApiManager.h"

@implementation MAApiManager

# pragma mark grobal method

-(NSArray *) apiConnection {
    NSString *url = @"http://dev.totta.click/get_user.php";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    return [self post:request];
    
}

# pragma mark private method

-(NSArray *) post:(NSURLRequest *) request {
    
    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
   
}

@end
