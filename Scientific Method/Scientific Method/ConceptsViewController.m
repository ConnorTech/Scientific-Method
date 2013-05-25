//
//  ConceptsViewController.m
//  Scientific Method
//
//  Created by John Kotz on 5/23/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "ConceptsViewController.h"

@interface ConceptsViewController ()

@end

@implementation ConceptsViewController
@synthesize sections,sections2,sectionsSearch,concepts,table,filteredArray,conceptsArray;

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
    self.concepts = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"concepts" ofType:@"plist"]];
    self.sections = [[NSMutableDictionary alloc]init];
    self.sections2 = [[NSMutableDictionary alloc]init];
    self.filteredArray = [NSMutableArray array];
    
    
    NSMutableArray *termsConversion = [NSMutableArray array];
    for (NSDictionary *concept in self.concepts) {
        [termsConversion addObject:[concept objectForKey:@"name"]];
    }
    
    BOOL found;
    
    for (NSDictionary *concept in self.concepts) {
        NSString *c = [concept objectForKey:@"type"];
        
        found = NO;
        
        for (NSString *str in [self.sections allKeys]) {
            if ([str isEqualToString:c]) {
                found = YES;
            }
        }
        if (!found) {
            [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
        }
    }
    
    // Loop again and sort the concepts into their respective keys
    for (NSDictionary *concept in self.concepts)
    {
        [[self.sections objectForKey:[concept objectForKey:@"type"]] addObject:concept];
    }
    // Sort each section array
    for (NSString *key in [self.sections allKeys])
    {
        [[self.sections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"type" ascending:YES]]];
    }
    self.conceptsArray = [NSArray arrayWithArray:termsConversion];
    [self.table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //(@"2");
    if (tableView != self.searchDisplayController.searchResultsTableView){
        return [[self.sections allKeys] count];
    }else if (filteredArray != nil){
        return 1;
    }else{
        return [[self.sections allKeys] count];
    }
    //(@"3");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    //(@"6");
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredArray count];
    } else {
        return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
    }
    //(@"7");
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //(@"4");
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
    }else{
        return [[[self.sectionsSearch allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
    }
    
    //(@"5");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //(@"10");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDictionary *concept;
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        concept = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }else{
        NSString *new;
        new = [filteredArray objectAtIndex:indexPath.row];
        concept = [NSDictionary dictionaryWithObject:new forKey:@"name"];
    }
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
    } else {
        cell.detailTextLabel.text = [concept objectForKey:@"type"];
    }
    cell.textLabel.text = [concept objectForKey:@"name"];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    //(@"11");
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // now you can use cell.textLabel.text self.selection.
    NSString *selection;
    selection = cell.textLabel.text;
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"]];
    
    [plistDict setValue:selection forKey:@"selectedKey"];
    [plistDict writeToFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"] atomically: YES];
    [self performSegueWithIdentifier:@"concepts" sender:self];
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    //(@"14");
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    filteredArray = [NSMutableArray arrayWithArray:[conceptsArray filteredArrayUsingPredicate:predicate]];
    //(@"15");
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    //(@"16");
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    [sections2 setValue:@"Results" forKey:@"Results"];
    
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    //(@"18");
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    //(@"19");
    return YES;
}

@end
