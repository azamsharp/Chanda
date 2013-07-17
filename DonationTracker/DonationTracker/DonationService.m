//
//  DonationService.m
//  DonationTracker
//
//  Created by Mohammad Azam on 7/3/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "DonationService.h"

@implementation DonationService

-(BOOL) update:(Donation *) donation
{
    [db open];
    
    BOOL result = [db executeUpdate:@"UPDATE Donations SET pledgedAmount = ? WHERE donationId = ?",[NSDecimalNumber numberWithFloat:donation.pledgedAmount],[NSNumber numberWithInt:donation.donationId]];
    
    [db close];
    
    return result;
}

-(Donation *) getById:(int)donationId
{
    Donation *donation = [[Donation alloc] init];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT d.donationId,d.pledgedAmount,d.pledgedAmount - SUM(dp.amount) AS 'remaining', SUM(dp.amount) as 'paid' FROM Donations d LEFT JOIN DonationPayments dp ON d.donationId = dp.donationId WHERE d.donationId = ?",[NSNumber numberWithInt:donationId]];
    
    while([results next])
    {
        donation.donationId = [results intForColumn:@"donationId"];
        donation.pledgedAmount = [results doubleForColumn:@"pledgedAmount"];
        donation.paidAmount = [results doubleForColumn:@"paid"];
        donation.remainingAmount = donation.paidAmount > 0 ? [results doubleForColumn:@"remaining"] : donation.pledgedAmount;
    }
    
    
    [db close];
    
    return donation; 
}

-(BOOL) deleteById:(int)donationId
{
    [db open];
    
   BOOL result = [db executeUpdate:@"DELETE FROM Donations WHERE donationId = ?",[NSNumber numberWithInt:donationId]];
    
    [db close];
    
    return result;
}

-(NSMutableArray *) getAll
{
    NSMutableArray *donations = [NSMutableArray array];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT d.name,d.donationId,d.pledgedAmount,d.pledgedAmount - SUM(dp.amount) AS 'remaining', SUM(dp.amount) as 'paid' FROM Donations d LEFT JOIN DonationPayments dp ON d.donationId = dp.donationId GROUP BY d.donationId;"];
    
    while([results next])
    {
        Donation *donation = [[Donation alloc] init];
        donation.donationId = [results intForColumn:@"donationId"];
        donation.name = [results stringForColumn:@"name"];
        //donation.description = [results stringForColumn:@"description"];
        donation.pledgedAmount = [results doubleForColumn:@"pledgedAmount"];
        donation.remainingAmount = [results doubleForColumn:@"remaining"];
        donation.paidAmount = [results doubleForColumn:@"paid"];
        
         donation.remainingAmount = donation.paidAmount > 0 ? [results doubleForColumn:@"remaining"] : donation.pledgedAmount;
        
        [donations addObject:donation];
    }
    
    [db close];
    
    return donations;
}

-(BOOL) save:(Donation *)donation
{
    [db open];
    
    BOOL result = [db executeUpdate:@"INSERT INTO Donations(name,description,pledgedamount) VALUES (?,?,?)",donation.name,donation.description,[NSDecimalNumber numberWithFloat:donation.pledgedAmount]];
    
    [db close];
    
    return result;
}

@end
