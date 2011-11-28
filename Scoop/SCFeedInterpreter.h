//
//  SCFeedInterpreter.h
//  Scoop
//
//  Created by Peter Hajas on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCNewsItem.h"

@protocol SCFeedInterpreterDelegate <NSObject>

-(void)feedHasChanged;

@end

@interface SCFeedInterpreter : NSObject
{
    NSURL* feedAddress;
    NSArray* currentNewsItems;
}

-(id)initWithFeedAddress:(NSURL*)_feedAddress;
-(void)_update;

@property(nonatomic, readonly) NSArray* currentNewsItems;

@end
