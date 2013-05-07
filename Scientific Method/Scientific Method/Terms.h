//
//  Terms.h
//  Scientific Method
//
//  Created by John Kotz on 5/7/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Terms : NSObject{
    NSString *name;
}

@property (nonatomic, copy) NSString *name;

+ (id)candyOfCategory:(NSString*)category name:(NSString*)name;

@end
