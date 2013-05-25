//
//  ConceptsDetailViewController.m
//  Scientific Method
//
//  Created by John Kotz on 5/23/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "ConceptsDetailViewController.h"

@interface ConceptsDetailViewController ()

@end

@implementation ConceptsDetailViewController

@synthesize label1,concepts;

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
    NSString *selection;
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Selected" ofType:@"plist"]];
    self.concepts = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"concepts" ofType:@"plist"]];
    
    selection = [plistDict objectForKey:@"selectedKey"];
    NSArray *info;
    NSString *type;
    for (NSDictionary *concept in self.concepts)
    {
        if ([selection isEqualToString:[concept objectForKey:@"name"]]) {
            type = [concept objectForKey:@"type"];
            info = [concept objectForKey:@"info"];
            break;
        }
    }
    if ([type isEqualToString:@"Process"]) {
        label1.text = [NSString stringWithFormat:@"Steps"];
    }else if ([type isEqualToString:@"Sectioned"]){
        label1.text = [NSString stringWithFormat:@"Types"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
