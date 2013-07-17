//
//  HistoryViewController.m
//  DonationTracker
//
//  Created by Mohammad Azam on 7/10/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()



@end

@implementation HistoryViewController

static NSString *const RECEIPT_VIEW_SEGUE = @"ReceiptViewSegue";

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
    payments = [NSMutableArray array];
    historyService = [[HistoryService alloc] init];
    
    payments = [historyService getAll];

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [payments count];
}

-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Payment *payment = [payments objectAtIndex:[indexPath row]];
    
    if(!payment.isReceiptAttached)
        return NO;
    
    return YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:RECEIPT_VIEW_SEGUE])
    {
        [self performReceiptViewSegue:segue];
    }
}

-(void) performReceiptViewSegue:(UIStoryboardSegue *) segue
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Payment *payment = [payments objectAtIndex:[indexPath row]];
    
    ReceiptViewController *receiptViewController = segue.destinationViewController;
    
    receiptViewController.payment = payment;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HistoryCell";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Payment *payment = [payments objectAtIndex:[indexPath row]];
    
    cell.receiptLabel.text = payment.receiptMessage;
    
    NSDictionary *helveticaLightAttr = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Light" size:14]};
    
    NSDictionary *helveticaAttr = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:14]};
    
    NSString *paymentAmountString = [NSString stringWithFormat:@"%.2f",payment.amount];
    
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"A payment of $%@ was made to the %@ on %@",paymentAmountString,payment.donation.name,payment.dateCreated]];
    
    [message setAttributes:helveticaLightAttr range:NSMakeRange(0, [message length])];
    
    [message setAttributes:helveticaAttr range:NSMakeRange(13, [paymentAmountString length] + 1)];
    
    cell.messageLabel.attributedText = message;
    return cell;
}

@end
