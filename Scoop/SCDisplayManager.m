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

#import "SCDisplayManager.h"

@implementation SCDisplayManager

@synthesize containerView;

-(id)initWithViewFrame:(CGRect)frame
{
    self = [super init];
    if(self)
    {
        viewFrame = frame;
    }
    return self;
}

-(void)prepareViews
{
    // Our containerView
    containerView = [[TUIView alloc] initWithFrame:viewFrame];
    [containerView setBackgroundColor:[TUIColor darkGrayColor]];
    
    // Create the scrollView
    scrollView = [[SCInfiniteScrollView alloc] initWithDataSource:self];
    [scrollView setAutoresizingMask:TUIViewAutoresizingFlexibleSize];
    
    [scrollView setFrame:viewFrame];
    [containerView addSubview:scrollView];    
    [scrollView reloadData];
}

-(NSUInteger)numberOfViews
{
    return 10;
}

-(TUIView*)viewAtIndex:(NSUInteger)index
{    
    // Create the SCNewsItem
    
    SCNewsItem* newsItem = [[SCNewsItem alloc] initWithHeadline:[NSString stringWithFormat:@"Headline %lu", index] newsDescription:@"Description" andLinkToItem:[NSURL URLWithString:@"localhost"]];
    SCNewsItemView* newsItemView = [[SCNewsItemView alloc] initWithBackingNewsItem:newsItem];
    
    return newsItemView;
}


@end
