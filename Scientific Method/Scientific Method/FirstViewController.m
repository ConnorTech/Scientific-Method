//
//  FirstViewController.m
//  Scientific Method
//
//  Created by Connor Koehler on 5/1/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goLordtechy:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.lordtechy.com"]];
}

-(IBAction)showActionSheet:(id)sender{
    
}

@end
