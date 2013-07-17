//
//  AddNewDonationViewController.h
//  DonationTracker
//
//  Created by Mohammad Azam on 7/3/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Donation.h"
#import "UITextField+Additions.h"


@class AddNewDonationViewController;

typedef void (^AddNewDonationSaveBlock) (Donation *donation,AddNewDonationViewController *controller);

typedef void (^AddNewDonationCloseBlock) (AddNewDonationViewController *controller);

@interface AddNewDonationViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *donationNames;
}

@property (nonatomic,copy) AddNewDonationSaveBlock addNewDonationSaveBlock;
@property (nonatomic,copy) AddNewDonationCloseBlock addNewDonationCloseBlock;

@end
