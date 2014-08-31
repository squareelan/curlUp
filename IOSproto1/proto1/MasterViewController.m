//
//  MasterViewController.m
//  proto1
//
//  Created by Ian on 8/27/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "MasterViewController.h"
#import "SWRevealViewController.h"
#import "DetailViewController.h"
#import "Salon.h"

@interface MasterViewController () {
    NSMutableArray *salons;
    NSArray *searchResults;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    [self initSlideBar];
    [self initTableView];
    
    
//    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
//    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)initSlideBar
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if(revealViewController){
        [self.slideBarButton setTarget:revealViewController];
        [self.slideBarButton setAction:@selector(revealToggle:)];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}

-(void)initTableView
{
    if(!salons){
        salons = [[NSMutableArray alloc] init];
    }
    Salon *salon = [[Salon alloc]init];
    salon.name = @"CNN Hair Salon";
    salon.image = [UIImage imageNamed: @"salon1.jpeg"];
    [salons addObject:salon];
    Salon *salon1 = [[Salon alloc]init];
    salon1.name = @"박승철 Hair Salon";
    salon1.image = [UIImage imageNamed: @"salon2.jpeg"];
    [salons addObject:salon1];
    Salon *salon2 = [[Salon alloc]init];
    salon2.name = @"박준 Hair Salon";
    salon2.image = [UIImage imageNamed: @"salon3.jpeg"];
    [salons addObject:salon2];
    Salon *salon3 = [[Salon alloc]init];
    salon3.name = @"Austin Hair Salon";
    salon3.image = [UIImage imageNamed: @"salon4.jpeg"];
    [salons addObject:salon3];
    Salon *salon4 = [[Salon alloc]init];
    salon4.name = @"IAN Hair Salon";
    salon4.image = [UIImage imageNamed: @"salon5.jpeg"];
    [salons addObject:salon4];
    //salons = @[@"CNN Hair Salon",@"박승철 Hair Salon", @"박준 Hair Salon", @"Austin Hair Salon"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender
//{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [searchResults count];
    }
    else{
        return salons.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Salon *salon = nil;
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        salon = [searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        NSLog(@"%lu",indexPath.row);
        salon = [salons objectAtIndex:indexPath.row];
    }
    //NSDate *object = salons[indexPath.row];
    NSLog(salon.name);
    cell.textLabel.text = salon.name;
    cell.imageView.image = salon.image;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [salons removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = salons[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

//determines cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

#pragma mark - Search Controller
-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [salons filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                                         objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = salons[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
