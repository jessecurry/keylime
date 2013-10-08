//
//  NSObject+keylime.m
//  keylime-example
//
//  Created by Jesse Curry on 10/7/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import "NSObject+keylime.h"

@implementation NSObject (keylime)
  // TODO: move this to the data source.
  + (Class)klTableViewCellClass
  {
    Class tableViewCellClass = NSClassFromString([NSString stringWithFormat: @"%@TableViewCell",
                                                  NSStringFromClass(self)]);

    if ( tableViewCellClass == nil )
      tableViewCellClass = [UITableViewCell class];

    return tableViewCellClass;
  }
@end
