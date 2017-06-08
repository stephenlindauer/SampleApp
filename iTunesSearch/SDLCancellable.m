//
//  SDLCancellable.m
//  iTunesSearch
//

#import "SDLCancellable.h"

@implementation SDLCancellable

- (void)cancel
{
    self.isCancelled = @YES;
}

@end
