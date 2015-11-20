//
//  SwitchFieldCell.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 11/09/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchFieldCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel* fieldLabel;
@property(nonatomic, strong) IBOutlet UISwitch* fieldSwitch;

@end
