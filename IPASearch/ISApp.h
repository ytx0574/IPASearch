//
//  ISAppData.h
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISApp : NSObject

@property NSString *appName;
@property NSString *version;
@property NSString *size;
@property NSURL *iconUrl;
@property NSURL *ipaUrl;
@property NSString *desc;

- (id)initWithAppName: (NSString *)appName version: (NSString *)version size: (NSString *)size iconURL: (NSURL *)iconUrl ipaURL: (NSURL *)ipaUrl description: (NSString *)description;

@end
