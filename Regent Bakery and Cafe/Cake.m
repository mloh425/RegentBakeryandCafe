//
//  Cake.m
//  Regent Bakery and Cafe
//
//  Created by Sau Chung Loh on 10/21/15.
//  Copyright © 2015 Regent. All rights reserved.
//

#import "Cake.h"

@implementation Cake
-(NSString *)returnCakeServingSize:(NSString *)cakeSize {
  if ([cakeSize isEqualToString:@"6 inch"]) {
    return @"4 to 6 people";
  } else if ([cakeSize isEqualToString:@"8 inch"]) {
    return @"8 to 10 people";
  } else if ([cakeSize isEqualToString:@"10 inch"]) {
    return @"12 to 15 people";
  } else if ([cakeSize isEqualToString:@"Quarter Sheet"]) {
    return @"15 to 20 people";
  } else if ([cakeSize isEqualToString:@"Half Sheet"]) {
    return @"35 to 40 people";
  } else if ([cakeSize isEqualToString:@"Three Quarter Sheet"]) {
    return @"55 to 60 people";
  } else { //Full Sheet
    return @"75 to 80 people";
  }
}
@end
