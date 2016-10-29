//
//  ISAppData.m
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "ISApp.h"

@implementation ISApp

- (id)initWithAppName: (NSString *)appName version: (NSString *)version size: (NSString *)size iconURL: (NSURL *)iconUrl ipaURL: (NSURL *)ipaUrl description: (NSString *)description {
    if (self = [super init]) {
        self.appName = appName;
        self.version = version;
        self.size = size;
        self.iconUrl = iconUrl;
        self.ipaUrl = ipaUrl;
        self.desc = description;
    }
    return self;
}

@end
