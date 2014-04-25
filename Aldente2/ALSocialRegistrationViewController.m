//
//  ALSocialRegistrationViewController.m
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALSocialRegistrationViewController.h"
#import "ALNibNames.h"
#import "ALAllImages.h"
#import "ALStrings.h"
#import "ALAppServices.h"
#import "ALRedirectViews.h"
#import "ALGlobalAccess.h"
#import "NSString+Extend.h"
#import "ALConstants.h"
#import "RMDateSelectionViewController.h"
#import "ALVerifyPhoneViewController.h"

@interface ALSocialRegistrationViewController ()<UITextFieldDelegate,UIScrollViewDelegate,RMDateSelectionViewControllerDelegate> {
    
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UIImage *image;
    UIImageView *loadingView;
    UIView *FadelayoutView;
    NSString *oauth_provider;
}

@property (nonatomic,retain) UIScrollView           *SocialRegistrationMainScrollView;
@property (nonatomic,retain) UIButton               *SocialRegistrationScrrenCrossButton;
@property (nonatomic,retain) UIButton               *SocialRegistrationScrrenBirthdayButton;
@property (nonatomic,retain) UIButton               *SocialRegistrationScrrenSignupButton;
@property (nonatomic,retain) IBOutlet UIButton      *SocialRegistrationScrrenAgreeTermsButton;
@property (nonatomic,retain) UITextField            *SocialRegistrationScrrenBirthdayText;


@property (nonatomic,retain) UITextField            *SocialRegistrationScrrenNametextField;
@property (nonatomic,retain) UITextField            *SocialRegistrationScrrenEmailtextField;
@property (nonatomic,retain) UITextField            *SocialRegistrationScrrenPhonetextField;

@property (nonatomic,retain) UILabel                *SocialRegistrationScrrenTermslabel;
@property (nonatomic,retain) IBOutlet UIDatePicker  *SocialRegistrationScrrendatePicker;

@property (nonatomic,retain) IBOutlet UIView        *SocialRegistrationPickerView;



@end

@implementation ALSocialRegistrationViewController
int is_Terms                               = 0;

@synthesize SocialRegistrationScrrenCrossButton           = _SocialRegistrationScrrenCrossButton;
@synthesize SocialRegistrationScrrenSignupButton          = _SocialRegistrationScrrenSignupButton;
@synthesize SocialRegistrationScrrenAgreeTermsButton      = _SocialRegistrationScrrenAgreeTermsButton;
@synthesize SocialRegistrationScrrenBirthdayText          = _SocialRegistrationScrrenBirthdayText;
@synthesize SocialRegistrationScrrenNametextField         = _SocialRegistrationScrrenNametextField;
@synthesize SocialRegistrationScrrenEmailtextField        = _SocialRegistrationScrrenEmailtextField;
@synthesize SocialRegistrationScrrenPhonetextField        = _SocialRegistrationScrrenPhonetextField;
@synthesize SocialRegistrationScrrenTermslabel            = _SocialRegistrationScrrenTermslabel;
@synthesize SocialRegistrationMainScrollView              = _SocialRegistrationMainScrollView;
@synthesize SocialRegistrationScrrendatePicker            = _SocialRegistrationScrrendatePicker;
@synthesize SocialRegistrationPickerView                  = _SocialRegistrationPickerView;
@synthesize SocialRegistrationScrrenBirthdayButton        = _SocialRegistrationScrrenBirthdayButton;

@synthesize  userid,fullname,username,login_mode,email,birthday;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self    = [super initWithNibName:ALNibNames.SocialRegistrationMiddleViewScreen bundle:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    GlobalAccess = [[ALGlobalAccess alloc] init];
    Alconstants  = [[ALConstants alloc] init];
    
    NSLog(@"userid %@",userid);
    NSLog(@"fullname %@",fullname);
    NSLog(@"username %@",username);
    NSLog(@"login_mode %@",login_mode);
    NSLog(@"username %@",email);
    NSLog(@"birthday %@",birthday);
    
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    
    _SocialRegistrationMainScrollView             = [GlobalAccess GenerateUIScrollForAcess:10 GlobalView:self.view Delegate:self ScrollEnabled:YES userInteractionEnabled:YES showsVerticalScrollIndicator:YES SCrollBackgroundColor:[UIColor clearColor] ScrollviewExtraWidth:0 ScrollViewExtraHeight:0];
    [_SocialRegistrationMainScrollView setDelegate:self];
    
    _SocialRegistrationScrrenNametextField        = [GlobalAccess GenerateTextFieldForAcess:12 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.RegistrationScreenNameFiledPlaceholder];
    [_SocialRegistrationScrrenNametextField setDelegate:self];
    
    _SocialRegistrationScrrenEmailtextField       = [GlobalAccess GenerateTextFieldForAcess:13 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.RegistrationScreenEmailFiledPlaceholder];
    [_SocialRegistrationScrrenEmailtextField setDelegate:self];
    
    _SocialRegistrationScrrenPhonetextField       = [GlobalAccess GenerateTextFieldForAcess:14 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.RegistrationScreenPahoneFiledPlaceholder];
    [_SocialRegistrationScrrenPhonetextField setDelegate:self];
    
    _SocialRegistrationScrrenBirthdayText         = [GlobalAccess GenerateTextFieldForAcess:15 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.RegistrationScreenBirthdayFiledPlaceholder];
    [_SocialRegistrationScrrenBirthdayText setDelegate:self];
    
    
    [GlobalAccess GenerateUIlabelForAcess:18 Delegate:self UilabeltextColor:[UIColor whiteColor] UilabelsetFontSize:ALAppServices.ALTermsAndServicesFontSize UilabelFont:ALAppServices.AFFontRegular GlobalView:self.view UilabelText:ALStrings.SignInScreenAgreeTermsandCondition UilabelTextAlignment:nil];
    
    _SocialRegistrationScrrenCrossButton          = (UIButton *)[self.view viewWithTag:11];
    [_SocialRegistrationScrrenCrossButton addTarget:self action:@selector(CrossView) forControlEvents:UIControlEventTouchUpInside];
    
    _SocialRegistrationScrrenSignupButton         = (UIButton *)[self.view viewWithTag:16];
    [_SocialRegistrationScrrenSignupButton addTarget:self action:@selector(ValidateDataFieldForRegistration) forControlEvents:UIControlEventTouchUpInside];
    
    _SocialRegistrationScrrenBirthdayButton       = (UIButton *)[self.view viewWithTag:150];
    [_SocialRegistrationScrrenBirthdayButton addTarget:self action:@selector(openDateSelectionControllerWithBlock:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if(![fullname isKindOfClass:[NSNull class]])
    _SocialRegistrationScrrenNametextField.text=fullname;
    
    if([login_mode isEqualToString:@"facebook"])
    {
        _SocialRegistrationScrrenEmailtextField.text=email;
        
        if(![birthday isKindOfClass:[NSNull class]])
        {
            NSString *birth_day=[birthday stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
            _SocialRegistrationScrrenBirthdayText.text=birth_day;
        }
     }
}

- (IBAction)openDateSelectionControllerWithBlock:(id)sender {
    
    if([_SocialRegistrationScrrenNametextField isFirstResponder]) {
        [_SocialRegistrationScrrenNametextField resignFirstResponder];
    }
    else if([_SocialRegistrationScrrenEmailtextField isFirstResponder]) {
        [_SocialRegistrationScrrenEmailtextField resignFirstResponder];
    }
    else if([_SocialRegistrationScrrenPhonetextField isFirstResponder]) {
        [_SocialRegistrationScrrenPhonetextField resignFirstResponder];
    }
    
    else if([_SocialRegistrationScrrenBirthdayText isFirstResponder]) {
        [_SocialRegistrationScrrenBirthdayText resignFirstResponder];
    }
    [self SlideDownPopupWhileEditing:nil];
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:ALAppServices.AFApiDateFormat];
        NSString* myString = [df stringFromDate:aDate];
        
        [_SocialRegistrationScrrenBirthdayText setText:myString];
        
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        
        // NSLog(@"Date selection was canceled (with block)");
    }];
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.maximumDate    = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
}

-(void)ValidateDataFieldForRegistration {
    
    BOOL Is_Vaidate                 = YES;
    NSString *ErrvalidationString   = nil;
    
    if ([Alconstants CleanTextField:_SocialRegistrationScrrenNametextField.text].isEmpty) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenNameFiledBlank;
        Is_Vaidate                  = NO;
    } else if ([Alconstants CleanTextField:_SocialRegistrationScrrenEmailtextField.text].isEmpty) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenEmailFiledBlank;
        Is_Vaidate                  = NO;
    } else if (![Alconstants CleanTextField:_SocialRegistrationScrrenEmailtextField.text].isEmail) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenEmailFiledValidate;
        Is_Vaidate                  = NO;
    } else if ([Alconstants CleanTextField:_SocialRegistrationScrrenPhonetextField.text].isEmpty) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenPhoneFiledBlank;
        Is_Vaidate                  = NO;
    } else if (![Alconstants CleanTextField:_SocialRegistrationScrrenPhonetextField.text].isPhoneNumber) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenPhoneFiledValidate;
        Is_Vaidate                  = NO;
    } else if ([Alconstants CleanTextField:_SocialRegistrationScrrenBirthdayText.text].isEmpty) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenBirthdayFiledBlank;
        Is_Vaidate                  = NO;
    }  else if (![[Alconstants CleanTextField:_SocialRegistrationScrrenPhonetextField.text] isMinLength:10]) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenPhoneFiledValidate;
        Is_Vaidate                  = NO;
    } else if (!is_Terms) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenTermsNotSelected;
        Is_Vaidate                  = NO;
    }
    
    if (Is_Vaidate) {
        NSLog(@"All the things looking fine");
        
        FadelayoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 390)];
        [FadelayoutView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:FadelayoutView];
        [self.view bringSubviewToFront:FadelayoutView];
        
        [self startSpin];
        
        // @try {
        if([login_mode isEqualToString:@"twitter"]){
            oauth_provider=@"twitter";
        }else{
            
           oauth_provider=@"facebook";
        }
        
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSString *StringData = [NSString stringWithFormat:@"%@social_login_register_consumer?connectid=%@&oauth_provider=%@&name=%@&email=%@&phone=%@&devicetoken=%@",API,userid,oauth_provider,[[Alconstants CleanTextField:_SocialRegistrationScrrenNametextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[Alconstants CleanTextField:_SocialRegistrationScrrenEmailtextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[Alconstants CleanTextField:_SocialRegistrationScrrenPhonetextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[Alconstants CleanTextField:@"12345"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                 NSLog(@"StringData --- %@",StringData);
                
                NSData *dataFromContainingUrl = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:StringData]];
                
                NSLog(@"dataFromContainingUrl --- %@",dataFromContainingUrl);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self stopSpin];
                    
                    NSDictionary *getArray=[NSJSONSerialization JSONObjectWithData:dataFromContainingUrl options:kNilOptions error:nil];
                    
                    NSLog(@"getArray --- %@",getArray);
                    
                    if ([[[getArray objectForKey:@"response"] objectForKey:@"response"] isEqualToString:@"error"]) {
                        
                        UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[[getArray objectForKey:@"response"] objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        
                        [FadelayoutView removeFromSuperview];
                        [AlertView show];
                    } else {
                        
                        NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
                        [UserDefaults setObject:[[getArray objectForKey:@"consumerdetails"] objectForKey:@"consumerid"] forKey:@"USERID"];
                        
                        ALVerifyPhoneViewController *VerifyPhoneViewController = [[ALVerifyPhoneViewController alloc] init];
                        [self GotoDifferentViewWithAnimation:VerifyPhoneViewController];
                    }
                    
                });
                
            });
       
    } else {
        
        UIAlertView *AlertViewError = [[UIAlertView alloc] initWithTitle:ALStrings.VaidationErrorAlertviewTitle message:ErrvalidationString delegate:self cancelButtonTitle:ALStrings.VaidationErrorAlertviewCancelButtonTitle otherButtonTitles:nil, nil];
        [AlertViewError show];
    }
    
}

-(void)CrossView {
    [self GotoDifferentViewWithAnimation:ALRedirectViews.LandingViewController];
}

-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:ViewControllerName animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(IBAction)SlideupPopupWhileEditing:(UITextField *)sender {
    
    if (sender.tag == 15) {
        
        [self openDateSelectionControllerWithBlock:nil];
    } else {
        [UIView animateWithDuration:0.4f animations:^{
            
            if (sender.tag == 12) {
                [_SocialRegistrationMainScrollView setContentOffset:CGPointMake(0, 50) animated:YES];
            } else if (sender.tag == 13) {
                [_SocialRegistrationMainScrollView setContentOffset:CGPointMake(0, 75) animated:YES];
            } else if (sender.tag == 14) {
                [_SocialRegistrationMainScrollView setContentOffset:CGPointMake(0, 100) animated:YES];
            } else if (sender.tag == 27) {
                [_SocialRegistrationMainScrollView setContentOffset:CGPointMake(0, 125) animated:YES];
            }
        } completion:^(BOOL finished) {
        }];
    }
    
}
-(IBAction)SlideDownPopupWhileEditing:(UITextField *)sender {
    
    [UIView animateWithDuration:0.4f animations:^{
        [_SocialRegistrationMainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } completion:^(BOOL finished) {
        [_SocialRegistrationScrrenEmailtextField resignFirstResponder];
        [self.view resignFirstResponder];
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
}
-(IBAction)ClickedOnTermsAndCondition:(UITextField *)sender {
    
    if (is_Terms == 0) {
        
        [_SocialRegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPSelectedCheckboxIcon] forState:UIControlStateNormal];
        [_SocialRegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPSelectedCheckboxIcon] forState:UIControlStateSelected];
        [_SocialRegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPSelectedCheckboxIcon] forState:UIControlStateHighlighted];
        
        is_Terms = 1;
    } else {
        
        [_SocialRegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPUnSelectedCheckboxIcon] forState:UIControlStateNormal];
        [_SocialRegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPUnSelectedCheckboxIcon] forState:UIControlStateSelected];
        [_SocialRegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPUnSelectedCheckboxIcon] forState:UIControlStateHighlighted];
        
        is_Terms = 0;
    }
}
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    
}
- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    
}

- (void)startSpin
{
    if (!loadingView) {
        loadingView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 420, 26, 26)];
        loadingView.image = [UIImage imageNamed:ALAllImages.APPLoaderIcon];
        [self.view addSubview:loadingView];
    }
    loadingView.hidden = NO;
    [CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	CGRect frame = [loadingView frame];
	loadingView.layer.anchorPoint = CGPointMake(0.5, 0.5);
	loadingView.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.speed = 3.0f;
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	[loadingView.layer addAnimation:animation forKey:@"rotationAnimation"];
	[CATransaction commit];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
	if (finished)
	{
		[self startSpin];
	}
}

- (void)stopSpin
{
    [loadingView.layer removeAllAnimations];
    loadingView.hidden = YES;
}
@end



