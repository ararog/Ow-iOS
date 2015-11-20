//
//  NotificationCell.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 24/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel* nameLabel;
@property(nonatomic, strong) IBOutlet UILabel* dateLabel;
@property(nonatomic, strong) IBOutlet UILabel* descriptionLabel;

@end
