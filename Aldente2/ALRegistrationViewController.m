//
//  ALRegistrationViewController.m
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALRegistrationViewController.h"
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

@interface ALRegistrationViewController ()<UITextFieldDelegate,UIScrollViewDelegate,RMDateSelectionViewControllerDelegate> {
    
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UIImage *image;
    UIImageView *loadingView;
    UIView *FadelayoutView;
}

@property (nonatomic,retain) UIScrollView           *RegistrationMainScrollView;
@property (nonatomic,retain) UIButton               *RegistrationScrrenCrossButton;
@property (nonatomic,retain) UIButton               *RegistrationScrrenBirthdayButton;
@property (nonatomic,retain) UIButton               *RegistrationScrrenSignupButton;
@property (nonatomic,retain) IBOutlet UIButton      *RegistrationScrrenAgreeTermsButton;
@property (nonatomic,retain) UITextField            *RegistrationScrrenBirthdayText;
@property (nonatomic,retain) UITextField            *RegistrationScrrenPasswordText;

@property (nonatomic,retain) UITextField            *RegistrationScrrenNametextField;
@property (nonatomic,retain) UITextField            *RegistrationScrrenEmailtextField;
@property (nonatomic,retain) UITextField            *RegistrationScrrenPhonetextField;

@property (nonatomic,retain) UILabel                *RegistrationScrrenTermslabel;
@property (nonatomic,retain) IBOutlet UIDatePicker  *RegistrationScrrendatePicker;

@property (nonatomic,retain) IBOutlet UIView        *RegistrationPickerView;

@end

@implementation ALRegistrationViewController

int is_Terms_Enabled                               = 0;

@synthesize RegistrationScrrenCrossButton           = _RegistrationScrrenCrossButton;
@synthesize RegistrationScrrenSignupButton          = _RegistrationScrrenSignupButton;
@synthesize RegistrationScrrenAgreeTermsButton      = _RegistrationScrrenAgreeTermsButton;
@synthesize RegistrationScrrenBirthdayText          = _RegistrationScrrenBirthdayText;
@synthesize RegistrationScrrenNametextField         = _RegistrationScrrenNametextField;
@synthesize RegistrationScrrenEmailtextField        = _RegistrationScrrenEmailtextField;
@synthesize RegistrationScrrenPhonetextField        = _RegistrationScrrenPhonetextField;
@synthesize RegistrationScrrenTermslabel            = _RegistrationScrrenTermslabel;
@synthesize RegistrationMainScrollView              = _RegistrationMainScrollView;
@synthesize RegistrationScrrendatePicker            = _RegistrationScrrendatePicker;
@synthesize RegistrationPickerView                  = _RegistrationPickerView;
@synthesize RegistrationScrrenBirthdayButton        = _RegistrationScrrenBirthdayButton;
@synthesize RegistrationScrrenPasswordText          = _RegistrationScrrenPasswordText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self    = [super initWithNibName:ALNibNames.RegistrationViewScreen bundle:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GlobalAccess = [[ALGlobalAccess alloc] init];
    Alconstants  = [[ALConstants alloc] init];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    _RegistrationMainScrollView             = [GlobalAccess GenerateUIScrollForAcess:10 GlobalView:self.view Delegate:self ScrollEnabled:YES userInteractionEnabled:YES showsVerticalScrollIndicator:YES SCrollBackgroundColor:[UIColor clearColor] ScrollviewExtraWidth:0 ScrollViewExtraHeight:0];
    [_RegistrationMainScrollView setDelegate:self];
    
    _RegistrationScrrenNametextField        = [GlobalAccess GenerateTextFieldForAcess:12 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.RegistrationScreenNameFiledPlaceholder];
    [_RegistrationScrrenNametextField setDelegate:self];
    
    _RegistrationScrrenEmailtextField       = [GlobalAccess GenerateTextFieldForAcess:13 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.RegistrationScreenEmailFiledPlaceholder];
    [_RegistrationScrrenEmailtextField setDelegate:self];
    
    _RegistrationScrrenPhonetextField       = [GlobalAccess GenerateTextFieldForAcess:14 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.RegistrationScreenPahoneFiledPlaceholder];
    [_RegistrationScrrenPhonetextField setDelegate:self];
    
    _RegistrationScrrenBirthdayText         = [GlobalAccess GenerateTextFieldForAcess:15 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.RegistrationScreenBirthdayFiledPlaceholder];
    [_RegistrationScrrenBirthdayText setDelegate:self];
    
    _RegistrationScrrenPasswordText         = [GlobalAccess GenerateTextFieldForAcess:27 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.RegistrationScreenPasswordFiledPlaceholder];
    [_RegistrationScrrenPasswordText setDelegate:self];
    
    [GlobalAccess GenerateUIlabelForAcess:18 Delegate:self UilabeltextColor:[UIColor whiteColor] UilabelsetFontSize:ALAppServices.ALTermsAndServicesFontSize UilabelFont:ALAppServices.AFFontRegular GlobalView:self.view UilabelText:ALStrings.SignInScreenAgreeTermsandCondition UilabelTextAlignment:nil];
    
    _RegistrationScrrenCrossButton          = (UIButton *)[self.view viewWithTag:11];
    [_RegistrationScrrenCrossButton addTarget:self action:@selector(CrossView) forControlEvents:UIControlEventTouchUpInside];
    
    _RegistrationScrrenSignupButton         = (UIButton *)[self.view viewWithTag:16];
    [_RegistrationScrrenSignupButton addTarget:self action:@selector(ValidateFieldDataForRegistration) forControlEvents:UIControlEventTouchUpInside];

    _RegistrationScrrenBirthdayButton       = (UIButton *)[self.view viewWithTag:150];
    [_RegistrationScrrenBirthdayButton addTarget:self action:@selector(openDateSelectionControllerWithBlock:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (IBAction)openDateSelectionControllerWithBlock:(id)sender {
    
    if([_RegistrationScrrenNametextField isFirstResponder]) {
        [_RegistrationScrrenNametextField resignFirstResponder];
    }
    else if([_RegistrationScrrenEmailtextField isFirstResponder]) {
        [_RegistrationScrrenEmailtextField resignFirstResponder];
    }
    else if([_RegistrationScrrenPhonetextField isFirstResponder]) {
        [_RegistrationScrrenPhonetextField resignFirstResponder];
    }
    else if([_RegistrationScrrenPasswordText isFirstResponder]) {
        [_RegistrationScrrenPasswordText resignFirstResponder];
    }
    else if([_RegistrationScrrenBirthdayText isFirstResponder]) {
        [_RegistrationScrrenBirthdayText resignFirstResponder];
    }
    [self SlideDownPopupWhileEditing:nil];
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:ALAppServices.AFApiDateFormat];
        NSString* myString = [df stringFromDate:aDate];
        
        [_RegistrationScrrenBirthdayText setText:myString];
        
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        
       // NSLog(@"Date selection was canceled (with block)");
    }];
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.maximumDate    = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
}

-(void)ValidateFieldDataForRegistration {
    
    BOOL Is_Vaidate                 = YES;
    NSString *ErrvalidationString   = nil;
    
    if ([Alconstants CleanTextField:_RegistrationScrrenNametextField.text].isEmpty) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenNameFiledBlank;
        Is_Vaidate                  = NO;
    } else if ([Alconstants CleanTextField:_RegistrationScrrenEmailtextField.text].isEmpty) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenEmailFiledBlank;
        Is_Vaidate                  = NO;
    } else if (![Alconstants CleanTextField:_RegistrationScrrenEmailtextField.text].isEmail) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenEmailFiledValidate;
        Is_Vaidate                  = NO;
    } else if ([Alconstants CleanTextField:_RegistrationScrrenPhonetextField.text].isEmpty) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenPhoneFiledBlank;
        Is_Vaidate                  = NO;
    } else if (![Alconstants CleanTextField:_RegistrationScrrenPhonetextField.text].isPhoneNumber) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenPhoneFiledValidate;
        Is_Vaidate                  = NO;
    } else if ([Alconstants CleanTextField:_RegistrationScrrenBirthdayText.text].isEmpty) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenBirthdayFiledBlank;
        Is_Vaidate                  = NO;
    } else if ([Alconstants CleanTextField:_RegistrationScrrenPasswordText.text].isEmpty) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenPasswordFiledBlank;
        Is_Vaidate                  = NO;
    } else if (![[Alconstants CleanTextField:_RegistrationScrrenPasswordText.text] isMinLength:6]) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenPasswordValidate;
        Is_Vaidate                  = NO;
    } else if (![[Alconstants CleanTextField:_RegistrationScrrenPhonetextField.text] isMinLength:10]) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenPhoneFiledValidate;
        Is_Vaidate                  = NO;
    } else if (!is_Terms_Enabled) {
        
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
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSString *StringData = [NSString stringWithFormat:@"%@createnewconsumer?name=%@&email=%@&phone=%@&devicetoken=%@&password=%@&dob=%@",API,[[Alconstants CleanTextField:_RegistrationScrrenNametextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[Alconstants CleanTextField:_RegistrationScrrenEmailtextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[Alconstants CleanTextField:_RegistrationScrrenPhonetextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[Alconstants CleanTextField:@"12345"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[Alconstants CleanTextField:_RegistrationScrrenPasswordText.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[Alconstants CleanTextField:_RegistrationScrrenBirthdayText.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
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
//        }
//        @catch (NSException *exception) {
//            NSLog(@"NSException is ---- %@",exception);
//        }
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
                [_RegistrationMainScrollView setContentOffset:CGPointMake(0, 50) animated:YES];
            } else if (sender.tag == 13) {
                [_RegistrationMainScrollView setContentOffset:CGPointMake(0, 75) animated:YES];
            } else if (sender.tag == 14) {
                [_RegistrationMainScrollView setContentOffset:CGPointMake(0, 100) animated:YES];
            } else if (sender.tag == 27) {
                [_RegistrationMainScrollView setContentOffset:CGPointMake(0, 125) animated:YES];
            }
        } completion:^(BOOL finished) {
        }];
    }
    
}
-(IBAction)SlideDownPopupWhileEditing:(UITextField *)sender {
    
    [UIView animateWithDuration:0.4f animations:^{
        [_RegistrationMainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } completion:^(BOOL finished) {
        [_RegistrationScrrenEmailtextField resignFirstResponder];
        [self.view resignFirstResponder];
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
}
-(IBAction)ClickedOnTermsAndCondition:(UITextField *)sender {
    
    if (is_Terms_Enabled == 0) {
        
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPSelectedCheckboxIcon] forState:UIControlStateNormal];
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPSelectedCheckboxIcon] forState:UIControlStateSelected];
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPSelectedCheckboxIcon] forState:UIControlStateHighlighted];
        
        is_Terms_Enabled = 1;
    } else {
        
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPUnSelectedCheckboxIcon] forState:UIControlStateNormal];
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPUnSelectedCheckboxIcon] forState:UIControlStateSelected];
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPUnSelectedCheckboxIcon] forState:UIControlStateHighlighted];
        
        is_Terms_Enabled = 0;
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
