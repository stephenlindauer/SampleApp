//
//  SDLiTunesSearchController.m
//  iTunesSearch
//

#import "SDLiTunesSearchController.h"
#import "SDLiTunesObject.h"
#import "SDLCancellable.h"
#import "SDLDispatchAfterCancellable.h"


@interface SDLiTunesSearchController () {
    SDLCancellable *_cancellable;
}

@end

@implementation SDLiTunesSearchController


- (void)searchForTerm:(NSString *)term
{
    // Cancel the pending operation (if applicable)
    [_cancellable cancel];
    
    // Empty search, clear results
    if (term.length == 0) {
        [self.delegate searchController:self returnedSearchResults:@[]];
        return;
    }
    
    // Replace spaces with +
    NSString *searchString = [term stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    // Delay calling API in case user is still typing
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.3f * NSEC_PER_SEC);
    _cancellable = dispatch_after_cancellable(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@", searchString]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            // Catch any errors from the request
            if (error != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate searchController:self failedWithError:error];
                });
                return;
            }
            
            NSError *jsonError = nil;
            
            // Get JSON from response
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            // Catch any json serialization issues
            if (jsonError != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate searchController:self failedWithError:jsonError];
                });
                return;
            }
            
            // Deserialize results into SDLiTunesObjects and return
            else {
                NSUInteger numberOfResults = [responseDict[@"resultCount"] integerValue];
                NSMutableArray *results = [NSMutableArray arrayWithCapacity:numberOfResults];
                
                // Deserialize
                for (NSDictionary *searchResult in responseDict[@"results"]) {
                    SDLiTunesObject *object = [SDLiTunesObject objectFromDictionary:searchResult];
                    [results addObject:object];
                }
                
                // Get back on main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate searchController:self returnedSearchResults:results];
                });
            }
            
        }];
        
        // Make the request
        [task resume];
        
    });
}


@end
