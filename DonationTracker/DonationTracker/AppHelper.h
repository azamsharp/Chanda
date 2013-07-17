//
//  AppHelper.h
//  DonationTracker
//
//  Created by Mohammad Azam on 7/6/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "UIImage+Extensions.h"

@interface AppHelper : NSObject
{
    
}

+(NSString *) saveImageIntoDocumentsDirectoryAndReturnPath:(UIImage *)imageToSave;
+(NSString *) getDatabasePath;
+(UIImage *) loadImageFromDocumentsDirectory:(NSString *)imageUrl;

@end
