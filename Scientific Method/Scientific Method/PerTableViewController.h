//
//  PerTableViewController.h
//  Scientific Method
//
//  Created by John Kotz on 6/6/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerTableViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) UIImageView *imageView;

@end
