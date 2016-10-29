//
//  ISPPDataFetcher.m
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "ISPPDataFetcher.h"

@implementation ISPPDataFetcher

- (id)init {
    if (self = [super init])  {
        self.count = 0;
        self.maxCount = 0;
    }
    return self;
}

- (void)searchAppWithKeyword: (NSString *)keyword searchType: (PPSearchType)type maxResultCount: (int)count {
    self.maxCount = count;
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
    self.statusCode = [[results objectForKey:@"status"] integerValue];
    if (self.statusCode != 0) {
        NSLog(@"Bad Response (code: %ld).", (long)self.statusCode);
        return;
    }
    // Parse Correct Result.
    NSInteger fetchedCount = [[results objectForKey:@"searchCount"] integerValue];
    self.count = (fetchedCount > self.maxCount) ? self.maxCount : fetchedCount;
    self.apps = [NSMutableArray array];
    if (self.count == 0) {
        return;
    }
    NSArray *appInfo = [results objectForKey:@"content"];
    self.count = [appInfo count];   // Make sure the app's count is correct.
    for (NSDictionary *aApp in appInfo) {
        NSURL *iconUrl = [NSURL URLWithString:[aApp objectForKey:@"thumb"]];
        NSURL *ipaUrl = [NSURL URLWithString:[aApp objectForKey:@"downurl"]];
        NSString *appName = [aApp objectForKey:@"title"];
        NSString *version = [aApp objectForKey:@"version"];
        NSString *size = [aApp objectForKey:@"fsize"];
        NSString *description = [aApp objectForKey:@"desc"];
        ISApp *app = [[ISApp alloc]initWithAppName:appName version:version size:size iconURL:iconUrl ipaURL:ipaUrl description:description];
        [self.apps addObject:app];
    }
    NSLog(@"Fetched data successfully.");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FetchedAppDataSuccessfully" object:self];
}

@end
