//
//  PhotoViewController.m
//  Flickr
//
//  Created by Duane Cawthron on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@interface PhotoViewController() <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation PhotoViewController

@synthesize photo = _photo;
@synthesize imageView = _imageView;
@synthesize scrollView = _scrollView;

- (void)loadImage
{
    if (self.imageView) {
        if (self.photo) {
            NSURL *imageURL = [FlickrFetcher urlForPhoto:self.photo format:FlickrPhotoFormatLarge];
            dispatch_queue_t imageDownloadQ = dispatch_queue_create("PhotoViewController image downloader", NULL);
            dispatch_async(imageDownloadQ, ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.imageView.image = image;
                    self.scrollView.contentSize = self.imageView.image.size;
                    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
                    // zoom to show the whole image
                    [self.scrollView zoomToRect:self.imageView.frame animated:YES];
                });
            });
            dispatch_release(imageDownloadQ);
        } else {
            self.imageView.image = nil;
        }
    }
}

- (void)setPhoto:(NSDictionary *)photo
{
    if (![_photo isEqual:photo]) {
        _photo = photo;
        if (self.imageView.window) {    // we're on screen, so update the image
            [self loadImage];           
        } else {                        // we're not on screen, so no need to loadImage (it will happen next viewWillAppear:)
            self.imageView.image = nil; // but image has changed (so we can't leave imageView.image the same, so set to nil)
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.imageView.image && self.photo) [self loadImage];
}

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
*/

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = self.imageView.image.size;
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)viewDidUnload
{
    self.imageView = nil;
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
