//
//  HistoryService.m
//  DonationTracker
//
//  Created by Mohammad Azam on 7/10/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "HistoryService.h"

@implementation HistoryService

-(NSMutableArray *) getAll
{
    NSMutableArray *donationPayments = [NSMutableArray array];
    
    [db open];
    
    FMResultSet *result = [db executeQuery:@"SELECT d.name,dp.donationPaymentId,dp.donationId,dp.receiptPath,dp.amount,dp.dateCreated,dp.dateModified FROM DonationPayments dp JOIN Donations d ON dp.donationId = d.donationId ORDER BY dp.dateCreated DESC"];
    
    while([result next])
    {
        Payment *payment = [[Payment alloc] init];
        payment.amount = [result doubleForColumn:@"amount"];
        payment.dateCreated = [result stringForColumn:@"dateCreated"];
        payment.dateModified = [result stringForColumn:@"dateModified"];
        payment.donation = [[Donation alloc] init];
        payment.donation.donationId = [result intForColumn:@"donationId"];
        payment.donation.name = [result stringForColumn:@"name"];
        payment.receiptPath = [result stringForColumn:@"receiptPath"];
        
        if([payment.receiptPath length] > 0)
        {
            payment.receiptMessage = @"Receipt Attached";
        }
        
        
        [donationPayments addObject:payment];
    }
    
    [db close];
    
    return donationPayments;
}

@end
