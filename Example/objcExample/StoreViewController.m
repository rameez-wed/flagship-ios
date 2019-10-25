//
//  StoreViewController.m
//  objcExample
//
//  Created by Adel on 25/10/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#import "StoreViewController.h"
@import FlagShip;

@interface StoreViewController ()

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set Message Label
    msgLabel.text =  [[ABFlagShip sharedInstance] getModification:@"cta_text" defaultString:@"Default" activate:YES];
    
}


- (IBAction)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


// Send All Event Possible
- (IBAction)sendEvent{
    
    
    // Send Page
    [[ABFlagShip sharedInstance] sendPageEvent: [[FSPageTrack alloc] init:@"StorePage"]];
    
    
    // Send Item
    FSItemTrack * itemTrack = [[FSItemTrack alloc] initWithTransactionId:@"Ttransac" name:@"nameTransac"];
    itemTrack.name = @"nameTrack";
    itemTrack.price = @0;
    itemTrack.quantity = @12;
    itemTrack.code = @"codeTrack";
    [[ABFlagShip sharedInstance] sendItemEvent:itemTrack];
    
    
    // Send Transaction
    FSTransactionTrack * transac = [[FSTransactionTrack alloc] initWithTransactionId:@"transacObjc" affiliation:@"affilObjc"];
    transac.userIp  = @"1.1.1.1";
    [[ABFlagShip sharedInstance] sendTransactionEvent:transac];
    
    
    
    
    // Send Event Track
    [[ABFlagShip sharedInstance] sendEventTrack:[[FSEventTrack alloc] initWithEventCategory:1 eventAction:@"aaa"]];

 }

@end
