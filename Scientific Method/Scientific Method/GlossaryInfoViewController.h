//
//  GlossaryInfoViewController.h
//  Scientific Method
//
//  Created by John Kotz on 5/3/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlossaryInfoViewController : UIViewController{
    NSString *selection;
    NSMutableArray *terms;
}

@property (nonatomic,retain) NSString *selection;
@property (nonatomic,retain) NSMutableArray *terms;
@property (nonatomic,retain) IBOutlet UINavigationItem *navBar;
@property (nonatomic,retain) IBOutlet UILabel *termLabel;
@property (nonatomic,retain) IBOutlet UITextView *definition;

@end
