//
//  GlossaryViewController.m
//  Scientific Method
//
//  Created by John Kotz on 5/1/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "GlossaryViewController.h"
//#import "Terms.h"

@interface GlossaryViewController (){
}

@end

@implementation GlossaryViewController
@synthesize terms,sections,glossary,searchBar,selection,filteredArray,termsArray,termsConversion,sectionsSearch;

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

    selection = cell.textLabel.text;
    
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"]];
    
    [plistDict setValue:selection forKey:@"selectedKey"];
    
    NSString * path = nil;
    path = [(NSString *) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Selected.plist"];
    
    
    NSLog(@"%@", plistDict);
    [plistDict writeToFile:path atomically:YES];
    if ([plistDict writeToFile:path atomically:YES]) {
        NSLog(@"H");
        NSLog(@"%@",path);
        [plistDict writeToFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"] atomically:YES];
    }
    
    plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"]];
    
    NSLog(@"%@", plistDict);
    
    [self performSegueWithIdentifier:@"Go" sender:self];
}

- (void)viewDidLoad
{
    self.terms = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"terms" ofType:@"plist"]];
    self.sections = [[NSMutableDictionary alloc] init];
    self.sectionsSearch = [[NSMutableDictionary alloc] init];
    
    if (terms == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No access to plist files!" message:@"The plist files could not be accessed. Please contact developer for more information."
                                                           delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        [alert show];
    }
    
    BOOL found;
    
    self.termsConversion = [NSMutableArray array];
    for (NSDictionary *term in self.terms) {
        [termsConversion addObject:[term objectForKey:@"term"]];
    }
    
    for (NSDictionary *term in self.terms) {
        NSString *c = [[term objectForKey:@"term"] substringToIndex:1];
        
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
    
    // Loop again and sort the terms into their respective keys
    for (NSDictionary *term in self.terms)
    {
        [[self.sections objectForKey:[[term objectForKey:@"term"] substringToIndex:1]] addObject:term];
    }
    // Sort each section array
    for (NSString *key in [self.sections allKeys])
    {
        [[self.sections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"term" ascending:YES]]];
    }
    self.termsArray = [NSArray arrayWithArray:termsConversion];
    [self.glossary reloadData];
    self.filteredArray = [NSMutableArray array];
    //(@"1");
    [super viewDidLoad];
	// Do any additional setup after loading the view
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //(@"4");
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
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
        return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
    }
    //(@"7");
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //(@"8");
    if (tableView != self.searchDisplayController.searchResultsTableView){
        return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
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
    NSDictionary *term;
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        term = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }else{
        NSString *new;
        new = [filteredArray objectAtIndex:indexPath.row];
        term = [NSDictionary dictionaryWithObject:new forKey:@"term"];
    }
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array

    if (tableView == self.searchDisplayController.searchResultsTableView) {
    } else {
        cell.detailTextLabel.text = [term objectForKey:@"def"];
    }
    cell.textLabel.text = [term objectForKey:@"term"];
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


#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    //(@"14");
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    filteredArray = [NSMutableArray arrayWithArray:[termsArray filteredArrayUsingPredicate:predicate]];
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
