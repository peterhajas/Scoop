//
//  SCFeedInterpreter.m
//  Scoop
//
//  Created by Peter Hajas on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCFeedInterpreter.h"

@implementation SCFeedInterpreter

@synthesize currentNewsItems;

-(id)initWithFeedAddress:(NSURL*)_feedAddress
{
    self = [super init];
    if(self)
    {
        feedAddress = _feedAddress;
        currentNewsItems = [[NSArray alloc] init];
        [self _update];
    }
    
    return self;
}

-(void)_update
{
    
}

@end
