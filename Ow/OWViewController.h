//
//  OWViewController.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 12/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Session.h"

@interface OWViewController : UIViewController

@property(nonatomic, strong) UINavigationBar* navigationBar;

- (UIView *) createTitleView;

- (void) startLoadingTitleView;

- (void) stopLoadingTitleView;
    
- (void)showMessage:(NSString*)message title:(NSString*)aTitle;

- (UITableViewCell *)messageCell:(NSString *)message
                    forTableView:(UITableView *)aTableView;

- (void)startLoadingWithMessage:(NSString *)message;

- (void)finishLoading;

@end
