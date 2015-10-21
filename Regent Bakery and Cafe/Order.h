//
//  Order.h
//  Regent Bakery and Cafe
//
//  Created by Sau Chung Loh on 10/21/15.
//  Copyright © 2015 Regent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cake.h"
#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

@interface Order : PFObject <PFSubclassing>

//Logistics
@property (strong, nonatomic) NSString *customerEmail;
@property (strong, nonatomic) NSString *customerNumber;
@property (strong, nonatomic) NSString *pickupLocation;
@property (strong, nonatomic) NSDate *orderDate;
@property (strong, nonatomic) NSDate *pickupDate;
@property (strong, nonatomic) NSString *size;
@property (strong, nonatomic) NSString *flavor;
//Cake
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSNumber *price;

//Number of people per cake? for filtering - recommendation purposes?

//Dictionary of available sizes to prices - May need to find a way to sort/display them when ordering


@end