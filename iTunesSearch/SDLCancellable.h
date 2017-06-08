//
//  SDLCancellable.h
//  iTunesSearch
//

#import <Foundation/Foundation.h>

@interface SDLCancellable : NSObject

@property (atomic, assign) BOOL isCancelled;

- (void)cancel;

@end
