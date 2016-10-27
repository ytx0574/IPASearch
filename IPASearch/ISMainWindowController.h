//
//  ViewController.h
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016年 Wang Jinli. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ISPPDataFetcher.h"

@interface ISMainWindowController : NSViewController<NSSearchFieldDelegate>

@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSPopUpButton *typeSelector;
@property (weak) IBOutlet NSTableView *resultsTableView;
@property ISPPDataFetcher *fetcher;

@end

