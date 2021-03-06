//
//  ElementsDetailViewController.m
//  Scientific Method
//
//  Created by John Kotz on 5/8/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "ElementsDetailViewController.h"

@interface ElementsDetailViewController ()

@end

@implementation ElementsDetailViewController
@synthesize selection,elements,elementsLabel,desc,navBar,abv,atomicNum,name;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Selected.plist"];
    self.selection = [NSString stringWithString:[[[NSMutableDictionary alloc] initWithContentsOfFile:path] objectForKey:@"selectedKey"]];
    self.elements = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"elements" ofType:@"plist"]];
    
    
    NSString *descrip;
    NSString *abrev;
    
    BOOL found = false;
    
    for (NSDictionary *element in self.elements)
    {
        if ([selection isEqualToString:[element objectForKey:@"name"]]) {
            descrip = [element objectForKey:@"desc"];
            abrev = [element objectForKey:@"abv"];
            atomicNum.text = [NSString stringWithFormat:@"%@",[element objectForKey:@"atomicNumber"]];
            self.atomicMass.text = [NSString stringWithFormat:@"%@", [element objectForKey:@"atomicMass"]];
            found = true;
            break;
        }
    }
    
    if (!found) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No access to files!" message:@"The files could not be accessed. Please contact developer for more information."
                                                       delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
                              [alert show];
    }
    
    abv.text = abrev;
    desc.text = descrip;
    navBar.title = selection;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
