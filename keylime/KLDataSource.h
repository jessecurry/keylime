//
//  KLDataSource.h
//  
//
//  Created by Jesse Curry on 10/7/13.
//
//

#import <Foundation/Foundation.h>

@protocol KLDataSource <NSObject>
- (id)dataObjectForIndexPath: (NSIndexPath*)indexPath;
@end

@interface KLDataSource : NSObject <KLDataSource>
@property (nonatomic, strong, readonly) id content;
+ (instancetype)dataSourceWithContent: (id)content;
+ (NSArray*)allowedContentTypes;
@end
