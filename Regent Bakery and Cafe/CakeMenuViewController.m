//
//  CakeMenuViewController.m
//  Regent Bakery & Cafe
//
//  Created by Sau Chung Loh on 10/13/15.
//  Copyright © 2015 Regent Bakery. All rights reserved.
//

#import "CakeMenuViewController.h"
#import "OrderTableViewController.h"
#import "CakeCollectionViewCell.h"
#import "Cake.h"
@interface CakeMenuViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) CakeCollectionViewCell *cell;
@property (strong, nonatomic) NSMutableArray *cakes;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIImageView *largeImage;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;
@property (strong, nonatomic) Cake *selectedCake;

@end




//Pass reference of selected cake to order/customization view controller -> maybe just go to Detail then order?
@implementation CakeMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.detailView.hidden = true;
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  self.cakes = [[NSMutableArray alloc]init];
  [self parseCakeJSON];
  
  
}
- (IBAction)selectCake:(UIButton *)sender {
  
//  OrderViewController *orderView = [[OrderViewController alloc] init];
 
//  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: [NSBundle mainBundle]];
//  OrderViewController *orderView = [storyboard instantiateViewControllerWithIdentifier:@"OrderView"];
  
  
//  [self.navigationController pushViewController:orderView animated:true];
 // [self performSegueWithIdentifier:@"ShowOrderForm" sender:sender];
  
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqual: @"ShowOrderForm"]) {
    OrderTableViewController *orderView = [segue destinationViewController];
    orderView.selectedCake = self.selectedCake;
  }
}
- (void)parseCakeJSON {
    self.cakes = [[NSMutableArray alloc] init];
    NSError *deserializingError;
    NSString *pathToLocalJSON = [[NSBundle mainBundle] pathForResource:@"cakes" ofType:@"json"];
    NSData *contentOfLocalFile = [NSData dataWithContentsOfFile:pathToLocalJSON];
    NSArray *rootObject = [NSJSONSerialization JSONObjectWithData:contentOfLocalFile options:0 error:&deserializingError];
  
    //  NSLog(@"%lu", (unsigned long)rootObject.count);
  
    //Ideally I want to parse this in the menu VC and go from there...
    //Be able to select sizes
    //Writing
    //Set the price
    //Add to cart.
    for (NSDictionary *cake in rootObject) {
      Cake *flavor = [[Cake alloc] init];
      flavor.flavor = cake[@"flavor"];
      flavor.cakeDescription = cake[@"cakeDescription"];
      flavor.sizePricing = cake[@"sizePricing"];
      flavor.imageName = cake[@"image"];
      flavor.sortedSizePricingKeys = [flavor.sizePricing keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
          
          return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
          
          return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
      }];
      [self.cakes addObject:flavor];
      
//          NSLog(@"%@", flavor.sizePricing);
//          NSLog(@"%@", flavor.sortedSizePricingKeys);
//          NSLog(@"%@", flavor.flavor);
//          NSLog(@"%@", flavor.sizePricing);

    }
}
- (IBAction)closeButtonClicked:(id)sender {
  self.detailView.hidden = true;
  self.closeButton.highlighted = true;
  [sender setSelected:true];
  self.collectionView.userInteractionEnabled = true;
}

#pragma CollectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.cakes.count; // 16
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CakeCollectionViewCell *cell = (CakeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CakeCell" forIndexPath:indexPath];
  Cake *currCake = self.cakes[indexPath.row];
  cell.cakeImageView.image = [UIImage imageNamed: currCake.imageName];
  cell.cakeName.text = currCake.flavor;
  self.cell = cell;
  return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
      //its iPhone. Find out which one
      CGSize result = [[UIScreen mainScreen] bounds].size;
      NSInteger screenHeight = result.height;
      switch (screenHeight) {
        case 480:
          //old
          return CGSizeMake(130.f, 120.f);
        case 568:
          // iphone 5
          return CGSizeMake(140.f, 150.f);
        case 667:
          // iphone 6
          return CGSizeMake(160.f, 160.f);
        case 736:
          return CGSizeMake(180.f, 170.f);
        default:
          break;
      }
    }
    else
    {
      return CGSizeMake(230.f, 210.f);
    }
  return CGSizeMake(0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  // show a bigger image?
  self.selectedCake = self.cakes[indexPath.row];
  NSLog(@"%@",self.selectedCake.flavor);
  self.largeImage.image = [UIImage imageNamed:self.selectedCake.imageName];
  self.detailTextView.text = self.selectedCake.cakeDescription;
  self.detailView.hidden = false;
  self.collectionView.userInteractionEnabled = false;
}


@end
