//
//  SCDisplayManager.h
//  Scoop
//
//  Created by Peter Hajas on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <TwUI/TUIKit.h>
#import "SCInfiniteScrollView.h"
#import "SCNewsItemView.h"

@interface SCDisplayManager : NSObject <SCInfiniteScrollViewDataSource>
{
    TUIView* containerView;
    CGRect viewFrame;
    SCInfiniteScrollView* scrollView;
}

-(id)initWithViewFrame:(CGRect)frame;

@property (nonatomic, readonly) TUIView* containerView;
@end
