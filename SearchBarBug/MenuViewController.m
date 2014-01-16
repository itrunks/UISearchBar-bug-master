//
//  MenuViewController.m
//  SearchBarBug
//
//  Created by Mouhcine El Amine on 07/01/14.
//  Copyright (c) 2014 Mouhcine El Amine. All rights reserved.
//

#import "MenuViewController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"

@interface MenuViewController () <UITableViewDataSource, UISearchBarDelegate,UISearchDisplayDelegate,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
	[self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappear:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)keyboardWillAppear:(NSNotification *)note
{
    [self.sidePanelController setCenterPanelHidden:YES
                                          animated:YES
                                          duration:[[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    self.searchBar.showsCancelButton = YES;
}

- (void)keyboardWillDisappear:(NSNotification *)note
{
    [self.sidePanelController setCenterPanelHidden:NO
                                          animated:YES
                                          duration:[[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    self.searchBar.showsCancelButton = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDataSource

- (UITableView *)tableView
{
    if (!_tableView) {
        CGRect frame = CGRectMake(0.0f,
                                  [[UIApplication sharedApplication] statusBarFrame].size.height,
                                  self.view.bounds.size.width,
                                  self.view.bounds.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor=[UIColor greenColor];
      //  _tableView.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PM.png"]];
        [self addSearchBar];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MenuCellIdentifier = @"MenuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MenuCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MenuCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Menu item %i", indexPath.row];
    return cell;
}

#pragma mark - Search bar

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 44.0f)];
        _searchBar.translucent = NO;
        _searchBar.barTintColor = [UIColor purpleColor];
        _searchBar.delegate=self;
    }
    return _searchBar;
}
- (void)addSearchBar
{
    self.tableView.tableHeaderView = self.searchBar;
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar
                                                              contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.delegate=self;
}

-(void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
    
    NSLog(@"searchDisplayControllerDidEndSearch");
}

-(void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView{
    
      NSLog(@"willShowSearchResultsTableView");
}

-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
     NSLog(@"searchDisplayControllerWillBeginSearch");
    
    //controller.searchBar.frame=CGRectMake(0, 20, 320, 30);
    
}

-(void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView{
    
   //
    controller.searchResultsTableView.backgroundColor=[UIColor orangeColor];
    //tableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    
    
}


-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
    
    UIView *subView=[[UIView alloc]initWithFrame:CGRectMake(0, -20, 320, 20)];
    [controller.searchBar addSubview:subView];
    subView.backgroundColor=[UIColor redColor];
    
}

@end
