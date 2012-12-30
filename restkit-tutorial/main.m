//
//  main.m
//  Restkit Tutorial
//
//  Created by Alexis Kinsella on 09/29/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "XBRestkitService.h"
#import "USArrayWrapper.h"
#import "GHRepository.h"
#import "NSDateFormatter+XBAdditions.h"

int main(int argc, const char * argv[]) {

    @autoreleasepool {

        // Initialize RestKit loggers
        RKLogConfigureByName("RestKit/*", RKLogLevelInfo);
        // RKLogConfigureByName("RestKit/UI", RKLogLevelWarning);
        // RKLogConfigureByName("RestKit/Network", RKLogLevelWarning);
        // RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelWarning);
        // RKLogConfigureByName("RestKit/ObjectMapping/JSON", RKLogLevelWarning);

        // Initialize RestKit Object Manager
        RKObjectManager *objectManager = [RKObjectManager managerWithBaseURLString:@"https://api.github.com"];

        // Initialize RestKit Object Mappings
        // Github date format: 2012-07-05T09:43:24Z
        // Already available in Restkit default formatters
        [RKObjectMapping addDefaultDateFormatter: [NSDateFormatter initWithDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"]];

        RKObjectMappingProvider *omp = [RKObjectManager sharedManager].mappingProvider;
        [omp addObjectMapping:[GHRepository mapping]];
        [omp setObjectMapping:[GHRepository mapping] forResourcePathPattern:@"/orgs/:organization/repos"];

        NSString *relativePath = [@"/orgs/:organization/repos" interpolateWithObject:@{@"organization": @"xebia-france"}];

        XBRestkitService *restkitService = [[XBRestkitService alloc] init];
        [restkitService loadArrayOfDataWithRelativePath:relativePath
             onLoad:^(NSArray *repositories) {
                 NSLog(@"Repository list from Network: ");
                 _array(repositories).each(^(GHRepository *repository) {
                     NSLog(@"* %@", [repository description]);
                 });
                 CFRunLoopStop(CFRunLoopGetMain());
             }
            onError:^(NSError *error) {
                NSLog(@"%@", error);
               CFRunLoopStop(CFRunLoopGetMain());
            }
        ];

        CFRunLoopRun();
    }

    return 0;
}