//
//  MainMenuViewController.m
//  Regent Bakery & Cafe
//
//  Created by Cathy Oun on 10/9/15.
//  Copyright © 2015 Regent Bakery. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()
@property int currentImageIndex;
@end

@implementation MainMenuViewController
@synthesize images;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Do any additional setup after loading the view.
  self.currentImageIndex = 0;
  // set up the images array
  images = @[@"chestnut", @"wedding", @"wedding2"];
  [self.imageView setImage:[UIImage imageNamed: images[self.currentImageIndex]]];
 
  self.timer = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                           target: self
                                         selector: @selector(handleTimer:)
                                         userInfo: nil
                                          repeats: YES];
//  [self fadeInEffect];

}

- (void) handleTimer: (NSTimer *) timer {
  self.imageView.hidden = false;
  self.currentImageIndex++;
//  NSLog(@"%d",self.currentImageIndex);

  if ( self.currentImageIndex == images.count) {
    self.currentImageIndex = 0;
//  NSLog(@"%d",self.currentImageIndex);
  }
//  [self fadeInEffect];
  [self.imageView setImage:[UIImage imageNamed: images[self.currentImageIndex]]];
  
 

}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void) fadeInEffect {
  self.imageView.alpha = 1.0f;
  
  // Then fades it away after 2 seconds
  [UIView animateWithDuration:0.4 delay:2.0 options:0 animations:^{
    self.imageView.alpha = 0.0f;
  } completion:^(BOOL finished) {
    self.imageView.hidden = true;
  }];
}

@end
