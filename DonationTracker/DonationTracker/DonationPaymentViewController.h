//
//  DonationPaymentViewController.h
//  DonationTracker
//
//  Created by Mohammad Azam on 7/7/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Donation.h"
#import "Payment.h"
#import "BaseService.h"
#import "PaymentService.h"
#import "DonationService.h"
#import "TSMessage.h"
#import "UITextField+Additions.h"
#import "AppHelper.h"

@interface DonationPaymentViewController : UITableViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    PaymentService *paymentService;
    DonationService *donationService;
    UIImagePickerController *imagePicker;
    Payment *payment;
}

@property (nonatomic,strong) Donation *donation;

@end
