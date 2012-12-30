//
//  NSDateFormatter+XBAdditions.m
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/29/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "NSDateFormatter+XBAdditions.h"

@implementation NSDateFormatter (XBAdditions)

+(NSDateFormatter *)initWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return dateFormatter;
}

@end