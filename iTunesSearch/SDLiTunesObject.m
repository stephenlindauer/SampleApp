//
//  SDLiTunesObject.m
//  iTunesSearch
//

#import "SDLiTunesObject.h"

@implementation SDLiTunesObject

+ (SDLiTunesObject *)objectFromDictionary:(NSDictionary *)dictionary
{
    SDLiTunesObject *object = [SDLiTunesObject new];
    
    object.name = dictionary[@"trackName"];
    object.artistName = dictionary[@"artistName"];
    object.albumName = dictionary[@"collectionName"];
    object.artworkUrl = dictionary[@"artworkUrl100"];
    object.itunesUrl = dictionary[@"trackViewUrl"];
    
    return object;
}

- (void)fetchArtworkImage:(void (^)(UIImage *image))success
{

    // Fetch album image on background queue so not to block main queue
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL *url = [NSURL URLWithString:self.artworkUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        // Set back on main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            success(image);
        });
    });
}

@end
