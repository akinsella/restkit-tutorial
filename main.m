//
//  main.m
//  Restkit Tutorial
//
//  Created by Alexis Kinsella on 09/29/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "RestKitTutorialApp.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        RestKitTutorialApp *application = [[RestKitTutorialApp alloc] init];
        [application fetchData];
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                  target:application
                                  selector:@selector(onTick:)
                                  userInfo:nil repeats:YES];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
        [runLoop run];
        
    }
    return 0;
}
