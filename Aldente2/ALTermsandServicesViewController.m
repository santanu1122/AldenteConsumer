//
//  ALAllRestaurantListViewController.m
//  AlDenteConsumer
//
//  Created by Iphone_2 on 08/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "ALAllRestaurantListViewController.h"
#import "ALMoreViewController.h"
#import "ALWaitlistViewController.h"
#import "ALReservationsViewController.h"
#import "ALCouponsViewController.h"
#import "ALSurveysViewController.h"
#import "CoreLocationController.h"
#import "ALPrivacyPolicyViewController.h"
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
#import "ALSurveyCell.h"
#import "ALTermsandServicesViewController.h"

@interface ALTermsandServicesViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate> {
    
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UITapGestureRecognizer *tapGesture;
}
@property (retain, nonatomic) UITextField *SearchTextField;
@property (retain, nonatomic) UIButton *SearchTextButton;
@property (retain, nonatomic) UIView *SearchBackgroundView;
@property (retain, nonatomic) IBOutlet UIView *HeaderView;
@end

@implementation ALTermsandServicesViewController
@synthesize SearchTextField             = _SearchTextField;
@synthesize SearchTextButton            = _SearchTextButton;
@synthesize SearchBackgroundView        = _SearchBackgroundView;
@synthesize HeaderView                  = _HeaderView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    
    UIView *TableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 320, 39.0f)];
    [TableHeaderView.layer setShadowColor:[UIColor blackColor].CGColor];
    [TableHeaderView.layer setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    [TableHeaderView setBackgroundColor:[UIColor clearColor]];
    
    UIView *TableHeaderBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 39.0f)];
    [TableHeaderBackView.layer setOpacity:0.2f];
    [TableHeaderBackView setBackgroundColor:[UIColor whiteColor]];
    [TableHeaderView addSubview:TableHeaderBackView];
    
    UILabel *TableviewDetails = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [TableviewDetails setText:@"Terms Of Service"];
    [TableHeaderView addSubview:TableviewDetails];
    [TableviewDetails setTextAlignment:NSTextAlignmentCenter];
    [TableviewDetails setTextColor:[UIColor whiteColor]];
    [TableviewDetails setFont:[UIFont fontWithName:ALAppServices.AFFontSecondSemiBold size:22]];
    
    [self.view addSubview:TableHeaderView];
    
    UITextView *TextView = (UITextView *)[self.view viewWithTag:55];
    [TextView setFont:[UIFont fontWithName:ALAppServices.AFFontRegular size:14]];
    [TextView setTextAlignment:NSTextAlignmentLeft];
    
    [self AddfooterView:5];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
}

-(IBAction)HideKeyboard:(id)sender {
    
    [_SearchTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
