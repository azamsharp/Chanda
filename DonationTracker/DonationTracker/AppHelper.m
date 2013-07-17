//
//  AppHelper.m
//  DonationTracker
//
//  Created by Mohammad Azam on 7/6/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper


+(NSString *) getUniqueIdentifier
{
    CFUUIDRef uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    return (__bridge NSString *)(uuidStr);
}

// user generated images are stored in the documents directory
+(UIImage *) loadImageFromDocumentsDirectory:(NSString *)imageUrl
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageUrl]];
    
    UIImage *image = [UIImage imageWithContentsOfFile:savedImagePath];
    
    return image;
}

// save user's image into the documents directory
+(NSString *) saveImageIntoDocumentsDirectoryAndReturnPath:(UIImage *)imageToSave
{
    imageToSave = [imageToSave imageByScalingProportionallyToSize:CGSizeMake(320, 480)];
    
    NSString *uniqueImageName = [self getUniqueIdentifier];
    
    uniqueImageName = [uniqueImageName stringByAppendingPathExtension:@"png"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",uniqueImageName]];
    NSData *imageData = UIImagePNGRepresentation(imageToSave);
    
    [imageData writeToFile:savedImagePath atomically:YES];
    
    return uniqueImageName;
}

+(NSString *) getDatabasePath
{
    NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate] databasePath];
    
    return databasePath;
}


@end
