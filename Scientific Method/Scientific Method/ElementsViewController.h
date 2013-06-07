//
//  SecondViewController.h
//  Scientific Method
//
//  Created by Connor Koehler on 5/1/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElementsViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>{
    NSMutableDictionary *sections;
    NSMutableDictionary *sections2;
    NSMutableArray *elements;
    NSString *selection;
}

@property (nonatomic,retain) NSMutableDictionary *sectionsSearch;
@property (nonatomic,retain) NSMutableArray *elements;
@property (nonatomic,retain) IBOutlet UINavigationBar* navBar;
@property (nonatomic,retain) IBOutlet UITableView *elementsTableView;
@property (strong,nonatomic) NSMutableArray *filteredArray;
@property IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) NSArray *elementsArray;
@property (nonatomic,retain) NSMutableArray *elementsConversion;
@property (nonatomic,retain) NSArray *myTry;
@property(strong,nonatomic) NSMutableArray *sortedArray;
-(IBAction)periodicTable:(id)sender;



@end
