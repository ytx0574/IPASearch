//
//  ViewController.h
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016年 Wang Jinli. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ISPPDataFetcher.h"
#import "ISResultsTableCellView.h"

@interface ISMainWindowController : NSViewController<NSSearchFieldDelegate, NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSPopUpButton *typeSelector;
@property (weak, nonatomic) IBOutlet NSTableView *resultsTableView;
@property ISPPDataFetcher *fetcher;

@end

