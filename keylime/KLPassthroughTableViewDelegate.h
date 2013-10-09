//
//  KLPassthroughTableViewDelegate.h
//  keylime-example
//
//  Created by Jesse Curry on 10/9/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import "KLTableViewDelegate.h"

/**
 Simple delegate that forwards all unknown methods to the passthroughDelegate.
 
 Use this delegate when you just want your UIViewController to act as the tableView delegate.
 */
@interface KLPassthroughTableViewDelegate : KLTableViewDelegate
  @property (nonatomic, weak) id<UITableViewDelegate> passthroughDelegate;

  + (instancetype)delegateWithPassthroughDelegate: (id<UITableViewDelegate>)passthroughDelegate;
@end
