//
//  RecentPhotos.h
//  Flickr
//
//  Created by Duane Cawthron on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentPhotos : NSObject

// recent photos
@property (nonatomic, strong, readonly) NSArray *photos;

// add the most recent photo
- (void)addPhoto:(NSDictionary *)photo;

// return a singletone instance
+ (RecentPhotos *)recentPhotos;
@end
