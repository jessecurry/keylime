//
//  KLPassthroughTableViewDelegate.m
//  keylime-example
//
//  Created by Jesse Curry on 10/9/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import "KLPassthroughTableViewDelegate.h"

@implementation KLPassthroughTableViewDelegate
  @synthesize passthroughDelegate=_passthroughDelegate;

  + (instancetype)delegateWithPassthroughDelegate: (id<UITableViewDelegate>)passthroughDelegate
  {
    KLPassthroughTableViewDelegate* delegate = [self delegate];

    if ( delegate )
    {
      delegate.passthroughDelegate = passthroughDelegate;
    }

    return delegate;
  }

  // Forward to the passthrough delegate
  - (void)forwardInvocation: (NSInvocation*)invocation
  {
    if ( [self.passthroughDelegate respondsToSelector: [invocation selector]] )
    {
      [invocation invokeWithTarget: self.passthroughDelegate];
    }
    else
    {
      [super forwardInvocation: invocation];
    }
  }
@end
