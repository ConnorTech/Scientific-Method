//
//  GlossaryViewController.h
//  Scientific Method
//
//  Created by John Kotz on 5/1/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlossaryViewController : UIViewController

@property (nonatomic,retain) IBOutlet UITableView *glossary;
@property (nonatomic,retain) IBOutlet UISearchBar *searchBar;
-(IBAction)cellSelect:(id)sender;
@property (nonatomic) NSMutableDictionary *bic;


@end
