//
//  SCBorderlessWindow.h
//  Scoop
//
//  Created by Peter Hajas on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface SCBorderlessWindow : NSWindow

-(id)initWithContentRect:(NSRect)contentRect;
-(void)goToTop;
-(void)goToBottom;

@end
