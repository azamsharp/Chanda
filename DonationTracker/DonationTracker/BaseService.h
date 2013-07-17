//
//  BaseService.h
//  DonationTracker
//
//  Created by Mohammad Azam on 7/10/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "AppHelper.h"

@interface BaseService : NSObject
{
    FMDatabase *db;
}
@end
