//
//  MainMenuViewController.h
//  Regent Bakery & Cafe
//
//  Created by Cathy Oun on 10/9/15.
//  Copyright © 2015 Regent Bakery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSTimer *timer;

@end
