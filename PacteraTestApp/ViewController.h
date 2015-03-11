//
//  ViewController.h
//  PacteraTestApp
//
//  Created by AppsWiz on 11/03/2015.
//  Copyright (c) 2015 AppsWiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface ViewController : UIViewController <AsyncImageViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UINavigationBar *navBar;
@property (retain, nonatomic) IBOutlet UINavigationItem *navItem;


@property (nonatomic, strong) NSString *appTitle;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableViewController *tableViewController;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

