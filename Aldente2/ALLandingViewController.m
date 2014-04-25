//
//  ALLandingViewController.m
//  AlDenteConsumer
//
//  Created by Iphone_2 on 04/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "ALLandingViewController.h"
#import "ALNibNames.h"
#import "ALAllImages.h"
#import "ALStrings.h"
#import "ALAppServices.h"
#import "ALRedirectViews.h"
#import "ALSocialRegistrationViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AFNetworking.h"
#import "ALAppDelegate.h"
@interface ALLandingViewController (){
    ACAccountStore *accountStore;
    NSString *username;
    NSString *user_id;
    NSString *fullName;
    NSString *dob;
    NSString *email_id;
    NSString *isuser;
    NSString  *_FBAccessToken;
    NSOperationQueue *OperationQueue;
    BOOL IsFBThreadFire;
    int strfbId;
    NSString *response;
    NSString *mode;
   UIImageView *loadingView;
}

@property (nonatomic,retain) UIButton   *LaningScreenFacebookLoginButton;
@property (nonatomic,retain) UIButton   *LaningScreenTwitterLoginButton;
@property (nonatomic,retain) UIButton   *LaningScreenAppLoginButton;
@property (nonatomic,retain) UIButton   *LaningScreenAppRegistrationButton;
@property (nonatomic,retain) UILabel    *LaningScreenGetStartedTitle;
@property (nonatomic,retain) UILabel    *LaningScreenGetStartedDescription;
@property (nonatomic,retain) UILabel    *LaningScreenSigninTitle;
@property (nonatomic,retain) UILabel    *LaningScreenSigninDescription;
@property (readonly, copy) NSString *appID;
@end

@implementation ALLandingViewController

@synthesize LaningScreenFacebookLoginButton         = _LaningScreenFacebookLoginButton;
@synthesize LaningScreenTwitterLoginButton          = _LaningScreenTwitterLoginButton;
@synthesize LaningScreenAppLoginButton              = _LaningScreenAppLoginButton;
@synthesize LaningScreenAppRegistrationButton       = _LaningScreenAppRegistrationButton;
@synthesize LaningScreenGetStartedTitle             = _LaningScreenGetStartedTitle;
@synthesize LaningScreenGetStartedDescription       = _LaningScreenGetStartedDescription;
@synthesize LaningScreenSigninTitle                 = _LaningScreenSigninTitle;
@synthesize LaningScreenSigninDescription           = _LaningScreenSigninDescription;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self    = [super initWithNibName:ALNibNames.landingViewScreen bundle:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    OperationQueue=[[NSOperationQueue alloc]init];
   [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    _LaningScreenFacebookLoginButton                = (UIButton *)[self.view viewWithTag:111];
    _LaningScreenTwitterLoginButton                 = (UIButton *)[self.view viewWithTag:112];
    _LaningScreenAppLoginButton                     = (UIButton *)[self.view viewWithTag:117];
    _LaningScreenAppRegistrationButton              = (UIButton *)[self.view viewWithTag:118];
    
    _LaningScreenGetStartedTitle                    = (UILabel *)[self.view viewWithTag:113];
    _LaningScreenGetStartedDescription              = (UILabel *)[self.view viewWithTag:114];
    _LaningScreenSigninTitle                        = (UILabel *)[self.view viewWithTag:115];
    _LaningScreenSigninDescription                  = (UILabel *)[self.view viewWithTag:116];
    
    [_LaningScreenGetStartedTitle setText:ALStrings.LandingScreenGetStartedTitle];
    [_LaningScreenGetStartedTitle setFont:[UIFont fontWithName:ALAppServices.AFFontSemibold size:ALAppServices.ALGetStartedTitleFontSize]];
    
    [_LaningScreenGetStartedDescription setText:ALStrings.LandingScreenGetStartedCaption];
    [_LaningScreenGetStartedDescription setFont:[UIFont fontWithName:ALAppServices.AFFontRegular size:ALAppServices.ALGetStartedTaglineFontSize]];
    
    [_LaningScreenSigninTitle setText:ALStrings.LandingScreenSigninTitle];
    [_LaningScreenSigninTitle setFont:[UIFont fontWithName:ALAppServices.AFFontSemibold size:ALAppServices.ALSigninTitleFontSize]];
    
    [_LaningScreenSigninDescription setText:ALStrings.LandingScreenSigninCaption];
    [_LaningScreenSigninDescription setFont:[UIFont fontWithName:ALAppServices.AFFontRegular size:ALAppServices.ALSigninTaglineFontSize]];
    
    [_LaningScreenAppLoginButton addTarget:self action:@selector(AccessAppLoginService) forControlEvents:UIControlEventTouchUpInside];
    [_LaningScreenAppRegistrationButton addTarget:self action:@selector(AccessAppRegistrationService) forControlEvents:UIControlEventTouchUpInside];
    [_LaningScreenTwitterLoginButton addTarget:self action:@selector(AccessAppTwitterLogin) forControlEvents:UIControlEventTouchUpInside];
    [_LaningScreenFacebookLoginButton addTarget:self action:@selector(AccessAppFacebookLogin) forControlEvents:UIControlEventTouchUpInside];
   
}

-(void)AccessAppTwitterLogin{
    
    [self startSpin];
    if(!accountStore)
        accountStore = [[ACAccountStore alloc] init];
    ACAccountType *TwitterTypeAccount = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:TwitterTypeAccount options:nil completion:^(BOOL granted, NSError *error)
     {
         
         if (granted) {
             
             NSArray *accounts = [accountStore accountsWithAccountType:TwitterTypeAccount];
             if (accounts.count > 0)
             {
                 ACAccount *twitterAccountone = [accounts lastObject];
                 username=twitterAccountone.username;
                 user_id = [[twitterAccountone valueForKey:@"properties"] valueForKey:@"user_id"];
               SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject:username forKey:@"screen_name"]];
                 
                 [twitterInfoRequest setAccount:twitterAccountone];
                 [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                     
                     if ([urlResponse statusCode] == 429) {
                         
                         NSLog(@"Rate limit reached");
                         
                         return;
                         
                     }
                     if (error) {
                         NSLog(@"Error: %@", error.localizedDescription);
                         return;
                     }
                     [self stopSpin];
                     if (responseData) {
                         NSError *error = nil;
                         NSArray *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                         fullName=[(NSDictionary *)TWData objectForKey:@"name"];
                         mode=@"twitter";
                         [self performSelectorOnMainThread:@selector(social_registration) withObject:nil waitUntilDone:YES];
                         
                     }
                     
                     
                 }];
             }else {
                 
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please add Twitter account in your phone settings" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 
                 [alert show];
             }
         } else {
             
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please allow access your twitter account from settings" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             
             [alert show];
         }
     }];
    
}


-(void)AccessAppFacebookLogin
{
    if (FBSession.activeSession.isOpen)
    {
        [self updateViewForFbLogin];
    }
    else
    {
        [self openSessionWithAllowLoginUI:YES];
    }
}
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI
{
    NSArray *permissions = [[NSArray alloc] initWithObjects: @"email",@"phone", nil];
    return [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:allowLoginUI completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        [self sessionStateChanged:session state:status error:error];
    }];
    return YES;
}
- (void)updateViewForFbLogin
{
    ALAppDelegate *appDelegate = (ALAppDelegate *)[[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen)
    {
        _FBAccessToken=appDelegate.session.accessTokenData.accessToken;
        NSLog(@"FBAccessToken-- %@", _FBAccessToken);
        if(![FBAccessTokenData  isEqual:@""] && !IsFBThreadFire)
        {
            IsFBThreadFire=TRUE;
            [self startSpin];
            NSInvocationOperation *RegisterOperation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(getFacebookFeed) object:nil];
            [OperationQueue addOperation:RegisterOperation];
        }
    }
    else
    {
        [[self view] setUserInteractionEnabled:YES];
        [[FBSession activeSession] closeAndClearTokenInformation];
        [[FBSession activeSession] close];
    }
}
-(void) getFacebookFeed
{
    
    
    @try
    {
        NSError *gotError       =   nil;
        NSString *url           =   [NSString stringWithFormat:@"%@me?access_token=%@",GraphAPI, _FBAccessToken];
        NSData *getData         =   [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        if([getData length]>0)
        {
            
            NSArray *getArray   =   [NSJSONSerialization JSONObjectWithData:getData options:kNilOptions error:&gotError];
            
            NSLog(@"getArray --- %@",getArray);
            if(!gotError)
            {
                user_id   =   [getArray valueForKey:@"id"];
                fullName=[getArray valueForKey:@"name"];
                dob=[getArray valueForKey:@"birthday"];
                email_id=[getArray valueForKey:@"email"];
                mode=@"facebook";
               
                [self stopSpin];
                [self performSelectorOnMainThread:@selector(social_registration) withObject:nil waitUntilDone:YES];
            }//if
            else
            {
                [self stopSpin];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:gotError.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
        }
        else
        {
            [self stopSpin];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Data is null.." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }
    }
    @catch (NSException *FbLoginException)
    {
        NSLog(@"FbLoginException ---- %@",FbLoginException);
    }
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error

{
    switch (state)
    
    {
        case FBSessionStateOpen:
            
            if (!error)
                
            {
                [[self view] setUserInteractionEnabled:YES];
                
                ALAppDelegate *appDelegate = (ALAppDelegate *)[[UIApplication sharedApplication] delegate];
                
                appDelegate.session=session;
             [self updateViewForFbLogin];
              
            }
            
            break;
            
        case FBSessionStateClosed:
            
        case FBSessionStateClosedLoginFailed:
            NSLog(@"Valid Session ClosedLoginFailed");
            
            [[self view] setUserInteractionEnabled:YES];
            [FBSession.activeSession closeAndClearTokenInformation];
            
            break;
            
        default:
            
            break;
    }
}


-(void)social_registration{
    
    ALSocialRegistrationViewController *socialview= [[ALSocialRegistrationViewController alloc]initWithNibName:@"ALSocialRegistrationViewController" bundle:Nil];
    
    socialview.userid=user_id;
    
    socialview.fullname=fullName;
     socialview.login_mode=mode;
    if([mode isEqualToString:@"facebook"]){
         socialview.email=email_id;
         socialview.birthday=dob;
    }else{
        socialview.username=username;
    }
    [self GotoDifferentViewWithAnimation:socialview];
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


-(void)AccessAppLoginService {
    
    [self GotoDifferentViewWithAnimation:ALRedirectViews.RegisterViewController];
}

-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:ViewControllerName animated:NO];
    
}

-(void)AccessAppRegistrationService {
    
    [self GotoDifferentViewWithAnimation:ALRedirectViews.LoginViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
