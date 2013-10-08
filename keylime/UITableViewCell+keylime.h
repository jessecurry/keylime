//
//  UITableViewCell+keylime.h
//  keylime-example
//
//  Created by Jesse Curry on 10/7/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (keylime)
  + (NSString*)klCellReuseIdentifier;
  + (void)registerWithTableView: (UITableView*)tableView;

  - (void)configureWithDataObject: (id)dataObject;
@end
