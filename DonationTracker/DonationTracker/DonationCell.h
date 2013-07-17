//
//  DonationCell.h
//  DonationTracker
//
//  Created by Mohammad Azam on 7/3/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Donation.h"

@interface DonationCell : UITableViewCell
{
    
}

-(void) bind:(Donation *) donation;

@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet UILabel *pledgedAmountLabel;
@property (nonatomic,weak) IBOutlet UILabel *paidAmountLabel;
@property (nonatomic,weak) IBOutlet UILabel *remainingAmountLabel;

@end
