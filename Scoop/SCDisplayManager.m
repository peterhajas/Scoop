//
//  SCDisplayManager.m
//  Scoop
//
//  Created by Peter Hajas on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

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

-(void)didMoveToSuperview
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
