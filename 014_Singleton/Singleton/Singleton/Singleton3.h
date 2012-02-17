//
//  Singleton3.h
//  Singleton
//
//  Created by Duane Cawthron on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton3 : NSObject

+ (Singleton3 *)singleton3; // Factory always returns the same pointer to the one and only Singleton object

@end
