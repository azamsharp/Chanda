//
//  HistoryViewController.h
//  DonationTracker
//
//  Created by Mohammad Azam on 7/10/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryService.h"
#import "HistoryCell.h"
#import "ReceiptViewController.h"

@interface HistoryViewController : UITableViewController
{
    NSMutableArray *payments;
    HistoryService *historyService;
    
}
@end
