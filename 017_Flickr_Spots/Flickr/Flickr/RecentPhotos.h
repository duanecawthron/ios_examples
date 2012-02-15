//
//  RecentPhotos.h
//  Flickr
//
//  Created by Duane Cawthron on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentPhotos : NSObject
- (void)addPhoto:(NSDictionary *)photo;
- (NSArray *)photos;
+ (RecentPhotos *)recentPhotos;
@end
