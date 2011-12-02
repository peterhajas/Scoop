//
//  SCFeedInterpreter.h
//  Scoop
//
//  Created by Peter Hajas on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PubSub/PubSub.h>
#import "SCNewsItem.h"

@protocol SCFeedInterpreterDelegate <NSObject>

-(void)feedHasChangedWithNewsItems:(NSArray*)newsItems;
-(void)feedHasUpdateStatus:(BOOL)isUpdating;
-(void)feedHasNewItems;

@end

@interface SCFeedInterpreter : NSObject
{
    PSClient* client;
    
    NSURL* feedAddress;
    
    id<SCFeedInterpreterDelegate> delegate;
}

-(id)initWithDelegate:(id)_delegate;

@property (readwrite, retain) NSURL* feedAddress;

@end
