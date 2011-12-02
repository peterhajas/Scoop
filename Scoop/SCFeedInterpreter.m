//
//  SCFeedInterpreter.m
//  Scoop
//
//  Created by Peter Hajas on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCFeedInterpreter.h"

@implementation SCFeedInterpreter

-(id)initWithDelegate:(id)_delegate;
{
    self = [super init];
    if(self)
    {
        client = [PSClient applicationClient];
        feedAddress = nil;
        [client setDelegate:self];
    }
    
    return self;
}

-(void)setFeedAddress:(NSURL *)_feedAddress
{
    // Remove the feed address that was there, if there was one
    [client removeFeed:[client feedWithURL:feedAddress]];
    feedAddress = _feedAddress;
    [client addFeedWithURL:feedAddress];
    
    // Reconfigure the settings to refresh reasonably frequently
    PSFeed* feed = [client feedWithURL:feedAddress];
    PSFeedSettings* feedSettings = [feed settings];
    
    // Expire after 15 days
    [feedSettings setExpirationInterval:1296000];
    // Refresh every 15 minutes
    [feedSettings setRefreshInterval:900];
    
    // Restore settings
    [feed setSettings:feedSettings];
}

-(NSURL*)feedAddress
{
    return feedAddress;
}

-(void)feedDidBeginRefresh:(PSFeed*)feed
{
    [delegate feedHasUpdateStatus:YES];
}
-(void)feedDidEndRefresh:(PSFeed*)feed
{
    [delegate feedHasUpdateStatus:NO];
    
    // Build the array of changed items
    NSMutableArray* refreshedItems = [[NSMutableArray alloc] init];
    for(PSEntry* entry in [feed entries])
    {
        // Create an SCNewsItem for each PSEntry
        SCNewsItem* newsItem = [[SCNewsItem alloc] initWithHeadline:[entry title] 
                                                    newsDescription:[[entry content] plainTextString]
                                                      andLinkToItem:[entry alternateURL]];
        [refreshedItems addObject:newsItem];
    }
    [delegate feedHasChangedWithNewsItems:[NSArray arrayWithArray:refreshedItems]];
}

-(void)feed:(PSFeed*)feed didAddEntries:(NSArray*)entries
{
    [delegate feedHasNewItems];
}

@end
