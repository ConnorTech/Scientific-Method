//
//  GlossaryViewController.m
//  Scientific Method
//
//  Created by John Kotz on 5/1/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "GlossaryViewController.h"
#import "Terms.h"

@interface GlossaryViewController (){
}

@end

@implementation GlossaryViewController
@synthesize terms,sections,glossary,searchBar,selection,filteredArray,terms2,termsFinal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // now you can use cell.textLabel.text self.selection.
    selection = cell.textLabel.text;
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"]];
    
    [plistDict setValue:selection forKey:@"selectedKey"];
    [plistDict writeToFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"] atomically: YES];
    [self performSegueWithIdentifier:@"Go" sender:self];
}

- (void)viewDidLoad
{
    terms2 = [NSArray array];
    self.terms = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"terms" ofType:@"plist"]];
    self.sections = [[NSMutableDictionary alloc] init];
    
    BOOL found;
    
    for (NSDictionary *term in self.terms) {
        NSString *c = [[term objectForKey:@"term"] substringToIndex:1];
        terms2 = [Terms termName:term];
        
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
    
    // Loop again and sort the books into their respective keys
    for (NSDictionary *term in self.terms)
    {
        [[self.sections objectForKey:[[term objectForKey:@"term"] substringToIndex:1]] addObject:term];
    }
    // Sort each section array
    for (NSString *key in [self.sections allKeys])
    {
        [[self.sections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"term" ascending:YES]]];
    }
                  
    self.termsFinal = [NSArray arrayWithArray:terms2];
    
    
    // Initialize the filteredArray with a capacity equal to the candyArray's capacity
    self.filteredArray = [NSMutableArray arrayWithCapacity:[termsFinal count]];
    
    [self.glossary reloadData];
    [super viewDidLoad];
	// Do any additional setup after loading the view
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return [[self.sections allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredArray count];
    } else {
        return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *term = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [filteredArray objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [term objectForKey:@"term"];
        cell.detailTextLabel.text = [term objectForKey:@"def"];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSLog(@"d");
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredArray removeAllObjects];
    // Filter the array using NSPredicate
    NSLog(@"d2");
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@",searchText];
    filteredArray = termsFinal;
    [filteredArray filterUsingPredicate:[NSPredicate predicateWithFormat:@" contains[cd] f"]];
    //filteredArray = [NSMutableArray arrayWithArray:[termsFinal filteredArrayUsingPredicate:predicate]];
    NSLog(@"d4");
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    NSLog(@"r");
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    NSLog(@"r2");
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    NSLog(@"e");
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    NSLog(@"e2");
    return YES;
}

@end
