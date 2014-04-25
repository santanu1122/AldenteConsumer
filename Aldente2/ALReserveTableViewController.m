//
//  ALRestaurantDetailsViewController.m
//  AlDenteConsumer
//
//  Created by Iphone_2 on 15/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "ALRestaurantDetailsViewController.h"
#import "ALAllRestaurantListViewController.h"
#import "ALMoreViewController.h"
#import "ALWaitlistViewController.h"
#import "ALReservationsViewController.h"
#import "ALCouponsViewController.h"
#import "CoreLocationController.h"
#import "ALNibNames.h"
#import "ALAllImages.h"
#import "ALStrings.h"
#import "ALAppServices.h"
#import "ALRedirectViews.h"
#import "ALGlobalAccess.h"
#import "NSString+Extend.h"
#import "ALConstants.h"
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "ALRestaurantViewCell.h"
#import "ALMapDirectionViewController.h"
#import "ALSurveyDetailsViewController.h"
#import "RMDateSelectionViewController.h"
#include "ALReserveTableViewController.h"

typedef enum {

    SelectionOptionSelectNone = 0,
    SelectionOptionSelectHour,
    SelectionOptionSelectMint,
    SelectionOptionSelectAMPM,
    SelectionOptionSelectPerson

} SelectionOptionSelect;

@interface ALReserveTableViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate,RMDateSelectionViewControllerDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UITapGestureRecognizer *tapGesture;
}
@property (retain, nonatomic) UITextField *SearchTextField;
@property (retain, nonatomic) UIButton *SearchTextButton;
@property (retain, nonatomic) UIView *SearchBackgroundView;
@property (retain, nonatomic) IBOutlet UIView *HeaderView;
@property (nonatomic,retain) UITextField            *BookingDateText;
@property (nonatomic,retain) UITextField            *BookingHrText;
@property (nonatomic,retain) UITextField            *BookingMintText;
@property (nonatomic,retain) UITextField            *BookingAMPMText;
@property (nonatomic,retain) UITextField            *BookingPartysizeText;
@property (nonatomic,retain) UITextView             *BookingNote;
@property (nonatomic,retain) UIScrollView           *BookingScreenScrollView;
@property (nonatomic,retain) UIButton               *doneButton;

@property (assign) SelectionOptionSelect SelectionOptionSelectOption;
@end

@implementation ALReserveTableViewController

@synthesize SearchTextField             = _SearchTextField;
@synthesize SearchTextButton            = _SearchTextButton;
@synthesize SearchBackgroundView        = _SearchBackgroundView;
@synthesize HeaderView                  = _HeaderView;
@synthesize BookingDateText             = _BookingDateText;
@synthesize BookingHrText               = _BookingHrText;
@synthesize BookingMintText             = _BookingMintText;
@synthesize BookingAMPMText             = _BookingAMPMText;
@synthesize BookingPartysizeText        = _BookingPartysizeText;
@synthesize SelectionOptionSelectOption = _SelectionOptionSelectOption;
@synthesize BookingNote                 = _BookingNote;
@synthesize BookingScreenScrollView     = _BookingScreenScrollView;
@synthesize doneButton                  = _doneButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GlobalAccess = [[ALGlobalAccess alloc] init];
    Alconstants  = [[ALConstants alloc] init];
    
    _SelectionOptionSelectOption = SelectionOptionSelectNone;
    
    [self.navigationController setNavigationBarHidden:YES];
    
    _SearchTextField       = [GlobalAccess GenerateTextFieldForAcess:111 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:15.0f TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@"Search by Restaurants or location"];
    [_SearchTextField setDelegate:self];
    
    [_HeaderView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_HeaderView.layer setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    
    _SearchBackgroundView   = (UIView *)[self.view viewWithTag:109];
    [_SearchBackgroundView.layer setOpacity:0.2f];
    
    UIView *HeaderTitleView = (UIView *)[self.view viewWithTag:65];
    [HeaderTitleView.layer setOpacity:0.2f];
    
    [self AddfooterView:1];
    
    _BookingScreenScrollView = (UIScrollView *)[self.view viewWithTag:342];
    [_BookingScreenScrollView setDelegate:self];
    [_BookingScreenScrollView setBackgroundColor:[UIColor clearColor]];
    [_BookingScreenScrollView setScrollEnabled:YES];
    [_BookingScreenScrollView setUserInteractionEnabled:YES];
    [_BookingScreenScrollView setDelegate:self];
    [_BookingScreenScrollView setContentSize:CGSizeMake(_BookingScreenScrollView.layer.frame.size.width, _BookingScreenScrollView.layer.frame.size.height+150)];
    
    _BookingDateText = [GlobalAccess GenerateTextFieldForAcess:75 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@"Date"];
    [_BookingDateText setDelegate:self];
    
    _BookingHrText = [GlobalAccess GenerateTextFieldForAcess:77 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@"Hour"];
    [_BookingHrText setDelegate:self];
    
    _BookingMintText = [GlobalAccess GenerateTextFieldForAcess:78 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@"Minute"];
    [_BookingMintText setDelegate:self];
    
    _BookingAMPMText = [GlobalAccess GenerateTextFieldForAcess:79 Delegate:self TextFiledtextColor:[UIColor blackColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@"AM"];
    [_BookingAMPMText setDelegate:self];
    
    _BookingPartysizeText = [GlobalAccess GenerateTextFieldForAcess:81 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@"Party Size"];
    [_BookingPartysizeText setDelegate:self];
    
    _BookingNote = (UITextView *)[self.view viewWithTag:83];
    [_BookingNote setDelegate:self];
    
    UIButton *BookingDate       = (UIButton *)[self.view viewWithTag:84];
    [BookingDate addTarget:self action:@selector(openDateSelectionControllerWithBlock:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *BookingTime       = (UIButton *)[self.view viewWithTag:85];
    [BookingTime addTarget:self action:@selector(openDateSelectionBookingTime:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
}

- (void)keyboardWillShow:(NSNotification *)note {
    
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.frame = CGRectMake(0, 163, 106, 53);
    _doneButton.adjustsImageWhenHighlighted = NO;
    [_doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
    [_doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
    [_doneButton addTarget:self action:@selector(doneButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *keyboardView = [[[[[UIApplication sharedApplication] windows] lastObject] subviews] firstObject];
            [_doneButton setFrame:CGRectMake(0, keyboardView.frame.size.height - 53, 104, 53)];
            [keyboardView addSubview:_doneButton];
            [keyboardView bringSubviewToFront:_doneButton];
            
            [UIView animateWithDuration:[[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]-.02
                                  delay:.0
                                options:[[note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]
                             animations:^{
                                 self.view.frame = CGRectOffset(self.view.frame, 0, 0);
            } completion:nil];
        });
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
            UIView* keyboard;
            for(int i=0; i<[tempWindow.subviews count]; i++) {
                keyboard = [tempWindow.subviews objectAtIndex:i];
                
                if([[keyboard description] hasPrefix:@"UIKeyboard"] == YES)
                    [keyboard addSubview:_doneButton];
            }
        });
    }
}
- (void)doneButtonDidPressed:(id)sender {
    
    [_BookingPartysizeText resignFirstResponder];
}
-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    [_BookingScreenScrollView setContentOffset:CGPointMake(0, 170) animated:YES];
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    
    [_BookingScreenScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [_BookingScreenScrollView setContentOffset:CGPointMake(0, 170) animated:YES];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    [_BookingScreenScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [_BookingScreenScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        return NO;
    }
    return YES;
}
-(IBAction)openDateSelectionBookingTime:(id)sender {
    
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        
        NSDateFormatter *outputFormatterHour = [[NSDateFormatter alloc] init];
        
        [outputFormatterHour setDateFormat:@"h"];
        [_BookingHrText setText:[outputFormatterHour stringFromDate:aDate]];
        
        [outputFormatterHour setDateFormat:@"mm"];
        [_BookingMintText setText:[outputFormatterHour stringFromDate:aDate]];
        
        [outputFormatterHour setDateFormat:@"a"];
        [_BookingAMPMText setTextColor:[UIColor blackColor]];
        [_BookingAMPMText setText:[outputFormatterHour stringFromDate:aDate]];
        
        
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        
        // NSLog(@"Date selection was canceled (with block)");
    }];
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeTime;
}

#pragma Opendatepicker

- (IBAction)openDateSelectionControllerWithBlock:(id)sender {
    
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:ALAppServices.AFApiDateFormat];
        NSString* myString = [df stringFromDate:aDate];
        
        [_BookingDateText setText:myString];
        
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        
        // NSLog(@"Date selection was canceled (with block)");
    }];
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.minimumDate    = [[NSDate alloc] initWithTimeIntervalSinceNow:86400];
    
}
#pragma mark - RMDAteSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    
    NSLog(@"Successfully selected date: %@", aDate);
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    
    NSLog(@"Date selection was canceled");
}

-(IBAction)HideKeyboard:(id)sender {
    
    [_SearchTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
