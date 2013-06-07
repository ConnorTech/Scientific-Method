//
//  GlossaryInfoViewController.m
//  Scientific Method
//
//  Created by John Kotz on 5/3/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "GlossaryInfoViewController.h"

@interface GlossaryInfoViewController ()

@end

@implementation GlossaryInfoViewController
@synthesize selection,terms,definition,navBar,chapter;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Selected.plist"];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    self.terms = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"terms" ofType:@"plist"]];
    
    selection = [plistDict objectForKey:@"selectedKey"];
    NSString *def;
    NSString *chap;
    BOOL found = false;
    for (NSDictionary *term in self.terms)
    {
        if ([selection isEqualToString:[term objectForKey:@"term"]]) {
            def = [term objectForKey:@"def"];
            chap = [term objectForKey:@"chapter"];
            found = true;
            break;
        }
    }
    if (!found) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No access to files!" message:@"The files could not be accessed. Please contact developer for more information."
                                                       delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        [alert show];
    }
    chapter.text = chap;
    navBar.title = selection;
    definition.text = def;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
