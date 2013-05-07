//
//  Terms.m
//  Scientific Method
//
//  Created by John Kotz on 5/7/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "Terms.h"

@implementation Terms
@synthesize name;

+ (id)termName:(NSString*)name{
    Terms *newTerm = [[self alloc] init];
    newTerm.name = name;
    return newTerm;
}

@end
