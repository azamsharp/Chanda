//
//  DonationPaymentViewController.m
//  DonationTracker
//
//  Created by Mohammad Azam on 7/7/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "DonationPaymentViewController.h"

@interface DonationPaymentViewController ()

@property (nonatomic,weak) IBOutlet UITextField *pledgedTextField;
@property (nonatomic,weak) IBOutlet UITextField *paymentTextField;
@property (nonatomic,weak) IBOutlet UILabel *paidAmountLabel;
@property (nonatomic,weak) IBOutlet UILabel *remainingAmountLabel;
@property (nonatomic,weak) IBOutlet UIButton *payButton;


@end

@implementation DonationPaymentViewController

static const int PLEDGED_AMOUNT_TAG = 1;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) showReceiptAttachmentOptions
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Attach Receipt" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Pick from library",@"Take new picture", nil];
    
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imageTaken = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    
    NSString *imageName = [imagePath lastPathComponent];
    
    // should we save it in the photos album
    // only save when not taken from the photo album
    if(![imageName isEqualToString:@"asset.JPG"])
    {
        UIImageWriteToSavedPhotosAlbum(imageTaken, self, nil, nil);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // update the payments to attach the receipt
    payment.receiptPath = [AppHelper saveImageIntoDocumentsDirectoryAndReturnPath:imageTaken];
    
    [paymentService attachReceiptByPaymentId:payment];
    
    [TSMessage showNotificationInViewController:self
                                      withTitle:@"Success"
                                    withMessage:@"Receipt has been attached!"
                                       withType:TSMessageNotificationTypeSuccess];
}

-(void) openPhotoLibrary
{
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void) takePicture
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            [self openPhotoLibrary];
            break;
            
        case 1: // open the camera
            [self takePicture];
            break;
        case 2:
            
            break;
        default:
            break;
    }
    
}

-(IBAction) pay:(id) sender
{
    if([self.paymentTextField.text length] == 0)
    {
        [self.paymentTextField flash];
        return;
    }
    
    [self.paymentTextField resignFirstResponder];
    
    payment =  [[Payment alloc] init];
    payment.amount = [self.paymentTextField.text floatValue];
    payment.donation = self.donation;
    
    BOOL success = [paymentService pay:payment];
    
    if(success)
    {
        [TSMessage showNotificationInViewController:self
                                          withTitle:@"Success"
                                        withMessage:@"Payment has been recorded!"
                                           withType:TSMessageNotificationTypeSuccess];
        [self bind];
        
        [self showReceiptAttachmentOptions];
    }
    
    else
    {
        [TSMessage showNotificationInViewController:self
                                          withTitle:@"Failure"
                                        withMessage:@"Error recording payment!"
                                           withType:TSMessageNotificationTypeError];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag == PLEDGED_AMOUNT_TAG)
    {
        self.donation.pledgedAmount = [self.pledgedTextField.text floatValue];
        
        BOOL isUpdated = [donationService update:self.donation];

        if(isUpdated) {
            
            [TSMessage showNotificationInViewController:self
                                              withTitle:@"Success"
                                            withMessage:@"Pledge amount has been updated!"
                                               withType:TSMessageNotificationTypeSuccess];
            
            [self bind];
        }
    }
    
    return [textField resignFirstResponder];
}

-(void) bind
{
    UIBarButtonItem *payButton = self.navigationItem.rightBarButtonItem;
    [payButton setBackgroundImage:[UIImage imageNamed:@"2-green-bar-button"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    self.donation = [donationService getById:self.donation.donationId];
    
    self.pledgedTextField.returnKeyType = UIReturnKeyDone;
    self.pledgedTextField.tag = PLEDGED_AMOUNT_TAG;
    
    self.pledgedTextField.placeholder = [NSString stringWithFormat:@"%.2f",self.donation.pledgedAmount];
    self.remainingAmountLabel.text = [NSString stringWithFormat:@"$ %.2f",self.donation.remainingAmount];
    self.paidAmountLabel.text = [NSString stringWithFormat:@"$ %.2f",self.donation.paidAmount];
}

-(void) setup
{
    donationService = [[DonationService alloc] init];
    paymentService = [[PaymentService alloc] init];
    imagePicker = [[UIImagePickerController alloc] init];
    
    [self bind];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
