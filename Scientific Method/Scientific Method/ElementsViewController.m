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
@synthesize elements,searchBar,sectionsSearch,navBar,elementsTableView,filteredArray,elementsArray,elementsConversion,sortedArray,myTry;

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
    self.sortedArray = [[NSMutableArray alloc] init];
    self.sectionsSearch = [[NSMutableDictionary alloc] init];
    self.myTry = [NSArray array];
    
    if (elements == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No access to plist files!" message:@"The plist files could not be accessed. Please contact developer for more information."
                                                       delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        [alert show];
    }
    
    self.elementsConversion = [NSMutableArray array];
    NSMutableArray *newConverter = [NSMutableArray array];
    
    [self.sortedArray removeAllObjects];
    
    for (NSMutableDictionary *element in self.elements) {
        [elementsConversion addObject:[element objectForKey:@"name"]];
    }
    for (NSMutableDictionary *element in self.elements) {
        [newConverter addObject:[element objectForKey:@"atomicNumber"]];
    }
    
    NSMutableArray *new = [[NSMutableArray alloc] init];
    
    for (NSDictionary *element in self.elements) {
        //[self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
        [new addObject:element];
    }
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"atomicNumber" ascending:YES];
    NSSortDescriptor *sort2 = [[NSSortDescriptor alloc] initWithKey:@"" ascending:YES];
    //self.sortedArray = [NSMutableArray arrayWithArray:[new sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]]];
    self.sortedArray = new;
    //[sortedArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    self.myTry = newConverter;
    
    //self.myTry = [NSArray arrayWithArray:[newConverter sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort2]]];
    self.elementsArray = [NSArray arrayWithArray:elementsConversion];
    [self.elementsTableView reloadData];
    self.filteredArray = [NSMutableArray array];
    //(@"1");
    [super viewDidLoad];
    // Do any additional setup after loading the view
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //(@"4");
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        return NULL;
    }else{
        return @"Results";
    }
    
    //(@"5");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    //(@"6");
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredArray count];
    } else {
        return [sortedArray count];
    }
    //(@"7");
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //(@"8");
    if (tableView != self.searchDisplayController.searchResultsTableView){
        return NULL;
    }else{
        return [[self.sectionsSearch allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    //(@"9");
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //(@"10");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDictionary *element;
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        element = [sortedArray objectAtIndex:indexPath.row];
    }else if (searchBar.selectedScopeButtonIndex == 0){
        for (NSDictionary *element in self.elements) {
            if ([[element objectForKey:@"name"] isEqualToString:[filteredArray objectAtIndex:indexPath.row]]) {
                cell.textLabel.text = [element objectForKey:@"name"];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[element objectForKey:@"atomicNumber"]];
            }
        }
    }else{
        for (NSDictionary *element in self.elements) {
            if ([element objectForKey:@"atomicNumber"] == [filteredArray objectAtIndex:indexPath.row]) {
                cell.textLabel.text = [element objectForKey:@"name"];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[filteredArray objectAtIndex:indexPath.row]];
            }
        }
    }
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [element objectForKey:@"atomicNumber"]];
        cell.textLabel.text = [element objectForKey:@"name"];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    //(@"11");
    return cell;
}

- (void)didReceiveMemoryWarning
{
    //(@"12");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //(@"13");
}
//h

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    //(@"14");
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredArray removeAllObjects];
    // Filter the array using NSPredicate
    
    NSPredicate *predicate;
    if (searchBar.selectedScopeButtonIndex == 0){
        predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
        filteredArray = [NSMutableArray arrayWithArray:[elementsArray filteredArrayUsingPredicate:predicate]];
    }else{
        //(@"%@", myTry);
        for (NSString *b in self.myTry) {
            NSNumber *try;
            try = [NSNumber numberWithInt:[b integerValue]];
            if (try == [NSNumber numberWithInt:[searchText integerValue]]) {
                [filteredArray addObject:try];
            }
        }
    }
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
