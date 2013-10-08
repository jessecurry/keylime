//
//  UIViewController+keylime.m
//
//
//  Created by Jesse Curry on 10/7/13.
//
//

#import "UIViewController+keylime.h"
#import <objc/runtime.h>

// Categories
#import "UIView+keylime.h"

// Data Sources
#import "KLTableViewDataSource.h"

// Delegates


////////////////////////////////////////////////////////////////////////////////////////////////////
static char kKLTableViewDataSourcesKey;

@interface UIViewController (_keylime)
@property (nonatomic, strong, readonly) NSMutableDictionary* kl_TableViewDataSources;
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
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIViewController (keylime)
- (void)setDataSource: (KLTableViewDataSource*)dataSource
         forTableView: (UITableView*)tableView
{
  [self removeDataSourceForTableView: tableView];

  if ( [dataSource isKindOfClass: [KLTableViewDataSource class]]
      && [tableView isKindOfClass: [UITableView class]] )
  {
    tableView.dataSource = dataSource;

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

#pragma mark - UITableViewDelegate
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

- (void)didSelectDataObject: (id)dataObject
               forIndexPath: (NSIndexPath*)indexPath
                inTableView: (UITableView*)tableView
{
  NSAssert(NO, @"[%@]please override %@",
           NSStringFromClass([self class]),
           NSStringFromSelector(_cmd));
}

@end
