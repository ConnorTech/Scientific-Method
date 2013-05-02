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
@synthesize glossary,searchBar,bic;

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [listOfItems sortUsingDescriptors:sortDescriptors];
    
    // Set up the cell...
    NSString *cellValue = [listOfItems objectAtIndex:indexPath.row];
    cell.text = cellValue;
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view
    
    listOfItems = [[NSMutableArray alloc] init];
    
    //Add items
    [listOfItems addObject:@"Theory"];
    [listOfItems addObject:@"Law"];
    [listOfItems addObject:@"Experiment"];
    [listOfItems addObject:@"Emp"];
    [listOfItems addObject:@"2"];
    [listOfItems addObject:@"3"];
    [listOfItems addObject:@"4"];
    [listOfItems addObject:@"5"];
    
    self.navigationItem.title = @"Glossary";
}

-(IBAction)cellSelect:(id)sender{
    
//    [bic setValue:a forKey:];
//    
//    NSLog(@"%@", [bic objectForKey:a]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
