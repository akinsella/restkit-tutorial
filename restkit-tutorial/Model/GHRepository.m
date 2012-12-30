//
//  GHRepository.m
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/29/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "GHRepository.h"

@implementation GHRepository

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ [%@ / %@ Forks / %@ Watchers / %@ issues]", self.name, self.language, self.forks, self.watchers, self.open_issues];
}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class] usingBlock:^(RKObjectMapping *mapping) {
        [mapping mapAttributes:
                @"created_at", @"fork", @"forks", @"full_name", @"has_downloads", @"has_issues", @"has_wiki",
                @"git_url", @"homepage", @"html_url", @"language", @"name", @"open_issues",
                @"pushed_at", @"size", @"updated_at", @"url", @"watchers", nil];
        [mapping mapKeyPathsToAttributes:
            @"id", @"identifier",
            nil];
    }];
    // Relationships
    [mapping hasMany:@"owner" withMapping:[GHOwner mapping]];
    
    return mapping;
}

@end

