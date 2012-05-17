//
//  DCQueue.h
//  derived from https://github.com/esromneb/ios-queue-object/
//

#import <Foundation/Foundation.h>

@interface DCQueue : NSObject

-(id) dequeue;
-(void) enqueue:(id)obj;
-(id) peek:(int)index;
-(id) peekHead;
-(id) peekTail;
-(BOOL) empty;

@end