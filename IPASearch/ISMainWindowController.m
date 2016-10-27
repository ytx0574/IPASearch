//
//  ViewController.m
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/27.
//  Copyright © 2016年 Wang Jinli. All rights reserved.
//

#import "ISMainWindowController.h"

@implementation ISMainWindowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Remove table header view.
    [self.resultsTableView.headerView removeFromSuperview];
    self.resultsTableView.headerView = nil;
    [self.resultsTableView reloadData];
    self.searchField.delegate = self;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)searchAnswer:(id)sender {
    NSLog(@"search answer: %@", [self.searchField stringValue]);
}


@end
