//
//  OrderTableViewController.h
//  Regent Bakery & Cafe
//
//  Created by Sau Chung Loh on 10/16/15.
//  Copyright © 2015 Regent Bakery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cake.h"


@interface OrderTableViewController : UITableViewController 
  @property (strong, nonatomic) Cake *selectedCake;
@end
