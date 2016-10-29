//
//  ViewController.h
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ISResultsTableView.h"
#import "ISPPDataFetcher.h"
#import "ISResultsTableCellView.h"

@interface ISMainWindowController : NSViewController<NSSearchFieldDelegate, NSTableViewDelegate, NSTableViewDataSource, NSTouchBarDelegate>

@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSPopUpButton *typeSelector;
@property (weak, nonatomic) IBOutlet ISResultsTableView *resultsTableView;
@property ISPPDataFetcher *fetcher;
@property (weak) IBOutlet NSTouchBar *mainBar;
@property (weak) IBOutlet NSButton *downloadBarButton;
@property (weak) IBOutlet NSPopoverTouchBarItem *showInfoBarButton;
@property (weak) IBOutlet NSTouchBar *infoBar;
@property (weak) IBOutlet NSScrollView *infoBarScrollView;
@property (unsafe_unretained) IBOutlet NSTextView *infoBarTextView;

@end

