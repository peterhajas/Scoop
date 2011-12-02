//
//  SCTrackingView.h
//  Scoop
//
//  Created by Peter Hajas on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <TwUI/TUIKit.h>

@protocol SCTrackingViewHoverDelegate <NSObject>

-(void)mouseIsHovering;
-(void)mouseStoppedHovering;

@end

@interface SCTrackingView : TUINSView
{
    NSTrackingArea* trackingArea;
    
    id<SCTrackingViewHoverDelegate> delegate;
}

@property (readwrite, retain) id<SCTrackingViewHoverDelegate> delegate;

@end
