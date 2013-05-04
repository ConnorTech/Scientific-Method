//
//  GlossaryViewController.h
//  Scientific Method
//
//  Created by John Kotz on 5/1/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlossaryViewController : UIViewController
{
    NSMutableDictionary *sections;
    NSMutableArray *terms;
    NSString *selection;
}

@property (nonatomic,retain) NSMutableDictionary *sections;
@property (nonatomic,retain) NSMutableArray *terms;
@property (nonatomic,retain) NSString *selection;

@end
