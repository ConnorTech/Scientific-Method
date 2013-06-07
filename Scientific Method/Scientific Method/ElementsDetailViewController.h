//
//  ElementsDetailViewController.h
//  Scientific Method
//
//  Created by John Kotz on 5/8/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElementsDetailViewController : UIViewController{
    NSString *selection;
    NSMutableArray *elements;
}

@property (nonatomic,retain) NSString *selection;
@property (nonatomic,retain) NSMutableArray *elements;
@property (nonatomic,retain) IBOutlet UINavigationItem *navBar;
@property (nonatomic,retain) IBOutlet UILabel *elementsLabel;
@property (nonatomic,retain) IBOutlet UITextView *desc;
@property (nonatomic,retain) IBOutlet UILabel *abv;
@property (nonatomic,retain) IBOutlet UILabel *atomicNum;
@property (nonatomic,retain) IBOutlet UILabel *atomicMass;
@property(nonatomic) NSString *name;

@end
