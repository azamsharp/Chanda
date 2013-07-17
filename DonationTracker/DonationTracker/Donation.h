//
//  Donation.h
//  DonationTracker
//
//  Created by Mohammad Azam on 7/3/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Donation : NSObject
{
    
}

@property (nonatomic,assign) int donationId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *description;
@property (nonatomic,assign) float pledgedAmount;
@property (nonatomic,assign) float remainingAmount;
@property (nonatomic,assign) float paidAmount; 

@end
