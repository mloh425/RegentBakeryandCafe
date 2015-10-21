//
//  LocationsViewController.m
//  Regent Bakery & Cafe
//
//  Created by Cathy Oun on 10/9/15.
//  Copyright © 2015 Regent Bakery. All rights reserved.
//

#import "LocationsViewController.h"
#import <MapKit/MapKit.h>

@interface LocationsViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIView *captiolHillView;
@property (strong, nonatomic) IBOutlet UIView *milkView;
@property (strong, nonatomic) IBOutlet MKMapView *captiolMapView;
@property (strong, nonatomic) IBOutlet UIImageView *regentCapLogo;
@property (strong, nonatomic) IBOutlet UILabel *capPhoneNum;
@property (strong, nonatomic) IBOutlet UILabel *capHoursLabel;
@property (strong, nonatomic) IBOutlet UILabel *capAddress;

@property (strong, nonatomic) IBOutlet UIView *redmondView;
@property (strong, nonatomic) IBOutlet UILabel *redHoursLabel;
@property (strong, nonatomic) IBOutlet MKMapView *redmondMapView;
@property (strong, nonatomic) IBOutlet UILabel *redmondAddress;
@property (strong, nonatomic) IBOutlet UILabel *redmondPhoneNum;

@end

@implementation LocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.captiolMapView.delegate = self;
  self.redmondMapView.delegate = self;
  
  self.captiolHillView.layer.cornerRadius = 8;
  self.redmondView.layer.cornerRadius = 8;
  self.capHoursLabel.text = @"Mon\t\t5pm-10pm\nTue\t\t5pm-10pm\nWed\t\t5pm-10pm\nThu\t\t10am-10pm\nFri\t\t10am-10pm\nSat\t\t10am-10pm\nSun\t\t10am-10pm";
  self.redHoursLabel.text = @"Mon\t\t9am-9pm\nTue\t\t9am-9pm\nWed\t\t9am-9pm\nThu\t\t9am-9pm\nFri\t\t9am-9pm\nSat\t\t9am-9pm\nSun\t\t9am-7pm";
  
  if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
  {
    //its iPhone. Find out which one
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480)
    {
      // iPhone Classic
    }
    else if(result.height == 568)
    {
      [self.capHoursLabel setFont:[UIFont systemFontOfSize:12]];
      [self.capAddress setFont:[UIFont systemFontOfSize:12]];
      [self.capPhoneNum setFont:[UIFont systemFontOfSize:12]];
 
      [self.redHoursLabel setFont:[UIFont systemFontOfSize:12]];
      [self.redmondAddress setFont:[UIFont systemFontOfSize:12]];
      [self.redmondPhoneNum setFont:[UIFont systemFontOfSize:12]];

    }
    else if(result.height == 667)
    {
      [self.capHoursLabel setFont:[UIFont systemFontOfSize:15]];
      [self.capHoursLabel sizeToFit];
      [self.capPhoneNum setFont:[UIFont systemFontOfSize:15]];
      [self.capAddress setFont:[UIFont systemFontOfSize:15]];
      self.capHoursLabel.text = @"Mon\t5pm-10pm\nTue\t\t5pm-10pm\nWed\t5pm-10pm\nThu\t\t10am-10pm\nFri\t\t10am-10pm\nSat\t\t10am-10pm\nSun\t\t10am-10pm";
      
      [self.redHoursLabel setFont:[UIFont systemFontOfSize:15]];
      [self.redHoursLabel sizeToFit];
      [self.redmondAddress setFont:[UIFont systemFontOfSize:15]];
      [self.redmondPhoneNum setFont:[UIFont systemFontOfSize:15]];
      self.redHoursLabel.text = @"Mon\t9am-9pm\nTue\t\t9am-9pm\nWed\t9am-9pm\nThu\t\t9am-9pm\nFri\t\t9am-9pm\nSat\t\t9am-9pm\nSun\t\t9am-7pm";

    }
    else if(result.height == 736)
    {
      // captiol hill
      [self.capHoursLabel setFont:[UIFont systemFontOfSize:17]];
      [self.capPhoneNum setFont:[UIFont systemFontOfSize:17]];
      [self.capAddress setFont:[UIFont systemFontOfSize:17]];
      self.capHoursLabel.text = @"Mon\t5pm-10pm\nTue\t\t5pm-10pm\nWed\t5pm-10pm\nThu\t10am-10pm\nFri\t\t10am-10pm\nSat\t\t10am-10pm\nSun\t10am-10pm";
      
      
      [self.redHoursLabel setFont:[UIFont systemFontOfSize:17]];
      [self.redHoursLabel sizeToFit];
      [self.redmondAddress setFont:[UIFont systemFontOfSize:17]];
      [self.redmondPhoneNum setFont:[UIFont systemFontOfSize:17]];
      self.redHoursLabel.text = @"Mon\t9am-9pm\nTue\t\t9am-9pm\nWed\t9am-9pm\nThu\t9am-9pm\nFri\t\t9am-9pm\nSat\t\t9am-9pm\nSun\t9am-7pm";  
    }
  }
  else
  {
    //its iPad
    
    [self.capHoursLabel setFont:[UIFont systemFontOfSize:24]];
    [self.capPhoneNum setFont:[UIFont systemFontOfSize:24]];
    [self.capAddress setFont:[UIFont systemFontOfSize:24]];
    self.capHoursLabel.text = @"Mon\t\t5pm-10pm\nTue\t\t5pm-10pm\nWed\t\t5pm-10pm\nThu\t\t10am-10pm\nFri\t\t\t10am-10pm\nSat\t\t10am-10pm\nSun\t\t10am-10pm";
    [self.redHoursLabel setFont:[UIFont systemFontOfSize:24]];
    [self.redmondAddress setFont:[UIFont systemFontOfSize:24]];
    [self.redmondPhoneNum setFont:[UIFont systemFontOfSize:24]];
    self.redHoursLabel.text = @"Mon\t\t5pm-10pm\nTue\t\t5pm-10pm\nWed\t\t5pm-10pm\nThu\t\t10am-10pm\nFri\t\t\t10am-10pm\nSat\t\t10am-10pm\nSun\t\t10am-10pm";
  }
  
  [self showLocationOnMaps];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void) showLocationOnMaps {
  // captiol hill
  CLLocationCoordinate2D captiol = CLLocationCoordinate2DMake(47.615397, -122.314106);
  [self.captiolMapView setRegion:MKCoordinateRegionMakeWithDistance(captiol, 100, 100)animated:true];
  MKPointAnnotation *pinCap = [[MKPointAnnotation alloc] init];
  pinCap.coordinate = CLLocationCoordinate2DMake(47.615397, -122.314106);
  [self.captiolMapView addAnnotation:pinCap];
  
  // redmond
  CLLocationCoordinate2D redmond = CLLocationCoordinate2DMake(47.631469, -122.138668);
  [self.redmondMapView setRegion:MKCoordinateRegionMakeWithDistance(redmond, 100, 100)animated:true];
  MKPointAnnotation *pinRed = [[MKPointAnnotation alloc] init];
  pinRed.coordinate = CLLocationCoordinate2DMake(47.631469, -122.138668);
  [self.redmondMapView addAnnotation:pinRed];
}


@end
