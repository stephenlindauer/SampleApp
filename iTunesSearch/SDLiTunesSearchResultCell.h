//
//  SDLiTunesSearchResultCell.h
//  iTunesSearch
//

#import <UIKit/UIKit.h>

@class SDLiTunesObject;

@interface SDLiTunesSearchResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;

@property (nonatomic, strong) SDLiTunesObject *searchObject;

@end
