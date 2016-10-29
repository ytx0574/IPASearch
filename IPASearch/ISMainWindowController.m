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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnKeyPressed:) name:@"ReturnKeyPressed" object:nil];
    // Set search field.
    self.searchField.delegate = self;
    // Init fetcher.
    self.fetcher = [[ISPPDataFetcher alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDataFetched:)  name:@"FetchedAppDataSuccessfully" object:nil];
    // Set Main Touch Bar.
    self.mainBar.delegate = self;
    self.downloadBarButton.hidden = YES;
    self.downloadBarButton.image = [NSImage imageNamed:NSImageNameTouchBarDownloadTemplate];
    self.infoBar.delegate = self;
    // Set Info Touch Bar.
    self.showInfoBarButton.collapsedRepresentation.hidden = YES;
    self.showInfoBarButton.collapsedRepresentationImage = [NSImage imageNamed:NSImageNameTouchBarGetInfoTemplate];
    self.showInfoBarButton.collapsedRepresentationLabel = @"";
    [self.infoBarTextView setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
    self.infoBarTextView.textContainer.widthTracksTextView = NO;
    [self.infoBarTextView.textContainer setContainerSize:NSMakeSize(FLT_MAX, FLT_MAX)];
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

- (void)returnKeyPressed: (NSNotification *)notification {
    [self downloadIpaForRow:self.resultsTableView.selectedRow];
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

#pragma mark = NSTableViewDelegate methods

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    self.downloadBarButton.hidden = NO;
    self.downloadBarButton.action = @selector(returnKeyPressed:);
    ISApp *app = self.fetcher.apps[row];
    self.showInfoBarButton.collapsedRepresentation.hidden = NO;
    [self.infoBarTextView setString:app.desc];
    return YES;
}

@end
