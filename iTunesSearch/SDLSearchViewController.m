//
//  SDLSearchViewController.m
//  iTunesSearch
//

#import "SDLSearchViewController.h"
#import "SDLiTunesObject.h"
#import "SDLiTunesSearchResultCell.h"
#import "SDLiTunesSearchController.h"
#import "UIAlertController+Quickie.h"


@interface SDLSearchViewController () <SDLiTunesSearchControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSArray <SDLiTunesObject *> *results;
@property (nonatomic, strong) SDLiTunesSearchController *searchController;

@end

@implementation SDLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.searchController = [SDLiTunesSearchController new];
    self.searchController.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDLiTunesSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iTunesSearchResultCell" forIndexPath:indexPath];
    
    cell.searchObject = self.results[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Open object in iTunes
    SDLiTunesObject *object = self.results[indexPath.row];
    if (object.itunesUrl != nil) {
        NSURL *url = [NSURL URLWithString:object.itunesUrl];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

#pragma mark - SDLiTunesSearchControllerDelegate

- (void)searchController:(SDLiTunesSearchController *)searchController returnedSearchResults:(NSArray<SDLiTunesObject *> *)results
{
    // Show results
    self.results = results;
    [self.tableView reloadData];
}

- (void)searchController:(SDLiTunesSearchController *)searchController failedWithError:(NSError *)error
{
    // Clear results
    self.results = @[];
    [self.tableView reloadData];
    
    // Show error
    NSLog(@"Got error: %@", error.localizedDescription);
    NSLog(@"%@", error.userInfo);
    [UIAlertController showQuickieAlertWithTitle:@"Error" message:@"Uh oh... Something went wrong."];
}

#pragma mark - Search bar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.searchController searchForTerm:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

@end
