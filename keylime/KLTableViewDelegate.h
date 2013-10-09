//
//  KLTableViewDelegate.h
//  keylime-example
//
//  Created by Jesse Curry on 10/8/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import "KLDelegate.h"

@interface KLTableViewDelegate : KLDelegate <UITableViewDelegate>
  @property (nonatomic, weak) UITableView* tableView;
@end
