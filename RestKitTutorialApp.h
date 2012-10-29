//
//  RestkitTutorialApp.h
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/29/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface RestKitTutorialApp : NSObject
-(void)onTick:(NSTimer *)timer;
-(void) fetchData;
@end