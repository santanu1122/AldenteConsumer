//
//  ALEditProfileViewController.m
//  AlDenteConsumer
//
//  Created by Esolz_Mac on 16/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "ALEditProfileViewController.h"
#import "ALAllRestaurantListViewController.h"
#import "ALMoreViewController.h"
#import "ALWaitlistViewController.h"
#import "ALReservationsViewController.h"
#import "ALCouponsViewController.h"
#import "RMDateSelectionViewController.h"
#import "ALNibNames.h"
#import "ALAllImages.h"
#import "ALStrings.h"
#import "ALAppServices.h"
#import "ALRedirectViews.h"
#import "ALGlobalAccess.h"
#import "NSString+Extend.h"
#import "ALConstants.h"

@interface ALEditProfileViewController ()<UITextFieldDelegate,RMDateSelectionViewControllerDelegate>{
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UIView *paddingView;
}
@property (retain, nonatomic) UIView *topView;
@property (retain, nonatomic) UIView *bgtopView;
@property (retain, nonatomic) UIView *editprofileView;

@property (retain, nonatomic) UIView *inputView;
@property (retain, nonatomic) UILabel *editprofilelabel;
@property (retain, nonatomic) UITextField *name;
@property (retain, nonatomic) UITextField *email;
@property (retain, nonatomic) UITextField *phone;
@property (retain, nonatomic) UITextField *birthday;
@property (retain, nonatomic) UIButton *update;
@property (retain, nonatomic) UITextField *SearchTextField;
@property (retain, nonatomic) UIButton *SearchTextButton;
@property (retain, nonatomic) UIButton *birthdayButton;
@end

@implementation ALEditProfileViewController
@synthesize topView        = _topView;
@synthesize bgtopView        = _bgtopView;
@synthesize editprofileView        = _editprofileView;
@synthesize editprofilelabel        = _editprofilelabel;
@synthesize inputView        = _inputView;

@synthesize name        = _name;
@synthesize email        = _email;
@synthesize phone        = _phone;
@synthesize birthday        = _birthday;
@synthesize update        = _update;
@synthesize SearchTextField        = _SearchTextField;
@synthesize SearchTextButton        = _SearchTextButton;
@synthesize birthdayButton        = _birthdayButton;
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
    [self AddfooterView];
    
    GlobalAccess = [[ALGlobalAccess alloc] init];
    Alconstants  = [[ALConstants alloc] init];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    _SearchTextField       = [GlobalAccess GenerateTextFieldForAcess:104 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:15.0f TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@"Search by Restaurants or location"];
    [_SearchTextField setDelegate:self];
    _topView   = (UIView *)[self.view viewWithTag:100];
    _bgtopView   = (UIView *)[_topView viewWithTag:101];
[_bgtopView.layer setOpacity:0.2f];
  
   _editprofileView   = (UIView *)[self.view viewWithTag:105];
   _editprofileView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"edit-profile-bg.png"]];
     _editprofilelabel   = (UILabel *)[_editprofileView viewWithTag:107];
    _editprofilelabel.font=[UIFont fontWithName:ALAppServices.AFFontRegular  size:17.0f];
    
    _inputView   = (UIView *)[ self.view viewWithTag:108];

    _inputView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"all-input-and-update-bg.png"]];


    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 38)];
    
    _name=(UITextField *)[_inputView viewWithTag:110];
   _name.font=[UIFont fontWithName:ALAppServices.AFFontRegular  size:15.0f];
    _name.leftView = paddingView;
    _name.leftViewMode = UITextFieldViewModeAlways;
    _name.text=@"Jack Syrus";
    _name.delegate=self;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 38)];
    _email=(UITextField *)[_inputView viewWithTag:111];
     _email.font=[UIFont fontWithName:ALAppServices.AFFontRegular  size:15.0f];
    _email.leftView = paddingView;
    _email.leftViewMode = UITextFieldViewModeAlways;
    _email.enabled=NO;
    _email.text=@"syrusjack@gmail.com";
    _email.delegate=self;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 38)];
    _phone=(UITextField *)[_inputView viewWithTag:112];
     _phone.font=[UIFont fontWithName:ALAppServices.AFFontRegular  size:15.0f];
    _phone.leftView = paddingView;
    _phone.leftViewMode = UITextFieldViewModeAlways;
    _phone.text=@"123456789";
    _phone.delegate=self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 38)];
    _birthday=(UITextField *)[_inputView viewWithTag:113];
     _birthday.font=[UIFont fontWithName:ALAppServices.AFFontRegular  size:15.0f];
    _birthday.leftView = paddingView;
    _birthday.leftViewMode = UITextFieldViewModeAlways;
    _birthday.text=@"February 22, 1990";
    _birthday.delegate=self;
    _birthdayButton       = (UIButton *)[self.view viewWithTag:115];
    [_birthdayButton addTarget:self action:@selector(openDateSelectionControllerWithBlock:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - RMDAteSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    NSLog(@"Successfully selected date: %@", aDate);
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"Date selection was canceled");
}
- (IBAction)openDateSelectionControllerWithBlock:(id)sender {
    
    if([_name isFirstResponder]) {
        [_name resignFirstResponder];
    }
    else if([_email isFirstResponder]) {
        [_email resignFirstResponder];
    }
    else if([_phone isFirstResponder]) {
        [_phone resignFirstResponder];
    }
    else if([_birthday isFirstResponder]) {
        [_birthday resignFirstResponder];
    }
    
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:ALAppServices.AFApiDateFormat];
        NSString* myString = [df stringFromDate:aDate];
        
        [_birthday setText:myString];
        
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        
        // NSLog(@"Date selection was canceled (with block)");
    }];
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.maximumDate    = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
}


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
-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:ViewControllerName animated:NO];
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
