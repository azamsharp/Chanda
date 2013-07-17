//
//  PaymentService.h
//  DonationTracker
//
//  Created by Mohammad Azam on 7/8/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Payment.h"
#import "BaseService.h"

@interface PaymentService : BaseService
{

}

-(BOOL) attachReceiptByPaymentId:(Payment *) payment; 
-(BOOL) pay:(Payment *) payment;

@end
