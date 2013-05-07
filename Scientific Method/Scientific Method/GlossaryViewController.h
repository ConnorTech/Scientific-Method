//
//  GlossaryViewController.h
//  Scientific Method
//
//  Created by John Kotz on 5/1/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlossaryViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSMutableDictionary *sections;
    NSMutableArray *terms;
    NSString *selection;
}

@property (nonatomic,retain) NSMutableDictionary *sections;
@property (nonatomic,retain) NSMutableArray *terms;
@property (nonatomic,retain) NSMutableArray *terms2;
@property (nonatomic,retain) NSString *selection;
@property (nonatomic,retain) IBOutlet UINavigationBar* navBar;
@property (nonatomic,retain) IBOutlet UITableView *glossary;
@property (strong,nonatomic) NSMutableArray *filteredArray;
@property IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) NSMutableArray *termsFinal;

@end
