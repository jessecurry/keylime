//
//  KLDelegate.h
//  keylime-example
//
//  Created by Jesse Curry on 10/8/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KLDelegate <NSObject>
  - (void)didSelectDataObject: (id)dataObject
                 forIndexPath: (NSIndexPath*)indexPath;
@end

@interface KLDelegate : NSObject <KLDelegate>
+ (instancetype)delegate;
@end
