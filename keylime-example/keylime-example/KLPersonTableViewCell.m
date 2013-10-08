//
//  KLPersonTableViewCell.m
//  keylime-example
//
//  Created by Jesse Curry on 10/8/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import "KLPersonTableViewCell.h"

// keylime
#import "UITableViewCell+keylime.h"

// Model
#import "KLPerson.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation KLPersonTableViewCell

- (void)configureWithDataObject: (id)dataObject
{
  if ( [dataObject isKindOfClass: [KLPerson class]] )
  {
    // In real-life we'd probably use KVO to observe a person property and update
    //  the cell's fields
    KLPerson* person = (KLPerson*)dataObject;

    self.textLabel.text = person.fullName;
  }
}

@end
