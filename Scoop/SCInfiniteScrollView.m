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

#import "SCInfiniteScrollView.h"

@implementation SCInfiniteScrollView


-(id)initWithDataSource:(id<SCInfiniteScrollViewDataSource>) _dataSource
{
    self = [super init];
    if(self)
    {
        scrollView = [[TUIScrollView alloc] initWithFrame:CGRectMake(0,0,1,1)];
        [scrollView setDelegate:self];
        totalViewWidth = 0.0;
        [self addSubview:scrollView];
        dataSource = _dataSource;
    }
    
    return self;
}

-(void)reloadData
{
    NSLog(@"reload data called!");
    
    // Loop through the number of views that the data source says we have
    
    for(TUIView* view in [scrollView subviews])
    {
        [view removeFromSuperview];
    }
    
    CGFloat tallestViewHeight = 0.0;
    
    // Find the tallest view and total view width
    
    for(NSUInteger i = 0; i < [dataSource numberOfViews]; i++)
    {
        TUIView* currentView = [dataSource viewAtIndex:i];
        
        // For each view, record its width and height
        CGFloat width  = [currentView frame].size.width;
        CGFloat height = [currentView frame].size.height;
        
        // Add the width to our "running" global width
        
        totalViewWidth+=width;
        
        // If height is greater than tallestViewHeight, record it
        
        if(height > tallestViewHeight)
        {
            tallestViewHeight = height;
        }
    }
    
    // Now that we know the total view width and the tallest view, set content size
    
    [scrollView setContentSize:CGSizeMake(totalViewWidth * 3, tallestViewHeight)];
    
    // And set content offset
    
    [scrollView setContentOffset:CGPointMake(totalViewWidth, 0.0)];
    
    [scrollView setFrame:[self frame]];
    
    CGFloat runningViewTotalWidth = 0.0;
    
    for(NSUInteger i = 0; i < [dataSource numberOfViews]; i++)
    {
        // Create the three views we'll need (to preserve the "infinite" illusion)

        TUIView* leftView = [dataSource viewAtIndex:i];
        TUIView* centerView = [dataSource viewAtIndex:i];
        TUIView* rightView  = [dataSource viewAtIndex:i];
        
        CGRect viewFrame   = [leftView frame];
        CGPoint viewOrigin = viewFrame.origin;
        CGSize viewSize    = viewFrame.size;
        
        // Set their frames appropriately
        
        [leftView setFrame:CGRectMake(viewOrigin.x + runningViewTotalWidth,
                                      viewOrigin.y,
                                      viewSize.width,
                                      viewSize.height)];
        
        [centerView setFrame:CGRectMake(viewOrigin.x + runningViewTotalWidth + totalViewWidth,
                                        viewOrigin.y,
                                        viewSize.width,
                                        viewSize.height)];
        
        [rightView setFrame:CGRectMake(viewOrigin.x + runningViewTotalWidth + 2 * totalViewWidth,
                                       viewOrigin.y,
                                       viewSize.width,
                                       viewSize.height)];
        
        runningViewTotalWidth += viewSize.width;
        
        // Add them to the view collection
        
        // TODO: Do we need to do this?!
        
        // Add them to the scrollview
        
        [scrollView addSubview:leftView];
        [scrollView addSubview:centerView];
        [scrollView addSubview:rightView];
    }

}

- (void)scrollViewDidScroll:(TUIScrollView *)view
{
    // Change content offset to preserve the illusion
    
    float x = [view contentOffset].x;
    
    if(x > -1 * totalViewWidth)
    {
        [view setContentOffset:CGPointMake(x - totalViewWidth, 0)];
    }
    if(x < -2 * totalViewWidth)
    {
        [view setContentOffset:CGPointMake(x + totalViewWidth, 0)];
    }
}

-(CGPoint)contentOffset
{
    return [scrollView contentOffset];
}

-(CGSize)contentSize
{
    return [scrollView contentSize];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [scrollView setFrame:frame];
}

@end
