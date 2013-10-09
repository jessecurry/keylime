//
//  UIViewController+keylime.h
//  
//
//  Created by Jesse Curry on 10/7/13.
//
//

#import <UIKit/UIKit.h>

@class KLTableViewDataSource;
@class KLTableViewDelegate;
@interface UIViewController (keylime) <UITableViewDelegate>
// Table View
- (void)setDataSource: (KLTableViewDataSource*)dataSource
         forTableView: (UITableView*)tableView;
- (void)removeDataSourceForTableView: (UITableView*)tableView;

- (void)setDelegate: (KLTableViewDelegate*)delegate
       forTableView: (UITableView*)tableView;
- (void)removeDelegateForTableView: (UITableView*)tableView;

- (void)setDataSource: (KLTableViewDataSource*)dataSource
             delegate: (KLTableViewDelegate*)delegate
         forTableView: (UITableView*)tableView;
- (void)removeDataSourceAndDelegateForTableView: (UITableView*)tableView;

// JLC: not sure that I *love* this, every UIViewController becomes a UITableView delegate
- (void)didSelectDataObject: (id)dataObject
               forIndexPath: (NSIndexPath*)indexPath
                inTableView: (UITableView*)tableView;
@end
