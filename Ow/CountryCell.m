//
//  CountryCell.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 24/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "CountryCell.h"

@implementation CountryCell

- (void)awakeFromNib {
    
    _nameLabel.font = [UIFont fontWithName:@"MavenProRegular" size:18];
    _nameLabel.textColor = [UIColor whiteColor];

    _dialCodeLabel.font = [UIFont fontWithName:@"MavenProRegular" size:18];
    _dialCodeLabel.textColor = [UIColor whiteColor];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = UIColorFromRGB(0xFDC101);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
