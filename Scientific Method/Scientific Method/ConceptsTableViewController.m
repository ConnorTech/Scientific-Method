//
//  ConceptsViewController.m
//  Scientific Method
//
//  Created by John Kotz on 5/23/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "ConceptsTableViewController.h"

@interface ConceptsTableViewController ()

@end

@implementation ConceptsTableViewController
@synthesize concepts,table,filteredArray,conceptsArray,conceptSelected;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *mmm = [NSString stringWithString:[[NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"]] objectForKey:@"selectedKey"]];
    self.concepts = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"concepts" ofType:@"plist"]];
    
    
    for (NSDictionary *new in self.concepts) {
        if ([[new objectForKey:@"name"] isEqualToString:mmm]) {
            self.conceptSelected = [NSMutableDictionary dictionaryWithDictionary:new];
        }
    }
    
    [self.table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    //(@"3");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    return [[conceptSelected objectForKey:@"info"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NULL;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //(@"10");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [[[conceptSelected objectForKey:@"info"] objectAtIndex:indexPath.row] objectForKey:@"details"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:",[[[conceptSelected objectForKey:@"info"] objectAtIndex:indexPath.row] objectForKey:@"name"]];
    //(@"11");
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [[[conceptSelected objectForKey:@"info"] objectAtIndex:indexPath.row] objectForKey:@"details"];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 20;
}

@end
