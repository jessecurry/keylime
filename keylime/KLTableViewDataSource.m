//
//  KLTableViewDataSource.m
//
// Copyright (c) 2013 jessecurry
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "KLTableViewDataSource.h"

//
#import "UITableViewCell+keylime.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
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
- (NSInteger)numberOfSectionsInTableView: (UITableView*)tableView
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

  // Determine the cell class for this data object
  Class tableViewCellClass = [[self class] tableViewCellClassForDataObject: dataObject];

  NSAssert([tableViewCellClass isSubclassOfClass: [UITableViewCell class]],
           @"[%@]tableViewCellClassForDataObject must return a UITableViewCell subclass",
           NSStringFromClass([self class]));

  // Attempt to deque a cell with the correct reuse identifier
  NSString* reuseIdentifier = [tableViewCellClass klCellReuseIdentifier];
  cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier];

  if ( cell == nil )
  {
    // If we have no cell, create a default cell and set its labels to the expected
    //  reuse identifier as a convenience to the developer.
    cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle
                                  reuseIdentifier: reuseIdentifier];
  }

  // Configure the cell.
  [cell configureWithDataObject: dataObject];

  return cell;
}

@end
