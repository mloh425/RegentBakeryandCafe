//
//  Cake.h
//  Regent Bakery and Cafe
//
//  Created by Sau Chung Loh on 10/21/15.
//  Copyright © 2015 Regent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

@interface Cake : NSObject
@property (strong, nonatomic) NSString *flavor;
@property (strong, nonatomic) NSString *cakeDescription;
@property (strong, nonatomic) NSArray *photos; 
@property (strong, nonatomic) NSMutableDictionary *sizePricing;
@property (strong, nonatomic) NSArray *sortedSizePricingKeys;
@property (strong, nonatomic) NSString *imageName;
-(NSString *)returnCakeServingSize:(NSString *)cakeSize;
@end
