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
@synthesize selection,terms,termLabel,definition,navBar,chapter;

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
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"]];
    self.terms = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"terms" ofType:@"plist"]];
    
    selection = [plistDict objectForKey:@"selectedKey"];
    NSString *def;
    NSString *chap;
    for (NSDictionary *term in self.terms)
    {
        NSLog(@"%@", term);
        if ([selection isEqualToString:[term objectForKey:@"term"]]) {
            def = [term objectForKey:@"def"];
            chap = [term objectForKey:@"chapter"];
            break;
        }
    }
    NSLog(@"%@", selection);
    chapter.text = chap;
    navBar.title = selection;
    termLabel.text = selection;
    definition.text = def;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
