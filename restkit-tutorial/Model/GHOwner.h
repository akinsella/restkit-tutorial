//
// Created by akinsella on 13/12/12.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <RestKit/RestKit.h>

@interface GHOwner : NSObject

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *gravatar_id;
@property (nonatomic, strong) NSString *avatar_url;
@property (nonatomic, strong) NSString *type;

+ (RKObjectMapping *)mapping;

@end