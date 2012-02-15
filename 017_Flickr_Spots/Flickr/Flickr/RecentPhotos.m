//
//  RecentPhotos.m
//  Flickr
//
//  Created by Duane Cawthron on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecentPhotos.h"
#import "FlickrFetcher.h"

@interface RecentPhotos()
@property (nonatomic, strong, readonly) NSMutableArray *myRecentPhotos;
@end

@implementation RecentPhotos

@synthesize photos = _photos;
@synthesize myRecentPhotos = _myRecentPhotos;

const NSUInteger MAX = 20;
#define RECENT_KEY @"Recent Flickr Photos"

- (NSArray *)photos
{
    if (!_photos) {
        _photos = self.myRecentPhotos;
    }
    return _photos;
}

- (NSMutableArray *)myRecentPhotos
{
    if (!_myRecentPhotos) {
        NSArray *userDefaultPhotos = [[NSUserDefaults standardUserDefaults] objectForKey:RECENT_KEY];
        if (userDefaultPhotos) {
            _myRecentPhotos = [userDefaultPhotos mutableCopy];
            //NSLog(@"\n thePhtos %@", self.myRecentPhotos);
        } else {
            _myRecentPhotos = [[NSMutableArray alloc] initWithCapacity:MAX];
        }
    }
    return _myRecentPhotos;
}

- (void)addPhoto:(NSDictionary *)photo
{
    NSString *photo_id = [photo valueForKey:FLICKR_PHOTO_ID];
    NSUInteger index = [self.myRecentPhotos indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *obj_id = [obj valueForKey:FLICKR_PHOTO_ID];
        if ([photo_id isEqual:obj_id]) return YES;
        return NO;
    }];
    if (index != NSNotFound) {
        [self.myRecentPhotos removeObjectAtIndex:index];
    }
    if ([self.myRecentPhotos count] >= MAX) {
        [self.myRecentPhotos removeObject:[self.myRecentPhotos lastObject]];
    }
    [self.myRecentPhotos insertObject:photo atIndex:0];
    
    // save in NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.myRecentPhotos forKey:RECENT_KEY];
    [defaults synchronize];
}

+ (RecentPhotos *)recentPhotos
{
    static RecentPhotos *theOneAndOnly = NULL;
    
    @synchronized(self)
    {
        if (!theOneAndOnly) {
            theOneAndOnly = [[RecentPhotos alloc] init];
        }
    }
    return theOneAndOnly;
}

@end
