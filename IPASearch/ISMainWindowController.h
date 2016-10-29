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

@interface ISMainWindowController : NSViewController<NSSearchFieldDelegate, NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSPopUpButton *typeSelector;
@property (weak, nonatomic) IBOutlet ISResultsTableView *resultsTableView;
@property ISPPDataFetcher *fetcher;

@end

