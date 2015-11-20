//
//  Notification.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "Notification.h"

@implementation Notification

-(NSString *) typeToString {
    
    NSString* text = @"";
    
    switch (_type.intValue) {
        case 1:
            text = NSLocalizedString(@"vamo", nil);
            break;
        case 2:
            text = NSLocalizedString(@"perai", nil);
            break;
        case 3:
            text = NSLocalizedString(@"chegou", nil);
            break;
        case 4:
            text = NSLocalizedString(@"maneiro", nil);
            break;
        case 5:
            text = NSLocalizedString(@"tocomfome", nil);
            break;
        case 6:
            text = NSLocalizedString(@"owkey", nil);
            break;
        default:
            break;
    }
    
    return text;
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ([propertyName isEqualToString: @"read"])
        return YES;

    return NO;
}

@end
