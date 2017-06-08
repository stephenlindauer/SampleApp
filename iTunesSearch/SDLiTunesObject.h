//
//  SDLiTunesObject.h
//  iTunesSearch
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SDLiTunesObject : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *artworkUrl;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSString *itunesUrl;


+ (SDLiTunesObject *)objectFromDictionary:(NSDictionary *)dictionary;

- (void)fetchArtworkImage:(void (^)(UIImage *image))success;

@end
