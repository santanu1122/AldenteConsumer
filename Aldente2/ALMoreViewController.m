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
#import "ALTermsandServicesViewController.h"
#import "ALPrivacyPolicyViewController.h"

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
#import "ALCouponCell.h"
#import "ALAppDelegate.h"
#import "ALEditProfileViewController.h"

@interface ALMoreViewController ()<UITextFieldDelegate> {
    
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
}

@property (retain, nonatomic) UITextField *SearchTextField;
@property (retain, nonatomic) UIButton *SearchTextButton;
@property (retain, nonatomic) UIView *SearchBackgroundView;
@property (retain, nonatomic) IBOutlet UIView *HeaderView;
@property (retain, nonatomic) IBOutlet UITableView *UITableView;
@end

@implementation ALMoreViewController
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
    [self AddfooterView];
    
    GlobalAccess = [[ALGlobalAccess alloc] init];
    Alconstants  = [[ALConstants alloc] init];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    _SearchTextField       = [GlobalAccess GenerateTextFieldForAcess:111 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:15.0f TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@"Search by Restaurants or location"];
    [_SearchTextField setDelegate:self];
    
    _SearchBackgroundView   = (UIView *)[self.view viewWithTag:109];
    [_SearchBackgroundView.layer setOpacity:0.2f];
    [_HeaderView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_HeaderView.layer setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
}
-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:ViewControllerName animated:NO];
    
}
#pragma footerview

-(void)AddfooterView {
    
    UIView *FooterView = (UIView *)[self.view viewWithTag:654];
    UIView *FooterPanel=[[[NSBundle mainBundle] loadNibNamed:@"ExtendedDesign" owner:self options:Nil] objectAtIndex:0];
    NSLog(@"FooterPanel --- %@",FooterPanel);
    
    [FooterView addSubview:FooterPanel];
    
    UIView *AllAirportListView      = (UIView *)[FooterPanel viewWithTag:233];
    UIView *AllWaitListView         = (UIView *)[FooterPanel viewWithTag:234];
    UIView *AllReservationListView  = (UIView *)[FooterPanel viewWithTag:235];
    UIView *AllCouponsListView      = (UIView *)[FooterPanel viewWithTag:236];
    UIView *AllMoreListView         = (UIView *)[FooterPanel viewWithTag:237];
    
    UIImageView *touchedImageView = (UIImageView *)[AllMoreListView viewWithTag:11];
    [touchedImageView setImage:[UIImage imageNamed:@"icon5ON.png"]];
    
    UITapGestureRecognizer *tapGesture0      =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBegan:)];
    [tapGesture0 setNumberOfTapsRequired:1];
    [AllAirportListView addGestureRecognizer:tapGesture0];
    
    UITapGestureRecognizer *tapGesture1     =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBegan:)];
    [tapGesture1 setNumberOfTapsRequired:1];
    [AllWaitListView addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer *tapGesture2     =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBegan:)];
    [tapGesture2 setNumberOfTapsRequired:1];
    [AllReservationListView addGestureRecognizer:tapGesture2];
    
    UITapGestureRecognizer *tapGesture3     =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBegan:)];
    [tapGesture3 setNumberOfTapsRequired:1];
    [AllCouponsListView addGestureRecognizer:tapGesture3];
    
    UITapGestureRecognizer *tapGesture4     =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBegan:)];
    [tapGesture4 setNumberOfTapsRequired:1];
    [AllMoreListView addGestureRecognizer:tapGesture4];
    
    
}

-(void)touchBegan :(UITapGestureRecognizer *)Recognizer
{
    IMFAPPPRINTMETHOD();
    
    UIView *touchedView=(UIView *)[[Recognizer self] view];
    UIImageView *touchedImageView = (UIImageView *)[touchedView viewWithTag:11];
    UIViewController *nextViewController;
    
    switch([touchedView tag])
    {
        case 233: nextViewController            =   [[ALAllRestaurantListViewController alloc] init];
            [touchedImageView setImage:[UIImage imageNamed:@"icon1ON.png"]];
            break;
        case 234: nextViewController            =   [[ALWaitlistViewController alloc] init];
            [touchedImageView setImage:[UIImage imageNamed:@"icon2ON.png"]];
            break;
        case 235: nextViewController            =   [[ALReservationsViewController alloc] init];
            [touchedImageView setImage:[UIImage imageNamed:@"icon3ON.png"]];
            break;
        case 236: nextViewController            =   [[ALCouponsViewController alloc] init];
            [touchedImageView setImage:[UIImage imageNamed:@"icon4ON.png"]];
            break;
        case 237: nextViewController            =   [[ALMoreViewController alloc] init];
            [touchedImageView setImage:[UIImage imageNamed:@"icon5ON.png"]];
            break;
            
    }
    
    if(nextViewController)[self GotoDifferentViewWithAnimation:nextViewController];
}
-(IBAction)GotoSurveysScreen:(id)sender {
    
    ALSurveysViewController *Survey = [[ALSurveysViewController alloc] init];
    [self GotoDifferentViewWithAnimation:Survey];
}
-(IBAction)GotoMyAccountScreen:(id)sender {
    
    ALEditProfileViewController *EditProfileView = [[ALEditProfileViewController alloc] init];
    [self GotoDifferentViewWithAnimation:EditProfileView];
}
-(IBAction)GotoTermsandservicesScreen:(id)sender {
    ALTermsandServicesViewController *Survey = [[ALTermsandServicesViewController alloc] init];
    [self GotoDifferentViewWithAnimation:Survey];
}
-(IBAction)GotoPrivacyPolicyScreen:(id)sender {
    ALPrivacyPolicyViewController *Survey = [[ALPrivacyPolicyViewController alloc] init];
    [self GotoDifferentViewWithAnimation:Survey];
}
-(IBAction)GotoLogoutScreen:(id)sender {
    
    NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
    [UserDefaults setObject:nil forKey:@"USERID" ];
    ALAppDelegate *Maindelegate = (ALAppDelegate *)[[UIApplication sharedApplication] delegate];
    [Maindelegate SEtuptabbarFornotlogedinuser];
}

-(IBAction)HideKeyboard:(id)sender {
    
    [_SearchTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
