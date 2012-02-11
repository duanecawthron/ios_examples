//
//  Model.h
//  Key_Value_Observing
//
//  Created by Duane Cawthron on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic, strong) NSString *one;
@property (nonatomic, strong) NSString *two;

+ (Model *)model;

@end
