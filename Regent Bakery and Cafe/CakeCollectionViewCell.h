//
//  CakeCollectionViewCell.h
//  Regent Bakery & Cafe
//
//  Created by Cathy Oun on 10/15/15.
//  Copyright © 2015 Regent Bakery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CakeCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cakeImageView;
@property (strong, nonatomic) IBOutlet UILabel *cakeName;

@end
