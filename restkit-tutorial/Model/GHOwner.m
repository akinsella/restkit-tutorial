//
//  GHUser.h
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/29/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "GHOwner.h"

@implementation GHOwner

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]
                                                     usingBlock:^(RKObjectMapping *mapping) {
        [mapping mapAttributes:  @"login", @"gravatar_id", @"avatar_url", @"type", nil];
        [mapping mapKeyPathsToAttributes:  @"id", @"identifier", nil];
    }];
    return mapping;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@", self.identifier, self.login];
}

@end

