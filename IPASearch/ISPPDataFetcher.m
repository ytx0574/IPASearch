//
//  ISPPDataFetcher.m
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016年 Wang Jinli. All rights reserved.
//

#import "ISPPDataFetcher.h"

@implementation ISPPDataFetcher

- (void)searchAppWithKeyword: (NSString *)keyword searchType: (PPSearchType)type maxResultCount: (int)count {
    NSString *tunnel = (type == PPJBSEARCHTYPE) ? PPJBSEARCHTUNNELCOMMAND : PPSTORESEARCHTUNNELCOMMAND;
    NSNumber *clFlag = (type == PPJBSEARCHTYPE) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:3];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:PPSEARCHURL]];
    [request setHTTPMethod:@"POST"];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:0], @"dcType",
                                                                        keyword, @"keyword",
                                                                        clFlag, @"clFlag",
                                                                        [NSNumber numberWithInt:count], @"perCount",
                                                                        [NSNumber numberWithInt:0], @"page", nil];
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    [request setHTTPBody:postData];
    [request setValue:tunnel forHTTPHeaderField:@"Tunnel-Command"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self handleReceivedData: data response:response error:error];
    }];
    [postDataTask resume];
}

- (void)handleReceivedData: (NSData *)data response: (NSURLResponse *)response error: (NSError *)error {
    if (error == nil) { // Request finished successfully.
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        self.statusCode = httpResponse.statusCode;
        if (self.statusCode == 200) {   // Request succeeded.
            [self parseAppData: data];
        }
        else {
            NSLog(@"Bad HTTP status code (%ld).", (long)self.statusCode);
        }
    }
    else {
        NSLog(@"Request failed. %@", error);
    }
}

- (void)parseAppData: (NSData *)data {
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"Bad JSON Data.");
        self.statusCode = 601;
        return;
    }
    if(![object isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Invalid JSON.");
        self.statusCode = 602;
        return;
    }
    NSDictionary *results = object;
    NSLog(@"%@", results);
}

@end
