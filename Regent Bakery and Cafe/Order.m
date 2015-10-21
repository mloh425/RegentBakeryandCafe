//
//  Order.m
//  Regent Bakery and Cafe
//
//  Created by Sau Chung Loh on 10/21/15.
//  Copyright © 2015 Regent. All rights reserved.
//

#import "Order.h"

@implementation Order
@dynamic customerEmail;
@dynamic customerNumber;
@dynamic pickupLocation;
@dynamic orderDate;
@dynamic pickupDate;
@dynamic size;
@dynamic flavor;
@dynamic message;
@dynamic price;

+ (void)load {
  [self registerSubclass];
}

+ (NSString *__nonnull)parseClassName {
  return @"Order";
}

//Pass in # of people, retrieve size [Key] and price [Value] or just return size, save it

//Need access to a setter method for the cake's size/flavor? should each square be tied to a cake object?
@end
