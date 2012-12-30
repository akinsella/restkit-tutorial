//
//  NSError+XBAdditions.m
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/29/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//
#import "NSError+XBAdditions.h"


@implementation NSError (XBAdditions)

- (NSString *)debugDescription;
{
    NSMutableDictionary *dictionaryRep = [[self userInfo] mutableCopy];

    [dictionaryRep setObject:[self domain]
                      forKey:@"domain"];
    [dictionaryRep setObject:[NSNumber numberWithInteger:[self code]]
                      forKey:@"code"];

    NSError *underlyingError = [[self userInfo] objectForKey:NSUnderlyingErrorKey];
    NSString *underlyingErrorDescription = [underlyingError debugDescription];
    if (underlyingErrorDescription)
    {
        [dictionaryRep setObject:underlyingErrorDescription
                          forKey:NSUnderlyingErrorKey];
    }

    NSString *result = [dictionaryRep description];
    
    return result;
}

@end