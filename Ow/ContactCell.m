//
//  ContactCell.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 24/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (void)awakeFromNib {
    
    self.textLabel.font = [UIFont fontWithName:@"MavenProBold" size:18];
    self.textLabel.textColor = [UIColor whiteColor];

    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = UIColorFromRGB(0xFDC101);    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
