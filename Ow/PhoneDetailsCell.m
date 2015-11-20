//
//  PhoneDetailsCell.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 26/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "PhoneDetailsCell.h"

@implementation PhoneDetailsCell

- (void)awakeFromNib {

    UIColor *color = [UIColor whiteColor];

    _countryCodeField.font = [UIFont fontWithName:@"MavenProBold" size:18];
    
    _phoneNumberField.font = [UIFont fontWithName:@"MavenProBold" size:18];
    _phoneNumberField.keyboardType = UIKeyboardTypePhonePad;
    _phoneNumberField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Phone Number", nil)
                                                                              attributes:@{NSForegroundColorAttributeName: color}];

    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = UIColorFromRGB(0xFDC101);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
