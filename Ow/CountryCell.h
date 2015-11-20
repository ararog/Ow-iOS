//
//  CountryCell.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 24/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UIImageView* flagImageView;
@property(nonatomic, weak) IBOutlet UILabel* nameLabel;
@property(nonatomic, weak) IBOutlet UILabel* dialCodeLabel;

@end
