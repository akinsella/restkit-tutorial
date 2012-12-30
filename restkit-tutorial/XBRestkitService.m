//
//  RestkitTutorialApp.m
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/29/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "XBRestkitService.h"
#import <RestKit/RestKit.h>

NSString* const XBErrorDomain = @"fr.xebia.ErrorDomain";

@implementation XBRestkitService

- (void)loadArrayOfDataWithRelativePath:(NSString *)url
                                 onLoad:(XBRequestDidLoadObjectsBlock)loadBlock
                                onError:(XBRequestDidFailWithErrorBlock)failBlock
{
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
                                                        userInfo:[NSDictionary dictionaryWithObject:errorText
                                                                                             forKey:NSLocalizedDescriptionKey]];
            failBlock(errorWithMessage);
        }
    }
}

@end
