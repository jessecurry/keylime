//
//  KLPerson.m
//  keylime-example
//
//  Created by Jesse Curry on 10/8/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import "KLPerson.h"

@interface KLPerson ()
  @property (nonatomic, strong) NSString* firstName;
  @property (nonatomic, strong) NSString* lastName;
  @property (nonatomic, strong) UIImage*  image;
@end

@implementation KLPerson
  + (instancetype)personWithFirstName: (NSString*)firstName
                             lastName: (NSString*)lastName
                                image: (UIImage*)image
{
  KLPerson* person = [[self alloc] init];

  if ( person )
  {
    person.firstName = firstName;
    person.lastName = lastName;
    person.image = image;
  }

  return person;
}

- (NSString*)fullName
{
  // Even in demo-code this makes me die a little inside.
  return [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
}

#pragma mark - 
- (NSString*)debugDescription
{
  return [NSString stringWithFormat: @"<%@: %@>", NSStringFromClass([self class]), self.fullName];
}

@end
