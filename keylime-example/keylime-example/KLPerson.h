//
//  KLPerson.h
//  keylime-example
//
//  Created by Jesse Curry on 10/8/13.
//  Copyright (c) 2013 keylime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLPerson : NSObject
  @property (nonatomic, strong, readonly) NSString* firstName;
  @property (nonatomic, strong, readonly) NSString* lastName;
  @property (nonatomic, strong, readonly) UIImage*  image;

  @property (readonly) NSString* fullName;

  + (instancetype)personWithFirstName: (NSString*)firstName
                             lastName: (NSString*)lastName
                                image: (UIImage*)image;
@end
