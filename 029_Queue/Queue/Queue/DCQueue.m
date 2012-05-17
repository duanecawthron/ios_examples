//
//  DCQueue.m
//  derived from https://github.com/esromneb/ios-queue-object/
//

#import "DCQueue.h"

@interface DCQueue ()

@property (nonatomic, strong) NSMutableArray *queue;

@end

@implementation DCQueue

@synthesize queue = _queue;

// Add to the tail of the queue (no one likes it when people cut in line!)
-(void) enqueue:(id)anObject {
    [self.queue addObject:anObject];
    //this method automatically adds to the end of the array
}

-(id) dequeue {
    if ([self.queue count] == 0) {
        return nil;
    }
    id queueObject = [self.queue objectAtIndex:0];
    [self.queue removeObjectAtIndex:0];       // beginning of the array is the back of the queue
    return queueObject;
}

-(id) peek:(int)index {
	if (self.queue.count==0 || index<0) {
        return nil;
    }
	return [self.queue objectAtIndex:index];
}

// if there aren't any objects in the queue
// peek returns nil, and we will too
-(id) peekHead
{
	return [self peek:0];
}

// if 0 objects, we call peek:-1 which returns nil
-(id) peekTail
{
	return [self peek:self.queue.count-1];
}

-(BOOL) empty {
    return self.queue.count==0;
}

- (id)init
{
    if (self = [super init]) {
        self.queue = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

- (void)dealloc
{
    self.queue = nil;
}

- (NSString *)description
{
    NSString *desc = @"";
    for (id obj in self.queue) {
        desc = [desc stringByAppendingFormat:@"\n %@", obj];
        //NSLog(@"\n %@", obj);
    }
    return desc;
}

@end
