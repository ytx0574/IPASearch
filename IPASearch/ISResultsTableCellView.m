//
//  ISResultsTableCellView.m
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "ISResultsTableCellView.h"

@implementation ISResultsTableCellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)showInfoOfApp: (ISApp *)app {
    self.nameLabel.stringValue = app.appName;
    self.versionLabel.stringValue = app.version;
    self.sizeLabel.stringValue = app.size;
    
    NSData *imgData = [NSData dataWithContentsOfURL:app.iconUrl];
    NSImage *icon = [[NSImage alloc]initWithData:imgData];
    [self.iconView setImage:icon];
}

@end
