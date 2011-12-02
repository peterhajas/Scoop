//
//  SCTrackingView.m
//  Scoop
//
//  Created by Peter Hajas on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCTrackingView.h"

@implementation SCTrackingView

@synthesize delegate;

-(id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if(self)
    {
        trackingArea = [[NSTrackingArea alloc] initWithRect:frameRect
                                                    options:NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways
                                                      owner:self 
                                                   userInfo:nil];
        [self addTrackingArea:trackingArea];
    }
    return self;
}

-(void)mouseEntered:(NSEvent *)theEvent
{
    if(delegate)
    {
        [delegate mouseIsHovering];
    }
}

-(void)mouseExited:(NSEvent *)theEvent
{
    if(delegate)
    {
        [delegate mouseStoppedHovering];
    }
}

@end
