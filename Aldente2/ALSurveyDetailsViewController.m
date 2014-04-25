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


@interface ALSurveyDetailsViewController ()<UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,RMDateSelectionViewControllerDelegate>
{
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UITapGestureRecognizer *tapGesture;
    
    UIView *RatingViewOverAll;
    UIView *RatingViewFood;
    UIView *RatingViewService;
    UIView *RatingViewAmbience;
}
@property (retain, nonatomic) UITextField *SearchTextField;
@property (retain, nonatomic) UIButton *SearchTextButton;
@property (retain, nonatomic) UIView *SearchBackgroundView;
@property (retain, nonatomic) IBOutlet UIView *HeaderView;
@property (nonatomic,retain) UITextField            *SurveyDetailsAnivarsaryText;
@property (nonatomic,retain) UITextView             *SurveyCommentTextView;
@property (nonatomic,retain) UIScrollView           *SurveyScreenScrollView;

@end

@implementation ALSurveyDetailsViewController

@synthesize SearchTextField             = _SearchTextField;
@synthesize SearchTextButton            = _SearchTextButton;
@synthesize SearchBackgroundView        = _SearchBackgroundView;
@synthesize HeaderView                  = _HeaderView;
@synthesize SurveyDetailsAnivarsaryText = _SurveyDetailsAnivarsaryText;
@synthesize SurveyCommentTextView       = _SurveyCommentTextView;
@synthesize SurveyScreenScrollView      = _SurveyScreenScrollView;

int RatingForOverAll                    = 0;
int RatingForFood                       = 0;
int RatingForService                    = 0;
int RatingForAmbience                   = 0;
int GLobalRating                        = 5;

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
    
    [self.navigationController setNavigationBarHidden:YES];
    
    _SearchTextField       = [GlobalAccess GenerateTextFieldForAcess:111 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:15.0f TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@"Search by Restaurants or location"];
    [_SearchTextField setDelegate:self];
    
    [_HeaderView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_HeaderView.layer setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    
    _SearchBackgroundView   = (UIView *)[self.view viewWithTag:109];
    [_SearchBackgroundView.layer setOpacity:0.2f];
    
    _SurveyCommentTextView = (UITextView *)[self.view viewWithTag:32];
    [_SurveyCommentTextView setDelegate:self];
    
    [self AddfooterView:5];
    
    _SurveyScreenScrollView = (UIScrollView *)[self.view viewWithTag:342];
    [_SurveyScreenScrollView setDelegate:self];
    [_SurveyScreenScrollView setBackgroundColor:[UIColor clearColor]];
    [_SurveyScreenScrollView setScrollEnabled:YES];
    [_SurveyScreenScrollView setUserInteractionEnabled:YES];
    [_SurveyScreenScrollView setDelegate:self];
    [_SurveyScreenScrollView setContentSize:CGSizeMake(_SurveyScreenScrollView.layer.frame.size.width, _SurveyScreenScrollView.layer.frame.size.height)];
    
    _SurveyDetailsAnivarsaryText = [GlobalAccess GenerateTextFieldForAcess:87 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@"Anniversary"];
    [_SurveyDetailsAnivarsaryText setDelegate:self];
    
    UIButton *AniversaryButton       = (UIButton *)[self.view viewWithTag:86];
    [AniversaryButton addTarget:self action:@selector(openDateSelectionControllerWithBlock:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    UIButton *SubmitButton = (UIButton *)[self.view viewWithTag:631];
    [SubmitButton addTarget:self action:@selector(SubmitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    RatingViewOverAll   = (UIView *)[self.view viewWithTag:101];
    RatingViewFood      = (UIView *)[self.view viewWithTag:102];
    RatingViewService   = (UIView *)[self.view viewWithTag:103];
    RatingViewAmbience  = (UIView *)[self.view viewWithTag:104];
    
    for (int j=101; j<=104; j++) {
        
        UIView *ImidiateSuperView = (UIView *)[self.view viewWithTag:j];
        
        for (int i = 1; i<=5; i++) {
            
            UIButton *ButtonRating = (UIButton *)[ImidiateSuperView viewWithTag:i];
            [ButtonRating addTarget:self action:@selector(RatingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

-(IBAction)SubmitButtonClicked:(id)sender
{
    NSLog(@"i am here");
    [self ClearAll];
}

-(IBAction)RatingButtonClicked:(UIButton *)sender
{
    for (int k=1; k <= [sender tag]; k++) {
        
        UIView   *StarButtonSuperView   = (UIView *)[self.view viewWithTag:[sender.superview tag]];
        UIButton *StarButton = (UIButton *)[StarButtonSuperView viewWithTag:k];
        
        [StarButton setBackgroundImage:[UIImage imageNamed:@"starsel_BG.png"] forState:UIControlStateSelected];
        [StarButton setBackgroundImage:[UIImage imageNamed:@"starsel_BG.png"] forState:UIControlStateNormal];
        [StarButton setBackgroundImage:[UIImage imageNamed:@"starsel_BG.png"] forState:UIControlStateHighlighted];
    }
    
    for (int L=([sender tag]+1); L <= GLobalRating; L++) {
        
        UIView   *StarButtonSuperView   = (UIView *)[self.view viewWithTag:[sender.superview tag]];
        UIButton *StarButton = (UIButton *)[StarButtonSuperView viewWithTag:L];
        
        [StarButton setBackgroundImage:[UIImage imageNamed:@"star_BG.png"] forState:UIControlStateSelected];
        [StarButton setBackgroundImage:[UIImage imageNamed:@"star_BG.png"] forState:UIControlStateNormal];
        [StarButton setBackgroundImage:[UIImage imageNamed:@"star_BG.png"] forState:UIControlStateHighlighted];
    }
    
    switch ([sender.superview tag]) {
        case 101:
            RatingForOverAll = [sender tag];
            break;
        case 102:
            RatingForFood = [sender tag];
            break;
        case 103:
            RatingForService = [sender tag];
            break;
        case 104:
            RatingForAmbience = [sender tag];
            break;
    }
//    NSLog(@"RatingForOverAll --- %d",RatingForOverAll);
//    NSLog(@"RatingForFood --- %d",RatingForFood);
//    NSLog(@"RatingForService --- %d",RatingForService);
//    NSLog(@"RatingForAmbience --- %d",RatingForAmbience);
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    [_SurveyScreenScrollView setContentOffset:CGPointMake(0, 170) animated:YES];
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    
    [_SurveyScreenScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [_SurveyScreenScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        return NO;
    }
    return YES;
}
#pragma Opendatepicker

- (IBAction)openDateSelectionControllerWithBlock:(id)sender {
    
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:ALAppServices.AFApiDateFormat];
        NSString* myString = [df stringFromDate:aDate];
        
        [_SurveyDetailsAnivarsaryText setText:myString];
        
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        
        // NSLog(@"Date selection was canceled (with block)");
    }];
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.maximumDate    = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
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
-(void)ClearAll {
    
    RatingForOverAll    = 0;
    RatingForService    = 0;
    RatingForFood       = 0;
    RatingForAmbience   = 0;
    
    for (int j=101; j<=104; j++) {
        
        UIView *ImidiateSuperView = (UIView *)[self.view viewWithTag:j];
        
        for (int i = 1; i<=5; i++) {
            
            UIButton *ButtonRating = (UIButton *)[ImidiateSuperView viewWithTag:i];
            [ButtonRating setBackgroundImage:[UIImage imageNamed:@"star_BG.png"] forState:UIControlStateSelected];
            [ButtonRating setBackgroundImage:[UIImage imageNamed:@"star_BG.png"] forState:UIControlStateNormal];
            [ButtonRating setBackgroundImage:[UIImage imageNamed:@"star_BG.png"] forState:UIControlStateHighlighted];
        }
    }
    
}
-(void)viewWillDisappear:(BOOL)animated {
    
    [self ClearAll];
    
}

@end
