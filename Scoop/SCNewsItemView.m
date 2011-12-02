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

#import "SCNewsItemView.h"

@implementation SCNewsItemView

-(id)initWithBackingNewsItem:(SCNewsItem*)_backingNewsItem
{
    self = [super initWithFrame:CGRectMake(0, 0, SCNewsItemWidth, SCNewsItemHeight)];
    if(self)
    {
        backingNewsItem = _backingNewsItem;
        
        headlineLabel = [[TUILabel alloc] initWithFrame:CGRectMake(10,
                                                                   10,
                                                                   SCNewsItemWidth - 20,
                                                                   SCNewsItemHeight - 20)];
        [headlineLabel setFont:[TUIFont boldSystemFontOfSize:17.0]];
        [headlineLabel setTextColor:[TUIColor whiteColor]];
        [headlineLabel setBackgroundColor:[TUIColor clearColor]];
        [headlineLabel setAlignment:TUITextAlignmentCenter];
        
        activateButton = [TUIButton button];
        [activateButton setFrame:[self frame]];
        
        [headlineLabel setText:[backingNewsItem headline]];
        [activateButton addTarget:self action:@selector(activate) forControlEvents:TUIControlEventTouchUpInside];
        
        // innerView is to give us a nice box outline for this news item
        
        innerView = [[TUIView alloc] initWithFrame:CGRectMake([self frame].origin.x + 1,
                                                              [self frame].origin.y + 1,
                                                              [self frame].size.width - 1, // For even borders
                                                              [self frame].size.height - 2)];
        
        [innerView setBackgroundColor:[TUIColor darkGrayColor]];
        
        [self setBackgroundColor:[TUIColor grayColor]];
        
        [self addSubview:innerView];
        [self addSubview:headlineLabel];
        [self addSubview:activateButton];
    }
    
    return self;
}

-(void)activate
{
    // Open the URL associated with this news item
    [[NSWorkspace sharedWorkspace] openURL:[backingNewsItem linkToItem]];
}

@end
