//
//  ConceptsTableViewController.h
//  Scientific Method
//
//  Created by John Kotz on 6/4/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConceptsTableViewController : UITableViewController{
    NSMutableArray *concepts;
    NSMutableDictionary *sections;
    NSMutableDictionary *conceptSelected;
}

@property (nonatomic,retain) NSMutableArray *concepts;
@property (nonatomic,retain) NSMutableDictionary *conceptSelected;
@property (nonatomic,retain) IBOutlet UITableView *table;
@property (strong,nonatomic) NSMutableArray *filteredArray;
@property (nonatomic,retain) NSMutableArray *conceptsArray;

@end
