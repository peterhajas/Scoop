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

#import "SCAppDelegate.h"

@implementation SCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    CGRect frame = CGRectMake(0, 0, 600, 100);
    window = [[NSWindow alloc] initWithContentRect:frame styleMask:NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask backing:NSBackingStoreBuffered defer:NO];
    
    [window setReleasedWhenClosed:NO];
    [window center];
    
    // Our scrollview container view
    scrollViewContainer = [[TUINSView alloc] initWithFrame:frame];
    
    // Our container TUIView
    containerView = [[TUIView alloc] initWithFrame:frame];
    
    // And our scrollview!
    scrollView = [[SCInfiniteScrollView alloc] initWithDataSource:self];
    [scrollView setAutoresizingMask:TUIViewAutoresizingFlexibleSize];
    
    [scrollView setFrame:CGRectMake(0,0,600,100)];
    
    [window setContentView:scrollViewContainer];
    [scrollViewContainer setRootView:containerView];
    
    [scrollView reloadData];
    
    [containerView addSubview:scrollView];
    
    [containerView setBackgroundColor:[TUIColor orangeColor]];
    
    [window makeKeyAndOrderFront:nil];
        
    //scrollView.horizontalScrollIndicatorVisibility = TUIScrollViewIndicatorVisibleNever;
    //[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(move) userInfo:nil repeats:YES];
}

-(NSUInteger)numberOfViews
{
    return 20;
}

-(CGRect)viewRectForViewAtIndex:(NSUInteger)index
{
    return [[self viewAtIndex:index] frame];
}

-(TUIView*)viewAtIndex:(NSUInteger)index
{
    NSLog(@"asked for view at index: %lu", index);
    
    // Load the image
    
    NSImage* cocoaImage = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:[NSString stringWithFormat:@"%d", index%10]]];
    CGImageRef imageRef = [cocoaImage CGImageForProposedRect:nil context:nil hints:nil];
    TUIImage* image = [[TUIImage alloc] initWithCGImage:imageRef];
    
    TUIImageView* imageView = [[TUIImageView alloc] initWithImage:image];

    return imageView;
}

/*
-(void)move
{
    float x = scrollView.contentOffset.x;
    x-=0.5;
    [scrollView setContentOffset:CGPointMake(x, 0)];
}
*/
@end
