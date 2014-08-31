//
//  MasterViewController.h
//  proto1
//
//  Created by Ian on 8/27/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (weak, nonatomic)IBOutlet UIBarButtonItem *slideBarButton;

@end
