//
//  RestkitTutorialApp.h
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/29/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "RestKit.h"

typedef void(^XBRequestDidFailWithErrorBlock)(NSError *error);
typedef void(^XBRequestDidLoadObjectsBlock)(NSArray *objects);

@interface XBRestkitService : NSObject

- (void)loadArrayOfDataWithRelativePath:(NSString *)url
                                 onLoad:(XBRequestDidLoadObjectsBlock)loadBlock
                                onError:(XBRequestDidFailWithErrorBlock)failBlock;

@end