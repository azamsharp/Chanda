//
//  DonationsViewController.m
//  DonationTracker
//
//  Created by Mohammad Azam on 6/28/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "DonationsViewController.h"

static NSString *const ADD_NEW_DONATION_SEGUE = @"AddNewDonationSegue";
static NSString *const DONATION_PAYMENT_SEQUE = @"DonationPaymentSegue";

@interface DonationsViewController ()

@end

@implementation DonationsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setup];
}

-(void) setup
{
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    UIImage *backgroundImage = [UIImage imageNamed:@"2-blue-background"];
    
    [backgroundImageView setImage:backgroundImage];
    [self.tableView setBackgroundView:backgroundImageView];
    
    [self populateDonations];
}

-(void) populateDonations
{
    donationService = [[DonationService alloc] init];
    donations = [donationService getAll];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Donation *donation = [donations objectAtIndex:[indexPath row]];
        
        BOOL isDeleted = [donationService deleteById:donation.donationId];
        
        if(isDeleted)
        {
            [donations removeObject:donation];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
    }
}

-(void) performAddNewDonationSegue:(UIStoryboardSegue *) segue
{
    AddNewDonationViewController *addNewDonationViewController = (AddNewDonationViewController *) segue.destinationViewController;
    
    addNewDonationViewController.addNewDonationSaveBlock = ^(Donation *donation,AddNewDonationViewController *controller)
    {
        
        [controller dismissViewControllerAnimated:YES completion:nil];
        
        BOOL isSaved = [donationService save:donation];
        
        if(isSaved) {
            
            [self populateDonations];
            
        }
        
    };
    
    addNewDonationViewController.addNewDonationCloseBlock = ^(AddNewDonationViewController *controller)
    {
        [controller dismissViewControllerAnimated:YES completion:nil];
    };
}

-(void) performDonationPaymentSegue:(UIStoryboardSegue *) segue
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    DonationPaymentViewController *donationPaymentViewController = segue.destinationViewController;
    donationPaymentViewController.donation = [donations objectAtIndex:[indexPath row]];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:ADD_NEW_DONATION_SEGUE])
    {
        [self performAddNewDonationSegue:segue];
    }
    else if([segue.identifier isEqualToString:DONATION_PAYMENT_SEQUE])
    {
        [self performDonationPaymentSegue:segue];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [donations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DonationCell";
    DonationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Donation *donation = [donations objectAtIndex:[indexPath row]];
    
    [cell bind:donation];
    
    return cell;
}

@end
