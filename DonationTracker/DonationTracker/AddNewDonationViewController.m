//
//  AddNewDonationViewController.m
//  DonationTracker
//
//  Created by Mohammad Azam on 7/3/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "AddNewDonationViewController.h"

@interface AddNewDonationViewController ()

@property (nonatomic,weak) IBOutlet UITextField *pledgedAmountTextField;
@property (nonatomic,weak) IBOutlet UITextField *donationNameTextField;
@property (nonatomic,weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic,weak) IBOutlet UIToolbar *toolbar;
@property (nonatomic,weak) IBOutlet UITableView *tableView; 

@end

@implementation AddNewDonationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
}

-(void) setup
{
    donationNames = [NSMutableArray arrayWithArray:@[@"Daily Church Donation",@"Good Citizen Donation",@"Goodwill",@"Red Cross"]];
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -150; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = [donationNames objectAtIndex:[indexPath row]];
    self.donationNameTextField.text = name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [donationNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DonationNameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *name = [donationNames objectAtIndex:[indexPath row]];
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:17];
    cell.textLabel.text = name;
    
    return cell;

}

-(IBAction) close:(id) sender
{
    if(self.addNewDonationCloseBlock != nil)
    {
        self.addNewDonationCloseBlock(self);
    }
}

-(BOOL) isValid
{
    BOOL isValid = YES;
    
    if([self.pledgedAmountTextField.text length] == 0)
    {
        [self.pledgedAmountTextField flash];
        isValid = NO;
    }
    
    if([self.donationNameTextField.text length] == 0)
    {
        [self.donationNameTextField flash];
        isValid = NO;
    }
    
    return isValid;
}

-(IBAction)save:(id)sender
{
    if(![self isValid]) return;
        
    Donation *donation = [[Donation alloc] init];
    donation.name = self.donationNameTextField.text;
    donation.pledgedAmount = [self.pledgedAmountTextField.text floatValue];
    donation.description = self.descriptionTextView.text;
    
    if(self.addNewDonationSaveBlock != nil)
    {
        self.addNewDonationSaveBlock(donation,self);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
