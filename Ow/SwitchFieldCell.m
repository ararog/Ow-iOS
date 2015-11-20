//
//  SwitchFieldCell.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 11/09/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "SwitchFieldCell.h"

@implementation SwitchFieldCell

- (void)awakeFromNib {
    // Initialization code
    
    _fieldLabel.font = [UIFont fontWithName:@"MavenProBold" size:18];
    _fieldLabel.textColor = [UIColor whiteColor];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = UIColorFromRGB(0xFDC101);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
