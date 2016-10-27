//
//  ViewController.m
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "ISMainWindowController.h"

@implementation ISMainWindowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Remove table header view.
    [self.resultsTableView.headerView removeFromSuperview];
    self.resultsTableView.headerView = nil;
    [self.resultsTableView reloadData];
    // Set tableView.
    self.resultsTableView.dataSource = self;
    self.resultsTableView.delegate = self;
    self.resultsTableView.doubleAction = @selector(handleDoubleClick:);
    // Set search field.
    self.searchField.delegate = self;
    // Init fetcher.
    self.fetcher = [[ISPPDataFetcher alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDataFetched:)  name:@"FetchedAppDataSuccessfully" object:nil];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)searchAnswer:(id)sender {
    NSLog(@"search answer: %@", [self.searchField stringValue]);
    PPSearchType type = (self.typeSelector.selectedTag == 0) ? PPJBSEARCHTYPE : PPSTORESEARCHTYPE;
    [self.fetcher searchAppWithKeyword:[self.searchField stringValue] searchType:type maxResultCount:15];
}

//- (void)setResultsTableView:(NSTableView *)resultsTableView {
//    if (resultsTableView != self.resultsTableView) {
//        self.resultsTableView = resultsTableView;
//        resultsTableView.dataSource = self;
//        resultsTableView.delegate = self;
//    }
//}

- (void)appDataFetched: (NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.resultsTableView reloadData];
    });
}

- (void)handleDoubleClick: (id)sender {
    [self downloadIpaForRow: self.resultsTableView.clickedRow];
}

- (void)downloadIpaForRow: (NSInteger)row {
    ISApp *app = self.fetcher.apps[row];
    [[NSWorkspace sharedWorkspace] openURL:app.ipaUrl];
}

#pragma mark - NSTableViewDataSource methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.fetcher.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    ISApp *app = self.fetcher.apps[row];
    NSString *identifier = tableColumn.identifier;
    ISResultsTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    [cellView showInfoOfApp: app];
    return cellView;
}


@end
