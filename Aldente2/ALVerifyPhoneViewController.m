//
//  ALVerifyPhoneViewController.m
//  AlDenteConsumer
//
//  Created by Iphone_2 on 08/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "ALVerifyPhoneViewController.h"
#import "ALNibNames.h"
#import "ALAllImages.h"
#import "ALStrings.h"
#import "ALAppServices.h"
#import "ALRedirectViews.h"
#import "ALGlobalAccess.h"
#import "NSString+Extend.h"
#import "ALConstants.h"
#import "ALLandingViewController.h"
#import "ALAllRestaurantListViewController.h"
#import "ALAppDelegate.h"

@interface ALVerifyPhoneViewController ()
{
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UIImage *image;
    UIImageView *loadingView;
    UIView *FadelayoutView;
}
@property (nonatomic,retain) UIScrollView           *VerifyPhonenumberMainScrollView;
@property (nonatomic,retain) UIButton               *VerifyPhonenumberScrrenSubmitButton;
@property (nonatomic,retain) UIButton               *VerifyPhonenumberScrrenCrossButton;
@property (nonatomic,retain) UIButton               *VerifyPhonenumberScrrenResendCodeButton;
@property (nonatomic,retain) UITextField            *VerifyPhonenumberScrrenNametextField;
@property (nonatomic, retain) UILabel               *varifyPhoneTitlePartoneLabel;
@property (nonatomic, retain) UILabel               *varifyPhoneTitleParttwoLabel;
@property (nonatomic, retain) UILabel               *varifyPhoneDescPartoneLabel;

@end

@implementation ALVerifyPhoneViewController

@synthesize VerifyPhonenumberMainScrollView         = _VerifyPhonenumberMainScrollView;
@synthesize VerifyPhonenumberScrrenSubmitButton     = _VerifyPhonenumberScrrenSubmitButton;
@synthesize VerifyPhonenumberScrrenNametextField    = _VerifyPhonenumberScrrenNametextField;
@synthesize VerifyPhonenumberScrrenCrossButton      = _VerifyPhonenumberScrrenCrossButton;
@synthesize VerifyPhonenumberScrrenResendCodeButton = _VerifyPhonenumberScrrenResendCodeButton;
@synthesize varifyPhoneTitlePartoneLabel            = _varifyPhoneTitlePartoneLabel;
@synthesize varifyPhoneTitleParttwoLabel            = _varifyPhoneTitleParttwoLabel;
@synthesize varifyPhoneDescPartoneLabel             = _varifyPhoneDescPartoneLabel;


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
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    _VerifyPhonenumberScrrenCrossButton             = (UIButton *)[self.view viewWithTag:11];
    [_VerifyPhonenumberScrrenCrossButton addTarget:self action:@selector(AccessAppRegistrationService) forControlEvents:UIControlEventTouchUpInside];
    
    _VerifyPhonenumberScrrenNametextField           = [GlobalAccess GenerateTextFieldForAcess:13 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@""];
    
    _VerifyPhonenumberScrrenSubmitButton            = (UIButton *)[self.view viewWithTag:14];
    [_VerifyPhonenumberScrrenSubmitButton addTarget:self action:@selector(ValidateFieldDataForvarifypassword) forControlEvents:UIControlEventTouchUpInside];
    
    _VerifyPhonenumberScrrenResendCodeButton            = (UIButton *)[self.view viewWithTag:16];
    [_VerifyPhonenumberScrrenResendCodeButton addTarget:self action:@selector(ResendVarificationCode) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)ResendVarificationCode {
    
    FadelayoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 390)];
    [FadelayoutView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:FadelayoutView];
    [self.view bringSubviewToFront:FadelayoutView];
    
    [self startSpin];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *StringData = [NSString stringWithFormat:@"%@ReSendUserVarificationNumber?consumerid=%@",API,[NSString stringWithFormat:@"%@",[self GetLoginUserId]]];
        
        NSLog(@"StringData --- %@",StringData);
        
        NSData *dataFromContainingUrl = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:StringData]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self stopSpin];
            
            NSDictionary *getArray=[NSJSONSerialization JSONObjectWithData:dataFromContainingUrl options:kNilOptions error:nil];
            
            NSLog(@"getArray --- %@",getArray);
            
            if ([[[getArray objectForKey:@"response"] objectForKey:@"response"] isEqualToString:@"error"]) {
                
                UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[[getArray objectForKey:@"response"] objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                
                [FadelayoutView removeFromSuperview];
                [AlertView show];
            } else {
                
                ALAllRestaurantListViewController *AllRestaurantListViewController = [[ALAllRestaurantListViewController alloc] init];
                [self GotoDifferentViewWithAnimation:AllRestaurantListViewController];
                
            }
        });
    });
}
-(void)ValidateFieldDataForvarifypassword {
    
    BOOL Is_Vaidate                 = YES;
    NSString *ErrvalidationString   = nil;
    
    if ([Alconstants CleanTextField:_VerifyPhonenumberScrrenNametextField.text].isEmpty) {
        
        ErrvalidationString         = @"Varification code can't be blank";
        Is_Vaidate                  = NO;
    }
    
    if(Is_Vaidate) {
        
        FadelayoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 390)];
        [FadelayoutView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:FadelayoutView];
        [self.view bringSubviewToFront:FadelayoutView];
        
        [self startSpin];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString *StringData = [NSString stringWithFormat:@"%@VarifyPhoneNumber?UserId=%@&varificationCode=%@",API,[NSString stringWithFormat:@"%@",[self GetLoginUserId]],[Alconstants CleanTextField:_VerifyPhonenumberScrrenNametextField.text]];
            
            NSLog(@"StringData --- %@",StringData);
            
            NSData *dataFromContainingUrl = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:StringData]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self stopSpin];
                
                NSDictionary *getArray=[NSJSONSerialization JSONObjectWithData:dataFromContainingUrl options:kNilOptions error:nil];
                
                NSLog(@"getArray --- %@",getArray);
                
                if ([[[getArray objectForKey:@"response"] objectForKey:@"response"] isEqualToString:@"error"]) {
                    
                    UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[[getArray objectForKey:@"response"] objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    
                    [FadelayoutView removeFromSuperview];
                    [AlertView show];
                } else {
                    
                    ALAllRestaurantListViewController *AllRestaurantListViewController = [[ALAllRestaurantListViewController alloc] init];
                    [self GotoDifferentViewWithAnimation:AllRestaurantListViewController];
                    
                }
            });
            
        });
        
    } else {
        
        UIAlertView *AlertViewError = [[UIAlertView alloc] initWithTitle:ALStrings.VaidationErrorAlertviewTitle message:ErrvalidationString delegate:self cancelButtonTitle:ALStrings.VaidationErrorAlertviewCancelButtonTitle otherButtonTitles:nil, nil];
        [AlertViewError show];
    }
}

-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:ViewControllerName animated:NO];
    
}

-(void)AccessAppRegistrationService {
    
    ALLandingViewController *LandingView = [[ALLandingViewController alloc] init];
    [self GotoDifferentViewWithAnimation:LandingView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
