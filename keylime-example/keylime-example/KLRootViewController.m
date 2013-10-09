//
//  KLRootViewController.m
//  keylime-example
//
//  Created by Jesse Curry on 10/7/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import "KLRootViewController.h"

#import "keylime.h"

// Model
#import "KLPerson.h"

// View
#import "KLPersonTableViewCell.h"

NS_ENUM(NSInteger, _TableViewDataSource) {
  TableViewDataSourceNone = -1,
  TableViewDataSourceArray,
  TableViewDataSourceOrderedSet,
  TableViewDataSourceCount
};

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface KLRootViewController ()
  @property (nonatomic, weak) IBOutlet UISegmentedControl*  segmentedControl;
  @property (nonatomic, weak) IBOutlet UITableView*         tableView;

  - (IBAction)segmentedControlValueChanged: (id)sender;

  // Content
  @property (readonly) NSArray* arrayContent;
  @property (readonly) NSOrderedSet* orderedSetContent;

  // Data Sources
  @property (readonly) NSArrayTableViewDataSource* arrayDataSource;
  @property (readonly) NSOrderedSetTableViewDataSource* orderedSetDataSource;

  // Delegates
  @property (readonly) KLBlockTableViewDelegate* blockDelegate;
  @property (readonly) KLPassthroughTableViewDelegate* passthroughDelegate;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation KLRootViewController

- (id)initWithNibName: (NSString*)nibNameOrNil
               bundle: (NSBundle*)nibBundleOrNil
{
  self = [super initWithNibName: nibNameOrNil
                         bundle: nibBundleOrNil];
  if ( self )
  {
    self.title = NSLocalizedString(@"keylime", @"View controller title");
  }

  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self registerTableViewCells];

  //
  [self setDataSource: self.arrayDataSource
             delegate: self.passthroughDelegate
         forTableView: self.tableView];
}

- (void)registerTableViewCells
{
  [KLPersonTableViewCell registerWithTableView: self.tableView];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)didSelectDataObject: (id)dataObject
               forIndexPath: (NSIndexPath*)indexPath
                inTableView: (UITableView*)tableView
{
  [tableView deselectRowAtIndexPath: indexPath
                           animated: YES];

  if ( [dataObject isKindOfClass: [KLPerson class]] )
  {
    KLPerson* person = (KLPerson*)dataObject;

    UIAlertView* av = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Person", @"AlertView title")
                                                 message: person.fullName
                                                delegate: nil
                                       cancelButtonTitle: NSLocalizedString(@"Cool", @"")
                                       otherButtonTitles: nil];
    [av show];
  }
}

#pragma mark -
- (IBAction)segmentedControlValueChanged: (id)sender
{
  switch (self.segmentedControl.selectedSegmentIndex)
  {
    case TableViewDataSourceArray:
      [self setDataSource: self.arrayDataSource
                 delegate: self.passthroughDelegate
             forTableView: self.tableView];
      break;
    case TableViewDataSourceOrderedSet:
      [self setDataSource: self.orderedSetDataSource
                 delegate: self.blockDelegate
             forTableView: self.tableView];
      break;
    default:
      break;
  }
}

#pragma mark - Content
- (NSArray*)arrayContent
{
  KLPerson* jesse = [KLPerson personWithFirstName: NSLocalizedString(@"Jesse", @"Jesse's first name")
                                         lastName: NSLocalizedString(@"Curry", @"Jesse's last name")
                                            image: nil];

  KLPerson* tom = [KLPerson personWithFirstName: NSLocalizedString(@"Tom", @"Tom's first name")
                                       lastName: NSLocalizedString(@"Curry", @"Tom's last name")
                                          image: nil];

  KLPerson* sam = [KLPerson personWithFirstName: NSLocalizedString(@"Samuel", @"Sam's first name")
                                       lastName: NSLocalizedString(@"Curry", @"Sam's last name")
                                          image: nil];

  return @[jesse, tom, sam, @"Array"];
}

- (NSOrderedSet*)orderedSetContent
{
  KLPerson* jesse = [KLPerson personWithFirstName: NSLocalizedString(@"Jesse", @"Jesse's first name")
                                         lastName: NSLocalizedString(@"Lee", @"Jesse's last name")
                                            image: nil];

  KLPerson* tom = [KLPerson personWithFirstName: NSLocalizedString(@"Tom", @"Tom's first name")
                                       lastName: NSLocalizedString(@"Wilson", @"Tom's last name")
                                          image: nil];

  KLPerson* sam = [KLPerson personWithFirstName: NSLocalizedString(@"Samuel", @"Sam's first name")
                                       lastName: NSLocalizedString(@"Joseph", @"Sam's last name")
                                          image: nil];

  return [NSOrderedSet orderedSetWithObjects: jesse, tom, sam, @"Ordered Set", nil];
}

#pragma mark - Data Sources
- (NSArrayTableViewDataSource*)arrayDataSource
{
  NSArrayTableViewDataSource* dataSource = [NSArrayTableViewDataSource
                                            dataSourceWithContent: self.arrayContent];

  return dataSource;
}

- (NSOrderedSetTableViewDataSource*)orderedSetDataSource
{
  NSOrderedSetTableViewDataSource* dataSource = [NSOrderedSetTableViewDataSource
                                                 dataSourceWithContent: self.orderedSetContent];

  return dataSource;
}

#pragma mark - Delegates
- (KLBlockTableViewDelegate*)blockDelegate
{
  KLBlockTableViewDelegate* delegate =
  [KLBlockTableViewDelegate
   delegateWithSelectionHandler: ^(id dataObject, NSIndexPath* indexPath, UITableView* tableView) {
     [tableView deselectRowAtIndexPath: indexPath
                              animated: YES];
     if ( [dataObject isKindOfClass: [KLPerson class]] )
     {
       KLPerson* person = (KLPerson*)dataObject;

       UIAlertView* av = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Block: Person", @"AlertView title")
                                                    message: person.fullName
                                                   delegate: nil
                                          cancelButtonTitle: NSLocalizedString(@"Wow!", @"")
                                          otherButtonTitles: nil];
       [av show];
     }
   }];

  return delegate;
}

- (KLPassthroughTableViewDelegate*)passthroughDelegate
{
  KLPassthroughTableViewDelegate* delegate = [KLPassthroughTableViewDelegate
                                              delegateWithPassthroughDelegate: self];

  return delegate;
}
  
@end
