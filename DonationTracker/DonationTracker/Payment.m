//
//  Payment.m
//  DonationTracker
//
//  Created by Mohammad Azam on 7/8/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "Payment.h"

@implementation Payment


-(BOOL) isReceiptAttached
{
    return ([self.receiptPath length] > 0);
}

@end
