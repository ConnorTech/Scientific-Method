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
@synthesize selection,elements,elementsLabel,desc,navBar,abv;

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
    self.selection = [NSString stringWithString:[[[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"]] objectForKey:@"selectedKey2"]];
    self.elements = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"elements" ofType:@"plist"]];
    NSString *desc;
    NSString *abrev;
    
    for (NSDictionary *element in self.elements)
    {
        if ([selection isEqualToString:[element objectForKey:@"name"]]) {
            desc = [element objectForKey:@"desc"];
            abrev = [element objectForKey:@"abv"];
            break;
        }
    }
    
    
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
