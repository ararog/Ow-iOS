//
//  OWViewController.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 12/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "OWViewController.h"

@interface OWViewController ()

@property (nonatomic, strong) UIView* titleView;

@end

@implementation OWViewController

#pragma mark - View methods

- (void)awakeFromNib {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    [self.view addSubview:_navigationBar];

    NSDictionary *viewsDictionary = @{@"navigationBar":_navigationBar};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[navigationBar(==64)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[navigationBar(>=320)]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
    
    UINavigationItem *item = [[UINavigationItem alloc] init];
    
    self.titleView = [self createTitleView];
    
    item.titleView = _titleView;
    
    _navigationBar.items = [NSArray arrayWithObjects:item, nil];
}

#pragma mark - Dialog methods

- (void)showMessage:(NSString*)message title:(NSString*)aTitle {
    
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setTitle:aTitle];
    [dialog addButtonWithTitle:NSLocalizedString(@"Ok", nil)];
    [dialog setMessage:message];
    [dialog show];
}

#pragma mark - UITableViewCell utility methods

- (UITableViewCell *)messageCell:(NSString *)message forTableView:(UITableView *)aTableView {
    
    NSString *cellIdentifier = @"MessageCell";
    UITableViewCell *cell = (UITableViewCell *)[aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"MavenProRegular" size:18];
    cell.textLabel.text = message;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = UIColorFromRGB(0xFDC101);
    
    return cell;
}

#pragma mark - UI data loading methods

- (UIView *)createTitleView {
    
    UIView *waitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 34)];
    
    UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 24, 34)];
    [indicatorView setTag:100];
    [indicatorView setHidesWhenStopped:YES];
    [waitView addSubview:indicatorView];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110, 34)];
    label.font = [UIFont fontWithName:@"MavenProBold" size:22];
    label.textColor = [UIColor whiteColor];
    label.text = self.title;
    label.tag = 200;
    [waitView addSubview:label];
    
    return waitView;
}

- (void)startLoadingTitleView {
    
    UIActivityIndicatorView* indicatorView = (UIActivityIndicatorView *)[_titleView viewWithTag:100];
    [indicatorView startAnimating];
    
    UILabel* label = (UILabel *)[_titleView viewWithTag:200];
    label.frame = CGRectMake(28, 0, 86, 34);
    label.text = NSLocalizedString(@"Aguarde", nil);
}

- (void)stopLoadingTitleView {
    
    UIActivityIndicatorView* indicatorView = (UIActivityIndicatorView *)[_titleView viewWithTag:100];
    [indicatorView stopAnimating];
    
    UILabel* label = (UILabel *)[_titleView viewWithTag:200];
    label.frame = CGRectMake(0, 0, 110, 34);
    label.text = self.title;
}

- (void)startLoadingWithMessage:(NSString *)message {
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelFont = [UIFont fontWithName:@"Dosis-Bold" size:26];
    hud.labelText = message;
}

- (void)finishLoading
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
