//
//  ISResultsTableView.m
//  IPASearch
//
//  Created by Wang Jinli on 2016/10/29.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "ISResultsTableView.h"

@implementation ISResultsTableView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)keyDown:(NSEvent *)event {
    unichar  u = [[event charactersIgnoringModifiers] characterAtIndex: 0];
    if (u == NSCarriageReturnCharacter) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReturnKeyPressed" object:self];
    }
    else {
        [super keyDown:event];
    }
}

@end
