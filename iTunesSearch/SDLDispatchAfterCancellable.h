//
//  SDLDispatchAfterCancellable.h
//  iTunesSearch
//
//  Creates a cancellable dispatch operation
//  

#import <Foundation/Foundation.h>

@class SDLCancellable;

SDLCancellable *dispatch_after_cancellable(dispatch_time_t when, dispatch_queue_t queue, dispatch_block_t block);
