//
//  SDLiTunesSearchResultCell.m
//  iTunesSearch
//

#import "SDLiTunesSearchResultCell.h"
#import "SDLiTunesObject.h"


@implementation SDLiTunesSearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Give the image view rounded edges
    self.previewImageView.layer.cornerRadius = 8.0f;
    self.previewImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.previewImageView.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSearchObject:(SDLiTunesObject *)searchObject
{
    _searchObject = searchObject;
    
    // Set up cell
    self.nameLabel.text = searchObject.name;
    self.albumNameLabel.text = searchObject.albumName;
    self.artistNameLabel.text = searchObject.artistName;
    self.previewImageView.image = nil; // Clear old image if cell was reused
    
    [searchObject fetchArtworkImage:^(UIImage *image) {
        self.previewImageView.image = image;
    }];
    
}

@end
