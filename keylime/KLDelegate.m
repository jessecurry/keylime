//
//  KLDelegate.m
//  keylime-example
//
//  Created by Jesse Curry on 10/8/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import "KLDelegate.h"

@implementation KLDelegate
+ (instancetype)delegate
{
  KLDelegate* delegate = [[self alloc] init];

  if ( delegate )
  {
    // do some good stuff.
  }

  return delegate;
}

- (void)didSelectDataObject: (id)dataObject
               forIndexPath: (NSIndexPath*)indexPath
{
  // noop
}

@end
