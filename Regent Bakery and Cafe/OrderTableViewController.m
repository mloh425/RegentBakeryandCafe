//
//  OrderTableViewController.m
//  Regent Bakery & Cafe
//
//  Created by Sau Chung Loh on 10/16/15.
//  Copyright © 2015 Regent Bakery. All rights reserved.
//

#import "OrderTableViewController.h"
#import "Order.h"
#import <Parse/Parse.h>
#import <objc/runtime.h>

@interface OrderTableViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *sizePicker;
@property (weak, nonatomic) IBOutlet UITextField *cakeWritingTextField;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickupDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *customerEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *customerPhoneTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *locationPicker;
@property (weak, nonatomic) IBOutlet UILabel *cakeFlavorLabel;
@property (weak, nonatomic) IBOutlet UILabel *servingsLabel;
@property (strong, nonatomic) Order *order; //save using NSUserDefault
@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) UIAlertController *missingFields;
@end

@implementation OrderTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.order = [[Order alloc] init];
  self.cakeFlavorLabel.text = self.selectedCake.flavor;
  self.sizePicker.delegate = self;
  self.sizePicker.dataSource = self;
  self.locationPicker.delegate = self;
  self.locationPicker.dataSource = self;
  self.cakeWritingTextField.delegate = self;
  self.cakeWritingTextField.tag = 101;
  self.customerEmailTextField.delegate = self;
  self.customerEmailTextField.tag = 102;
  self.customerPhoneTextField.delegate = self;
  self.customerPhoneTextField.tag = 103;
  self.locations = @[@"Redmond", @"Capitol Hill"];
  
  //Order properties
  NSString *selectedSize = self.selectedCake.sortedSizePricingKeys[0];
  self.order.size = selectedSize;
  self.order.price = self.selectedCake.sizePricing[selectedSize];
  self.order.pickupLocation = self.locations[0];
  self.pickupDatePicker.datePickerMode = UIDatePickerModeDate;
  self.priceLabel.text = [NSString stringWithFormat:@"$%@",self.order.price];
  self.servingsLabel.text = [NSString stringWithFormat:@"%@", [self.selectedCake returnCakeServingSize:selectedSize]];
  [self pickUpDatePickerSetUp];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pickUpDatePickerSetUp {
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDate *currentDate = [NSDate date];
  NSDateComponents *comps = [[NSDateComponents alloc] init];
  [comps setDay:2];
  NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
  
  //[self.pickupDatePicker setMaximumDate:maxDate];
  [self.pickupDatePicker setMinimumDate:minDate];
}


- (IBAction)addToCartButtonPressed:(UIButton *)sender {
  //loop through all properties
  //if any are nil, create alert view
  //otherwise continue to next VC and save???
  self.order.flavor = self.selectedCake.flavor;
  self.order.orderDate = [NSDate date];
  self.order.pickupDate = self.pickupDatePicker.date;
  self.order.customerNumber = self.customerPhoneTextField.text;
  self.order.customerEmail = self.customerEmailTextField.text;
  self.order.message = self.cakeWritingTextField.text;
  //[self printOrderObjectProperties];
  if ([self checkForNilPropertiesinOrder]) {
    NSLog(@"I can save!");
    NSUserDefaults *saveOrders = [NSUserDefaults standardUserDefaults];
    [saveOrders setObject:self.order forKey:@"savedOrder"];
    //[self.order saveInBackground];
  }
  //[self checkForNilPropertiesinOrder];
  //[self.order saveInBackground];
  
  
  
  //  NSLog(@"%@", self.order.flavor);
  //  NSLog(@"%@", self.order.size); *
  //  NSLog(@"%@", self.order.message); *
  //  NSLog(@"%@", self.order.price); *
  //  NSLog(@"%@", self.order.pickupLocation); *
  //  NSLog(@"%@", self.order.customerEmail); *
  //  NSLog(@"%@", self.order.customerNumber); *
  //  NSLog(@"%@", self.order.orderDate);
  //  NSLog(@"%@", self.order.pickupDate);
}


#pragma mark - PickerView Delegate and Datasource (SizePicker and LocationPicker)
// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  if (pickerView == self.sizePicker) {
    return self.selectedCake.sortedSizePricingKeys[row];
  }
  else {
    return self.locations[row];
  }
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  if (pickerView == self.sizePicker) {
    return self.selectedCake.sortedSizePricingKeys.count;
  } else {
    return self.locations.count;
  }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  if (pickerView == self.sizePicker) { //If is location display location info
    NSString *selectedSize = self.selectedCake.sortedSizePricingKeys[row];
    self.order.size = selectedSize;
    self.order.price = self.selectedCake.sizePricing[selectedSize];
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", self.order.price];
    self.servingsLabel.text = [NSString stringWithFormat:@"%@", [self.selectedCake returnCakeServingSize:selectedSize]];
  } else {
    self.order.pickupLocation = self.locations[row];
    NSLog(@"%@",self.order.pickupLocation);
  }

}
#pragma mark - Check for nil properties
-(void)printOrderObjectProperties {
  //Add to car method should have a helper method that checks if any of these are nil.
  //Maybe even an email validator.
  id OrderClass = objc_getClass("Order");
  unsigned int outCount, i;
  objc_property_t *properties = class_copyPropertyList(OrderClass, &outCount);

  for (i = 0; i < outCount; i++) {
    objc_property_t property = properties[i];
    NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
    NSLog(@"Property %@ Value: %@", name, [self.order valueForKey:name]);
  }
}

-(BOOL)checkForNilPropertiesinOrder {
  id OrderClass = objc_getClass("Order");
  unsigned int outCount, i;
  objc_property_t *properties = class_copyPropertyList(OrderClass, &outCount);
  
  //Loops through ALL properties of our order object.
  for (i = 0; i < outCount; i++) {
    objc_property_t property = properties[i];
    NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
    //Checks to see if customer email or phone number are nil. We need this for pickup verification.
    if ([name isEqualToString:@"customerEmail"] || [name isEqualToString:@"customerNumber"]) {
      NSString *value = [self.order valueForKey:name];
      if (value.length == 0 || !value) {
        NSLog(@"%@ field is nil", name);
        self.missingFields = [UIAlertController alertControllerWithTitle:@"Missing Fields" message:[NSString stringWithFormat:@"Missing email or phone number."] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        [self.missingFields addAction:okay];
        [self presentViewController:self.missingFields animated:true completion:nil];
        return false;
      }
    }
    NSLog(@"Property %@ Value: %@", name, [self.order valueForKey:name]);
  }
  NSLog(@"All good");
  return true;
}

#pragma mark - UITextView Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField.tag == 101) {
    self.order.message = self.cakeWritingTextField.text;
  } else if (textField.tag == 102) {
    self.order.customerEmail = self.customerEmailTextField.text;
  } else {
    self.order.customerNumber = self.customerPhoneTextField.text;
  }
  [textField resignFirstResponder];
  return true;
}

//Limits the number of characters that can be entered for the cake message as space is limited.
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  if (textField.tag == 101) {
    if (range.length + range.location > textField.text.length) {
      return false;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 26; //Max of 26 characters for now.
  } else {
    return true;
  }
}
@end
