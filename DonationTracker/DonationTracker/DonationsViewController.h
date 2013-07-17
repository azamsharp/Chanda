//
//  DonationsViewController.h
//  DonationTracker
//
//  Created by Mohammad Azam on 6/28/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewDonationViewController.h"
#import "DonationCell.h"
#import "DonationService.h"
#import "DonationPaymentViewController.h"

@interface DonationsViewController : UITableViewController
{
    DonationService *donationService;
    NSMutableArray *donations;
}
@end
