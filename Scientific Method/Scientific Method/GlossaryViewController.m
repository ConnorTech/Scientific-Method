//
//  GlossaryViewController.m
//  Scientific Method
//
//  Created by John Kotz on 5/1/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "GlossaryViewController.h"

@interface GlossaryViewController (){
    NSMutableArray *listOfItems;
}

@end

@implementation GlossaryViewController
@synthesize glossary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell...
    NSString *cellValue = [listOfItems objectAtIndex:indexPath.row];
    cell.text = cellValue;
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    listOfItems = [[NSMutableArray alloc] init];
    
    //Add items
    [listOfItems addObject:@"Iceland"];
    [listOfItems addObject:@"Greenland"];
    [listOfItems addObject:@"Switzerland"];
    [listOfItems addObject:@"Norway"];
    [listOfItems addObject:@"New Zealand"];
    [listOfItems addObject:@"Greece"];
    [listOfItems addObject:@"Rome"];
    [listOfItems addObject:@"Ireland"];
    
    self.navigationItem.title = @"Countries";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
