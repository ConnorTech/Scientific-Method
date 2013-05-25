//
//  ConceptsViewController.h
//  Scientific Method
//
//  Created by John Kotz on 5/23/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConceptsViewController : UITableViewController{
    NSMutableArray *concepts;
    NSMutableDictionary *sections;
    NSMutableDictionary *sections2;
}

@property (nonatomic,retain) NSMutableArray *concepts;
@property (nonatomic,retain) NSMutableDictionary *sections;
@property (nonatomic,retain) NSMutableDictionary *sectionsSearch;
@property (nonatomic,retain) NSMutableDictionary *sections2;
@property (nonatomic,retain) IBOutlet UITableView *table;
@property (strong,nonatomic) NSMutableArray *filteredArray;
@property (nonatomic,retain) NSMutableArray *conceptsArray;

@end
