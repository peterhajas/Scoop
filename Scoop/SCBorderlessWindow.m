//
//  SCBorderlessWindow.m
//  Scoop
//
//  Created by Peter Hajas on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCBorderlessWindow.h"

@implementation SCBorderlessWindow

-(id)initWithContentRect:(NSRect)contentRect
{
    self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
    if(self)
    {
        
    }
    return self;
}

-(void)goToTop
{
    NSRect screenRect = [[NSScreen mainScreen] visibleFrame];    
    [self setFrameOrigin:NSMakePoint([self frame].origin.x, 
                                     screenRect.origin.y + screenRect.size.height - [self frame].size.height)];
}

-(void)goToBottom
{
    NSRect screenRect = [[NSScreen mainScreen] visibleFrame];
    [self setFrameOrigin:NSMakePoint([self frame].origin.x, screenRect.origin.y)];
}

@end
