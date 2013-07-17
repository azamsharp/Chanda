//
//  BaseService.m
//  DonationTracker
//
//  Created by Mohammad Azam on 7/10/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService

-(id) init
{
    self = [super init];
    
    db = [FMDatabase databaseWithPath:[AppHelper getDatabasePath]];
    db.logsErrors = YES;
    
    return self;
}

@end
