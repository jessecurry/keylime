//
//  UIView+keylime.m
//
//
//  Created by Jesse Curry on 10/7/13.
//
//

#import "UIView+keylime.h"

@implementation UIView (keylime)
  - (NSString*)stringIdentifier
  {
    return [NSString stringWithFormat: @"%@_%p",
            NSStringFromClass([self class]), self];
  }
@end
