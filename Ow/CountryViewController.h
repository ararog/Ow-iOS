//
//  CountryViewController.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 24/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "OWViewController.h"
#import "CountryService.h"

@protocol CountryViewDelegate <NSObject>

- (void)countryController:(id)sender didSelectCountry:(Country *)chosenCountry;

@end

@interface CountryViewController : OWViewController<UITableViewDataSource, UITableViewDelegate,
    UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CountryService* countryService;
@property (nonatomic, weak) id<CountryViewDelegate> delegate;

@end
