//
//  Payment.h
//  DonationTracker
//
//  Created by Mohammad Azam on 7/8/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Donation.h"

@interface Payment : NSObject
{
    
}

@property (nonatomic,assign) int paymentId;
@property (nonatomic,strong) Donation *donation;
@property (nonatomic,copy) NSString *receiptPath;
@property (nonatomic,copy) NSString *receiptMessage;
@property (nonatomic,assign) float amount;
@property (nonatomic,assign) BOOL isReceiptAttached;
@property (nonatomic,copy) NSString *dateCreated;
@property (nonatomic,copy) NSString *dateModified; 

@end
