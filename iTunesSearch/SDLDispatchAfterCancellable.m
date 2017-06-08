//
//  SDLDispatchAfterCancellable.h
//  iTunesSearch
//
//  Creates a cancellable dispatch operation
//

#import "SDLDispatchAfterCancellable.h"
#import "SDLCancellable.h"


SDLCancellable *dispatch_after_cancellable(dispatch_time_t when, dispatch_queue_t queue, dispatch_block_t block) {
    
    SDLCancellable __block *cancellable = [SDLCancellable new];
    
    dispatch_after(when, queue, ^{
        // If the task has not been canceled, call the block, otherwise do nothing
        if (cancellable.isCancelled == false) {
            block();
        }
    });
    
    return cancellable;
}

