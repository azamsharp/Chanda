//
//  PaymentService.m
//  DonationTracker
//
//  Created by Mohammad Azam on 7/8/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "PaymentService.h"

@implementation PaymentService

-(BOOL) attachReceiptByPaymentId:(Payment *)payment
{
    [db open];
    
    BOOL result = [db executeUpdate:@"UPDATE DonationPayments SET receiptPath = ? WHERE donationPaymentId = ?",payment.receiptPath,[NSNumber numberWithInt:payment.paymentId]];
    
    [db close];
    
    return result;
}

-(BOOL) pay:(Payment *)payment
{
    [db open];
    
    BOOL result = [db executeUpdate:@"INSERT INTO DonationPayments(donationId,receiptPath,amount) VALUES(?,?,?)",[NSNumber numberWithInt:payment.donation.donationId],payment.receiptPath,[[NSDecimalNumber alloc] initWithFloat:payment.amount]];
    
    payment.paymentId = [db lastInsertRowId];
    
    [db close];
    
    return result;
}

@end
