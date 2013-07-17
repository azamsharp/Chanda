//
//  HistoryService.h
//  DonationTracker
//
//  Created by Mohammad Azam on 7/10/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"
#import "Payment.h"

@interface HistoryService : BaseService
{
    
}

@property (nonatomic,strong) Donation *donation;

-(NSMutableArray *) getAll;

@end
