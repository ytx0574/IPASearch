//
//  ISPPDataFetcher.h
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISApp.h"

#define PPJBSEARCHTUNNELCOMMAND @"4262469664"
#define PPSTORESEARCHTUNNELCOMMAND @"4262469686"
#define PPSEARCHURL @"https://jsondata.25pp.com/index.html"

typedef enum {
    PPJBSEARCHTYPE,
    PPSTORESEARCHTYPE
} PPSearchType;


@interface ISPPDataFetcher : NSObject<NSURLSessionDelegate>

@property NSMutableArray *apps;
@property NSInteger count;
@property NSInteger maxCount;
@property NSInteger statusCode;

- (void)searchAppWithKeyword: (NSString *)keyword searchType: (PPSearchType)type maxResultCount: (int)count;

@end
