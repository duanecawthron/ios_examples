//
//  FlickrPhotoAnnotation.h
//  Shutterbug
//
//  Created by Duane Cawthron on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface FlickrPhotoAnnotation : NSObject <MKAnnotation>

+ (FlickrPhotoAnnotation *)annotationForPhoto:(NSDictionary *)photo; // FLickr photo

@property (nonatomic, strong) NSDictionary *photo;

@end
