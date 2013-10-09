//
//  UIViewController+keylime.m
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

#import "UIViewController+keylime.h"
#import <objc/runtime.h>

// Categories
#import "UIView+keylime.h"

// Data Sources
#import "KLTableViewDataSource.h"

// Delegates
#import "KLTableViewDelegate.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
static char kKLTableViewDataSourcesKey;
static char kKLTableViewDelegatesKey;

@interface UIViewController (_keylime)
@property (nonatomic, strong, readonly) NSMutableDictionary* kl_TableViewDataSources;
@property (nonatomic, strong, readonly) NSMutableDictionary* kl_TableViewDelegates;
@end

@implementation  UIViewController (_keylime)
- (NSMutableDictionary*)kl_TableViewDataSources
{
  NSMutableDictionary* tableViewDataSources = (NSMutableDictionary*)objc_getAssociatedObject(self, &kKLTableViewDataSourcesKey);

  if ( tableViewDataSources == nil )
  {
    tableViewDataSources = [[NSMutableDictionary alloc] init];

    objc_setAssociatedObject(self, &kKLTableViewDataSourcesKey, tableViewDataSources, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }

  return tableViewDataSources;
}

- (NSMutableDictionary*)kl_TableViewDelegates
{
  NSMutableDictionary* tableViewDelegates = (NSMutableDictionary*)objc_getAssociatedObject(self, &kKLTableViewDelegatesKey);

  if ( tableViewDelegates == nil )
  {
    tableViewDelegates = [[NSMutableDictionary alloc] init];

    objc_setAssociatedObject(self, &kKLTableViewDelegatesKey, tableViewDelegates, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }

  return tableViewDelegates;
}
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIViewController (keylime)
#pragma mark DataSource
- (void)setDataSource: (KLTableViewDataSource*)dataSource
         forTableView: (UITableView*)tableView
{
  [self removeDataSourceForTableView: tableView];

  if ( [dataSource isKindOfClass: [KLTableViewDataSource class]]
      && [tableView isKindOfClass: [UITableView class]] )
  {
    tableView.dataSource = dataSource;
    dataSource.tableView = tableView;

    [self.kl_TableViewDataSources setObject: dataSource
                                     forKey: tableView.stringIdentifier];
  }

  [tableView reloadData];
}

- (void)removeDataSourceForTableView: (UITableView*)tableView
{
  if ( [tableView isKindOfClass: [UITableView class]] )
  {
    [self.kl_TableViewDataSources removeObjectForKey: tableView.stringIdentifier];
    tableView.dataSource = nil;
  }

  [tableView reloadData];
}

#pragma mark Delegate
- (void)setDelegate: (KLTableViewDelegate*)delegate
       forTableView: (UITableView*)tableView
{
  [self removeDelegateForTableView: tableView];

  if ( [delegate isKindOfClass: [KLTableViewDelegate class]]
      && [tableView isKindOfClass: [UITableView class]] )
  {
    tableView.delegate = delegate;
    delegate.tableView = tableView;

    [self.kl_TableViewDelegates setObject: delegate
                                   forKey: tableView.stringIdentifier];
  }
}
- (void)removeDelegateForTableView: (UITableView*)tableView
{
  if ( [tableView isKindOfClass: [UITableView class]] )
  {
    [self.kl_TableViewDelegates removeObjectForKey: tableView.stringIdentifier];
    tableView.delegate = nil;
  }
}

#pragma mark Combined
- (void)setDataSource: (KLTableViewDataSource*)dataSource
             delegate: (KLTableViewDelegate*)delegate
         forTableView: (UITableView*)tableView
{
  [self setDataSource: dataSource
         forTableView: tableView];
  [self setDelegate: delegate
       forTableView: tableView];
}

- (void)removeDataSourceAndDelegateForTableView: (UITableView*)tableView
{
  [self removeDataSourceForTableView: tableView];
  [self removeDelegateForTableView: tableView];
}

#pragma mark - UITableViewDelegate
// Default implementation, override in subclasses if you do not want this behavior.
- (void)tableView: (UITableView*)tableView didSelectRowAtIndexPath: (NSIndexPath*)indexPath
{
  if ( [tableView.dataSource isKindOfClass: [KLTableViewDataSource class]] )
  {
    KLTableViewDataSource* dataSource = (KLTableViewDataSource*)tableView.dataSource;

    id dataObject = [dataSource dataObjectForIndexPath: indexPath];

    [self didSelectDataObject: dataObject
                 forIndexPath: indexPath
                  inTableView: tableView];
  }
}

/** 
 Informs the UIViewController subclass that a data object was selected in a specific UITableView.
 @param dataObject The selected object
 @param indexPath The index path of the selected object
 @param tableView The UITableView that the user interacted with
 */
- (void)didSelectDataObject: (id)dataObject
               forIndexPath: (NSIndexPath*)indexPath
                inTableView: (UITableView*)tableView
{
  NSAssert(NO, @"[%@]please override %@",
           NSStringFromClass([self class]),
           NSStringFromSelector(_cmd));
}

@end
