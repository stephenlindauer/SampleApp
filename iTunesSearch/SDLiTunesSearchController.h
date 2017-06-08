//
//  SDLiTunesSearchController.h
//  iTunesSearch
//

#import <Foundation/Foundation.h>

@class SDLiTunesSearchController;
@class SDLiTunesObject;

@protocol SDLiTunesSearchControllerDelegate

- (void)searchController:(SDLiTunesSearchController *)searchController returnedSearchResults:(NSArray<SDLiTunesObject *> *)results;
- (void)searchController:(SDLiTunesSearchController *)searchController failedWithError:(NSError *)error;

@end


@interface SDLiTunesSearchController : NSObject

@property (nonatomic, strong) id<SDLiTunesSearchControllerDelegate> delegate;

- (void)searchForTerm:(NSString *)term;

@end
