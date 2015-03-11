//
//  CustomTableViewCell.m
//  PacteraTestApp
//
//  Created by Thong Na on 11/03/2015.
//  Copyright (c) 2015 AppsWiz. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y, self.frame.size.width - 100, self.detailTextLabel.frame.size.height);
    self.textLabel.frame = CGRectOffset( self.textLabel.frame, 85, 0 );
    self.detailTextLabel.frame = CGRectOffset( self.detailTextLabel.frame, 85, 0 );
}

@end
