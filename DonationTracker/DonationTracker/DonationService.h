//
//  DonationService.h
//  DonationTracker
//
//  Created by Mohammad Azam on 7/3/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Donation.h"
#import "BaseService.h"

@interface DonationService : BaseService
{

}

-(BOOL) save:(Donation *) donation;
-(NSMutableArray *) getAll;
-(Donation *) getById:(int) donationId;
-(BOOL) update:(Donation *) donation;
-(BOOL) deleteById:(int) donationId;

@end
