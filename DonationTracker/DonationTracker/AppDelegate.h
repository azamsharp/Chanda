//
//  AppDelegate.h
//  DonationTracker
//
//  Created by Mohammad Azam on 6/27/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
}

@property (nonatomic,copy) NSString *databaseName;
@property (nonatomic,copy) NSString *databasePath;
@property (strong, nonatomic) UIWindow *window;

@end
