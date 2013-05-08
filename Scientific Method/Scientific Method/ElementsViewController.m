//
//  SecondViewController.m
//  Scientific Method
//
//  Created by Connor Koehler on 5/1/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "ElementsViewController.h"

@interface ElementsViewController ()

@end

@implementation ElementsViewController
@synthesize elements,sections,searchBar,sectionsSearch,selection,navBar,elementsTableView,filteredArray,elementsArray,elementsConversion;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // now you can use cell.textLabel.text self.selection.
    selection = cell.textLabel.text;
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"]];
    
    [plistDict setValue:selection forKey:@"selectedKey2"];
    [plistDict writeToFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"] atomically: YES];
    [self performSegueWithIdentifier:@"Go2" sender:self];
}

- (void)viewDidLoad
{
    self.elements = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"elements" ofType:@"plist"]];
    self.sections = [[NSMutableDictionary alloc] init];
    self.sectionsSearch = [[NSMutableDictionary alloc] init];
    
    BOOL found;
    NSLog(@"%@", elements);
    
    self.elementsConversion = [NSMutableArray array];
    for (NSDictionary *element in self.elements) {
        NSLog(@"%@", element);
        [elementsConversion addObject:[element objectForKey:@"name"]];
    }
    
    for (NSDictionary *element in self.elements) {
        NSString *c = [[element objectForKey:@"name"] substringToIndex:1];
        
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
    
    // Loop again and sort the elements into their respective keys
    for (NSDictionary *element in self.elements)
    {
        [[self.sections objectForKey:[[element objectForKey:@"name"] substringToIndex:1]] addObject:element];
    }
    // Sort each section array
    for (NSString *key in [self.sections allKeys])
    {
        [[self.sections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    }
    self.elementsArray = [NSArray arrayWithArray:elementsConversion];
    [self.elementsTableView reloadData];
    self.filteredArray = [NSMutableArray array];
    NSLog(@"1");
    [super viewDidLoad];
	// Do any additional setup after loading the view
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"2");
    if (tableView != self.searchDisplayController.searchResultsTableView){
        return [[self.sections allKeys] count];
    }else if (filteredArray != nil){
        return 1;
    }else{
        return [[self.sections allKeys] count];
    }
    NSLog(@"3");
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"4");
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
    }else{
        return @"Results";
    }
    
    NSLog(@"5");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    NSLog(@"6");
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredArray count];
    } else {
        return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
    }
    NSLog(@"7");
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSLog(@"8");
    if (tableView != self.searchDisplayController.searchResultsTableView){
        return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }else{
        return [[self.sectionsSearch allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    NSLog(@"9");
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"10");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDictionary *element;
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        element = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }else{
        NSString *new;
        new = [filteredArray objectAtIndex:indexPath.row];
        element = [NSDictionary dictionaryWithObject:new forKey:@"name"];
    }
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    NSLog(@"1 - %@", element);
    if (tableView == self.searchDisplayController.searchResultsTableView) {
    } else {
        cell.detailTextLabel.text = [element objectForKey:@"abv"];
    }
    cell.textLabel.text = [element objectForKey:@"name"];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    NSLog(@"11");
    return cell;
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"12");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"13");
}


#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSLog(@"14");
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    filteredArray = [NSMutableArray arrayWithArray:[elementsArray filteredArrayUsingPredicate:predicate]];
    NSLog(@"15");
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    NSLog(@"16");
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    [sections2 setValue:@"Results" forKey:@"Results"];
    
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    NSLog(@"18");
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    NSLog(@"19");
    return YES;
}

@end
