//
//  ISResultsTableCellView.h
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ISApp.h"

@interface ISResultsTableCellView : NSTableCellView

@property (weak) IBOutlet NSImageView *iconView;
@property (weak) IBOutlet NSTextField *nameLabel;
@property (weak) IBOutlet NSTextField *versionLabel;
@property (weak) IBOutlet NSTextField *sizeLabel;

- (void)showInfoOfApp: (ISApp *)app;

@end
