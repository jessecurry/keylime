//
//  NSArrayTableViewDataSource.m
//  
//
//  Created by Jesse Curry on 10/8/13.
//
//

#import "NSArrayTableViewDataSource.h"

@interface NSArrayTableViewDataSource ()
  @property (readonly) NSArray* contentArray;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSArrayTableViewDataSource
#pragma mark - KLDataSource
  + (NSArray*)allowedContentTypes
  {
    return @[[NSArray class]];
  }

  - (id)dataObjectForIndexPath: (NSIndexPath*)indexPath
  {
    return self.contentArray[indexPath.row]; // JLC: any sense in this returning nil for out of bounds?
  }

#pragma mark - KLTableViewDataSource
  - (NSInteger)tableView: (UITableView*)tableView
   numberOfRowsInSection: (NSInteger)section
  {
    return self.contentArray.count;
  }

#pragma mark - Private
  - (NSArray*)contentArray
  {
    NSAssert([self.content isKindOfClass: [NSArray class]], @"[%@]content must be an NSArray!",
             NSStringFromClass([self class]));

    return (NSArray*)self.content;
  }

  
@end
