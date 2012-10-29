//
//  RestkitTutorialApp.m
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/29/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "RestKitTutorialApp.h"
#import <RestKit/RestKit.h>
#import "NSDateFormatter+XBAdditions.h"
#import "GHRepository.h"
#import "GHuser.h"
#import "USArrayWrapper.h"

NSString* const XBErrorDomain = @"fr.xebia.ErrorDomain";

@implementation RestKitTutorialApp

- (id) init {
    self = [super init];
    if (self) {
        [self initializeLoggers];
        [self initializeRestKit];
    }
    
    return self;
}


- (void)initializeLoggers {
    //  RKLogConfigureByName("RestKit/*", RKLogLevelInfo);
    //  RKLogConfigureByName("RestKit/UI", RKLogLevelWarning);
        RKLogConfigureByName("RestKit/Network", RKLogLevelWarning);
        RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelWarning);
    //  RKLogConfigureByName("RestKit/ObjectMapping/JSON", RKLogLevelTrace);
}

-(void)initializeRestKit {
    [self initializeObjectManager];
    [self initializeObjectMapping];
}

- (void)initializeObjectManager {

    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURLString:@"http://127.0.0.1:9000/v1.0/"];

    objectManager.client.cachePolicy = RKRequestCachePolicyEnabled;
    objectManager.client.requestCache.storagePolicy = RKRequestCacheStoragePolicyPermanently;
    [objectManager.client.requestCache invalidateAll];
}

- (void)initializeObjectMapping {

    // Github date format: 2012-07-05T09:43:24Z
    // Already available in Restkit default formatters
    [RKObjectMapping addDefaultDateFormatter: [NSDateFormatter initWithDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"]];

    RKObjectMappingProvider *omp = [RKObjectManager sharedManager].mappingProvider;

    RKObjectMapping *repositoryObjectMapping = [GHRepository mapping];
    [omp addObjectMapping:repositoryObjectMapping];
    [omp setObjectMapping:repositoryObjectMapping forResourcePathPattern:@"/github/orgs/:organization/repos"];
}

-(void)onTick:(NSTimer *)timer {
    NSLog(@"Tick: %@", [[NSDateFormatter initWithDateFormat:@"HH':'mm':'ss"] stringFromDate:[NSDate date]]);
}

-(void) fetchData {
    NSLog(@"Fetching GitHub Repository list: ");
    [self loadGithubRepositoriesForOrganization:@"xebia-france"
        onLoad:^(NSArray *repositories) {
            NSLog(@"Repository list from Network: ");
            _array(repositories).each(^(GHRepository *repository) {
                NSLog(@"* %@", repository.name);
            });
        }
        onError:^(NSError *error) {
            NSLog(@"%@", error);
        }];
}

- (void)loadGithubRepositoriesForOrganization: (NSString*)organization
                                       onLoad:(RKObjectLoaderDidLoadObjectsBlock)loadBlock
                                      onError:(RKRequestDidFailLoadWithErrorBlock)failBlock
{
    NSDictionary *params = [NSDictionary dictionaryWithKeysAndObjects: @"organization", organization, nil];
    NSString *url = [@"/github/orgs/:organization/repos" interpolateWithObject:params];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:url usingBlock:^(RKObjectLoader *loader) {
        loader.onDidLoadObjects = loadBlock;
        loader.onDidFailWithError = failBlock;
        loader.onDidFailLoadWithError = failBlock;
        loader.onDidLoadResponse = ^(RKResponse *response) {
            [self fireErrorBlock:failBlock onErrorInResponse:response];
        };
    }];
}

- (void)fireErrorBlock:(RKRequestDidFailLoadWithErrorBlock)failBlock onErrorInResponse:(RKResponse *)response {
    
    if (![response isOK]) {
        id parsedResponse = [response parsedBody:NULL];
        NSString *errorText = nil;
        if ([parsedResponse isKindOfClass:[NSDictionary class]]) {
            errorText = [parsedResponse objectForKey:@"error"];
        }
        if (errorText) {
            NSError *errorWithMessage = [NSError errorWithDomain:XBErrorDomain
                                                            code:[response statusCode]
                                                        userInfo:[NSDictionary dictionaryWithObject:errorText forKey:NSLocalizedDescriptionKey]];
            failBlock(errorWithMessage);
        }
    }
}

@end
