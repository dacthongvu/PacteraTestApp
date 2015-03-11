//
//  ViewController.m
//  PacteraTestApp
//
//  Created by AppsWiz on 11/03/2015.
//  Copyright (c) 2015 AppsWiz. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize dataArray, appTitle, tableView, navBar, navItem, tableViewController, refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableViewController = [[UITableViewController alloc] init];
    self.tableViewController.tableView = self.tableView;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(getData)
                  forControlEvents:UIControlEventValueChanged];
    self.tableViewController.refreshControl = self.refreshControl;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getData{
    NSError *error;
    NSURL *url = [NSURL URLWithString: @"https://dl.dropboxusercontent.com/u/746330/facts.json"];
    
    NSString* serverResponse = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSData* data = [serverResponse dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *returnedDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (returnedDict != nil) {
        self.navItem.title = [returnedDict objectForKey:@"title"];
        self.dataArray = [returnedDict objectForKey:@"rows"];
        //[self.tableView reloadData];
    }
    else if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}

#pragma mark  UITableView Datasouce & Delegate Methods

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height = 0;
    NSDictionary* rowObject = [self.dataArray objectAtIndex: indexPath.row];
    NSString* rowDescription = [rowObject objectForKey:@"description"];
    if (![rowDescription isEqual: [NSNull null]]) {
        height  = [rowDescription sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(250, 10000) lineBreakMode:NSLineBreakByWordWrapping].height + 20;
    }
    return (height <= 85) ? 85 : height;
}


-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

-(NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* rowObject = [self.dataArray objectAtIndex: indexPath.row];
    NSString* rowTitle = [rowObject objectForKey:@"title"];
    NSString* rowDescription = [rowObject objectForKey:@"description"];
    NSString* rowImageUrl = [rowObject objectForKey:@"imageHref"];
    
    CustomTableViewCell* cell = [[CustomTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: @"cell"];
    if (![rowTitle isEqual: [NSNull null]]) cell.textLabel.text = rowTitle;
    
    if (![rowDescription isEqual: [NSNull null]]) {
        cell.detailTextLabel.text = rowDescription;
        cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    AsyncImageView* imageView = [[AsyncImageView alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
    
    [cell addSubview: imageView];
    
    if (![rowImageUrl isEqual: [NSNull null]]){
        imageView.imageUrl = [NSURL URLWithString: rowImageUrl];
        imageView.userData = indexPath;
        imageView.delegate = self;
        [imageView startLoading];
    }
    else{
        imageView.image = [UIImage imageNamed:@"NoImage.png"];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark AWAsyncImageView Delegate

-(void) didFinishLoadingImage:(UIImage *)image UserData:(id)userdata{
    
}

- (void)dealloc {
    [self releaseResources];
    [super dealloc];
}

- (void) releaseResources {
    [self.dataArray release];
    [self.appTitle release];
    [self.tableView release];
    [self.navBar release];
    [self.navItem release];
    [self.tableViewController release];
    [self.refreshControl release];
}
@end
