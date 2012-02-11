//
//  Observer.h
//  Key_Value_Observing
//
//  Created by Duane Cawthron on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface Observer : NSObject

@property (nonatomic, strong) NSString *three;

@property (nonatomic, strong) NSString *one_copy;
@property (nonatomic, strong) NSString *two_copy;
@property (nonatomic, strong) NSString *three_copy;

@end
