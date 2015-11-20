//
//  CountryViewController.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 24/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "CountryViewController.h"
#import "CountryCell.h"

@interface CountryViewController ()

@property (nonatomic, strong) NSMutableArray* filteredCountries;
@property (nonatomic, strong) NSMutableArray* countries;

@end

@implementation CountryViewController

#pragma mark - View methods

- (void)awakeFromNib {
    
}

- (void)viewDidLoad {
    
    self.title = NSLocalizedString(@"Choose a Country", nil);

    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x147EBA)];
    
    self.view.backgroundColor = UIColorFromRGB(0xFDC101);
    
    self.tableView.backgroundColor = UIColorFromRGB(0xFDC101);
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(0, 0, 32, 32)];
    [backButton addTarget:self
                   action:@selector(goBack)
         forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UINib *cellNib = [UINib nibWithNibName:@"CountryCell" bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"CountryCell"];
    
    cellNib = [UINib nibWithNibName:@"MessageCell" bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"MessageCell"];
    
    _countries = [_countryService findAllCountries];
    
    self.searchDisplayController.searchBar.barTintColor = UIColorFromRGB(0x147EBA);
    self.searchDisplayController.searchResultsTableView.backgroundColor = UIColorFromRGB(0xFDC101);
    self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self.searchDisplayController.searchBar becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

#pragma mark Interaction methods

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [_filteredCountries count];
    }
    else
    {
        NSInteger count = [_countries count];
        if(count == 0)
            count = 1;
        
        return count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray* source;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
        source = _filteredCountries;
    else
        source = _countries;
    
    if([source count] > 0) {
        CountryCell *cell = (CountryCell *)[self.tableView dequeueReusableCellWithIdentifier:@"CountryCell"];
        if(cell == nil)
            cell = [[CountryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CountryCell"];
        
        Country* country = [source objectAtIndex:indexPath.row];
        
        NSString* imageName = [NSString stringWithFormat:@"flag_%@.png", country.code.lowercaseString];
        
        cell.flagImageView.image = [UIImage imageNamed: imageName];
        cell.nameLabel.text = country.name;
        cell.dialCodeLabel.text = country.dialCode;
    
        return cell;
    }
    else {
    
        return [self messageCell:NSLocalizedString(@"No countries found", nil)
                    forTableView:_tableView];
    }
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray* source;
    
    if([_delegate respondsToSelector:@selector(countryController:didSelectCountry:)]) {
        
        if (tableView == self.searchDisplayController.searchResultsTableView)
            source = _filteredCountries;
        else
            source = _countries;

        Country* country = [source objectAtIndex:indexPath.row];
        
        [_delegate countryController:self didSelectCountry:country];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Search Box Management

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    _filteredCountries = [_countryService findByName:searchString];

    return YES;
}

@end
