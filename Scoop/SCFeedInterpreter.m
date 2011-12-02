/*
 Copyright (c) 2011, Peter Hajas
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * Neither the name of the Peter Hajas nor the
 names of its contributors may be used to endorse or promote products
 derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL PETER HAJAS BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
