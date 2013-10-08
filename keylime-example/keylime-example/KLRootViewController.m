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
  TableViewDataSourceCount
};

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface KLRootViewController ()
  @property (nonatomic, weak) IBOutlet UISegmentedControl*  segmentedControl;
  @property (nonatomic, weak) IBOutlet UITableView*         tableView;

  - (IBAction)segmentedControlValueChanged: (id)sender;

  @property (readonly) NSArray* arrayContent;
  @property (readonly) NSArrayTableViewDataSource* arrayDataSource;
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

  }

  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self registerTableViewCells];

  //
  [self setDataSource: self.arrayDataSource
         forTableView: self.tableView];
         
  self.tableView.delegate = self;
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
  return @[jesse, tom, sam];
}

- (NSArrayTableViewDataSource*)arrayDataSource
{
  NSArrayTableViewDataSource* dataSource = [NSArrayTableViewDataSource
                                            dataSourceWithContent: self.arrayContent];

  return dataSource;
}
  
@end
