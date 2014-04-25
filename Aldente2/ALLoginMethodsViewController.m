//
//  ALLoginMethodsViewController.m
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALLoginMethodsViewController.h"
#import "ALNibNames.h"
#import "ALAllImages.h"
#import "ALStrings.h"
#import "ALAppServices.h"
#import "ALRedirectViews.h"
#import "ALGlobalAccess.h"
#import "ALConstants.h"
#import "NSString+Extend.h"
#import "ALAllRestaurantListViewController.h"

#import "ALAppDelegate.h"

@interface ALLoginMethodsViewController ()<UITextFieldDelegate,UIScrollViewDelegate> {
    
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UIImage *image;
    UIImageView *loadingView;
    UIView *FadelayoutView;
}

@property (nonatomic,retain) UIScrollView                   *RegistrationMainScrollView;
@property (nonatomic,retain) UIButton                       *RegistrationScrrenCrossButton;
@property (nonatomic,retain) UIButton                       *RegistrationScrrenSignupButton;
@property (nonatomic,retain) IBOutlet UIButton              *RegistrationScrrenAgreeTermsButton;
@property (nonatomic,retain) UITextField                    *RegistrationScrrenBirthdayButton;

@property (nonatomic,retain) UITextField                    *RegistrationScrrenNametextField;
@property (nonatomic,retain) UITextField                    *RegistrationScrrenEmailtextField;
@property (nonatomic,retain) UITextField                    *RegistrationScrrenPhonetextField;

@property (nonatomic,retain) UILabel                        *RegistrationScrrenTermslabel;

-(IBAction)ProcessLogin:(id)sender;

@end

@implementation ALLoginMethodsViewController

int is_Terms_Enabled_one                            = 0;

@synthesize RegistrationScrrenCrossButton           = _RegistrationScrrenCrossButton;
@synthesize RegistrationScrrenSignupButton          = _RegistrationScrrenSignupButton;
@synthesize RegistrationScrrenAgreeTermsButton      = _RegistrationScrrenAgreeTermsButton;
@synthesize RegistrationScrrenBirthdayButton        = _RegistrationScrrenBirthdayButton;
@synthesize RegistrationScrrenNametextField         = _RegistrationScrrenNametextField;
@synthesize RegistrationScrrenEmailtextField        = _RegistrationScrrenEmailtextField;
@synthesize RegistrationScrrenPhonetextField        = _RegistrationScrrenPhonetextField;
@synthesize RegistrationScrrenTermslabel            = _RegistrationScrrenTermslabel;
@synthesize RegistrationMainScrollView              = _RegistrationMainScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self        = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self    = [super initWithNibName:ALNibNames.LoginViewScreen bundle:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GlobalAccess = [[ALGlobalAccess alloc] init];
    Alconstants  = [[ALConstants alloc] init];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    _RegistrationMainScrollView = [GlobalAccess GenerateUIScrollForAcess:10 GlobalView:self.view Delegate:self ScrollEnabled:YES userInteractionEnabled:YES showsVerticalScrollIndicator:YES SCrollBackgroundColor:[UIColor clearColor] ScrollviewExtraWidth:0 ScrollViewExtraHeight:150];
    
    _RegistrationScrrenEmailtextField = [GlobalAccess GenerateTextFieldForAcess:12 Delegate:self TextFiledtextColor:ALAppServices.AlTextFiledTextColor TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.LoginScreenEmailFiledPlaceholder];
    
    _RegistrationScrrenNametextField = [GlobalAccess GenerateTextFieldForAcess:13 Delegate:self TextFiledtextColor:ALAppServices.AlTextFiledTextColor TextFieldsetFontSize:ALAppServices.ALTermsAndServicesFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.LoginScreenPasswordFiledPlaceholder];
    
    [GlobalAccess GenerateUIlabelForAcess:18 Delegate:self UilabeltextColor:ALAppServices.AlTextFiledTextColor UilabelsetFontSize:ALAppServices.ALTermsAndServicesFontSize UilabelFont:ALAppServices.AFFontRegular GlobalView:self.view UilabelText:ALStrings.LoginScreenRememberMe UilabelTextAlignment:NSTextAlignmentLeft];
 
    _RegistrationScrrenCrossButton          = (UIButton *)[self.view viewWithTag:11];
    [_RegistrationScrrenCrossButton addTarget:self action:@selector(CrossView) forControlEvents:UIControlEventTouchUpInside];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
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
    
    [UIView animateWithDuration:0.4f animations:^{
        
        if (sender.tag == 12) {
            [_RegistrationMainScrollView setContentOffset:CGPointMake(0, 50) animated:YES];
        } else if (sender.tag == 13) {
            [_RegistrationMainScrollView setContentOffset:CGPointMake(0, 75) animated:YES];
        } else if (sender.tag == 14) {
            [_RegistrationMainScrollView setContentOffset:CGPointMake(0, 100) animated:YES];
        } else if (sender.tag == 15) {
            [_RegistrationScrrenBirthdayButton becomeFirstResponder];
        }
    } completion:^(BOOL finished) {
    }];
    
}
-(IBAction)SlideDownPopupWhileEditing:(UITextField *)sender {
    
    [UIView animateWithDuration:0.4f animations:^{
        [_RegistrationMainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } completion:^(BOOL finished) {
    }];
}

-(IBAction)ClickedOnTermsAndCondition:(UITextField *)sender {
    
    if (is_Terms_Enabled_one == 0) {
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPSelectedCheckboxIcon] forState:UIControlStateNormal];
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPSelectedCheckboxIcon] forState:UIControlStateSelected];
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPSelectedCheckboxIcon] forState:UIControlStateHighlighted];
        
        is_Terms_Enabled_one = 1;
    } else {
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPUnSelectedCheckboxIcon] forState:UIControlStateNormal];
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPUnSelectedCheckboxIcon] forState:UIControlStateSelected];
        [_RegistrationScrrenAgreeTermsButton setImage:[UIImage imageNamed:ALAllImages.APPUnSelectedCheckboxIcon] forState:UIControlStateHighlighted];
        
        is_Terms_Enabled_one = 0;
    }
}
-(IBAction)ProcessLogin:(id)sender {
    
    BOOL Is_Vaidate                 = YES;
    NSString *ErrvalidationString   = nil;
    
    if ([Alconstants CleanTextField:_RegistrationScrrenNametextField.text].isEmpty) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenNameFiledBlank;
        Is_Vaidate                  = NO;
    } else if ([Alconstants CleanTextField:_RegistrationScrrenEmailtextField.text].isEmpty) {
        
        ErrvalidationString         = ALStrings.ErrorRegistrationScreenEmailFiledBlank;
        Is_Vaidate                  = NO;
    }
    if (Is_Vaidate) {
        [self.view endEditing:YES];
        
        [self SlideDownPopupWhileEditing:nil];
        
        FadelayoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 390)];
        [FadelayoutView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:FadelayoutView];
        [self.view bringSubviewToFront:FadelayoutView];
        
        [self startSpin];
        
        // @try {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString *StringData = [NSString stringWithFormat:@"%@consumerLogin?email=%@&password=%@",API,[[Alconstants CleanTextField:_RegistrationScrrenEmailtextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[Alconstants CleanTextField:_RegistrationScrrenNametextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
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
                    NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
                    [UserDefaults setObject:[[getArray objectForKey:@"consumerdetails"] objectForKey:@"consumerid"] forKey:@"USERID"];
                    
                    NSLog(@"UserDefaults---- %@",[UserDefaults objectForKey:@"USERID"]);
                    
                    ALAllRestaurantListViewController *AllRestaurantListViewController = [[ALAllRestaurantListViewController alloc] init];
                    CATransition* transition = [CATransition animation];
                    transition.duration = 0.25f;
                    transition.type = kCATransitionFade;
                    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                    [self.navigationController pushViewController:AllRestaurantListViewController animated:NO];
                    
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
