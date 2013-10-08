//
//  KLDataSource.m
//
//
//  Created by Jesse Curry on 10/7/13.
//
//

#import "KLDataSource.h"

// Categories
#import "UITableViewCell+keylime.h"

@interface KLDataSource ()
  @property (nonatomic, strong) id content;
  + (BOOL)contentTypeIsAllowed: (Class)contentType;
@end

@implementation KLDataSource
  @synthesize content=_content;
  
  + (instancetype)dataSourceWithContent: (id)content
  {
    KLDataSource* dataSource = nil;

    if ( [self contentTypeIsAllowed: [content class]] )
    {
      dataSource = [[self alloc] init];

      if ( dataSource )
      {
        dataSource.content = content;
      }
    }

    return dataSource;
  }

  + (NSArray*)allowedContentTypes
  {
    NSAssert(NO, @"[%@]please override allowedContentTypes", NSStringFromClass(self));
    return @[];
  }

#pragma mark -
  - (id)dataObjectForIndexPath: (NSIndexPath*)indexPath
  {
    return nil;
  }

#pragma mark - Private
  + (BOOL)contentTypeIsAllowed: (Class)contentType
  {
    BOOL allowed = NO;

    for ( Class c in [self allowedContentTypes] )
    {
      if ( [contentType isSubclassOfClass: c] )
      {
        allowed = YES;
        break;
      }
    }
    
    return allowed;
  }
@end
