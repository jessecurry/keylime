//
//  KLTableViewDataSource.m
//  
//
//  Created by Jesse Curry on 10/7/13.
//
//

#import "KLTableViewDataSource.h"

//
#import "UITableViewCell+keylime.h"

@implementation KLTableViewDataSource
  @synthesize tableView=_tableView;
  
  + (Class)tableViewCellClassForDataObject: (id)dataObject
  {
    Class tableViewCellClass = NSClassFromString([NSString stringWithFormat: @"%@TableViewCell",
                                                  NSStringFromClass([dataObject class])]);

    if ( tableViewCellClass == nil )
      tableViewCellClass = [UITableViewCell class];

    return tableViewCellClass;
  }

  
#pragma mark - UITableViewDataSource
  - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
  {
    return 1;
  }

  - (NSInteger)tableView: (UITableView*)tableView
   numberOfRowsInSection: (NSInteger)section
  {
    return 0;
  }

  - (UITableViewCell*)tableView: (UITableView*)tableView
          cellForRowAtIndexPath: (NSIndexPath*)indexPath
  {
    UITableViewCell* cell = nil;

    id dataObject = [self dataObjectForIndexPath: indexPath];

    Class tableViewCellClass = [[self class] tableViewCellClassForDataObject: dataObject];

    NSAssert([tableViewCellClass isSubclassOfClass: [UITableViewCell class]],
             @"[%@]tableViewCellClassForDataObject must return a UITableViewCell subclass",
             NSStringFromClass([self class]));

    NSString* reuseIdentifier = [tableViewCellClass klCellReuseIdentifier];

    cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier];

    [cell configureWithDataObject: dataObject];

    return cell;
  }

@end
