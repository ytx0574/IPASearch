//
//  ISResultsTableCellView.m
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016年 Wang Jinli. All rights reserved.
//

#import "ISResultsTableCellView.h"

@implementation ISResultsTableCellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (id)initWithApp: (ISApp *)app {
    if (self = [super init]) {
        [self showInfoOfApp: app];
    }
    return self;
}

- (void)showInfoOfApp: (ISApp *)app {
    self.nameLabel.stringValue = app.appName;
    self.versionLabel.stringValue = app.version;
    self.sizeLabel.stringValue = app.size;
}

@end
