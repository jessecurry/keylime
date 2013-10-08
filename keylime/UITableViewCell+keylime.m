//
//  UITableViewCell+keylime.m
//  keylime-example
//
//  Created by Jesse Curry on 10/7/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import "UITableViewCell+keylime.h"

@implementation UITableViewCell (keylime)
  + (NSString*)klCellReuseIdentifier
  {
    return [NSString stringWithFormat: @"%@TableViewCell", NSStringFromClass(self)];
  }

  + (void)registerWithTableView: (UITableView*)tableView
  {
    [tableView registerClass: self
      forCellReuseIdentifier: [self klCellReuseIdentifier]];
  }

  - (void)configureWithDataObject: (id)dataObject
  {
    NSAssert(NO, @"[%@]please override configureWithDataObject:", NSStringFromClass([self class]));
  }
@end
