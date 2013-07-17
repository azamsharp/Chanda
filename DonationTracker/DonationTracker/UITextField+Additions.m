//
//  UITextField+Additions.m
//  DonationTracker
//
//  Created by Mohammad Azam on 7/11/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "UITextField+Additions.h"

@implementation UITextField (Additions)

-(void) flash
{
    self.backgroundColor = [UIColor redColor];
    [self performSelector:@selector(setBackgroundColor:) withObject:[UIColor whiteColor] afterDelay:2];
}

@end
