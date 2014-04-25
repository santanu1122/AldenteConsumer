//
//  ALRestaurantDetailsViewController.m
//  AlDenteConsumer
//
//  Created by Iphone_2 on 15/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "ALRestaurantDetailsViewController.h"
#import "ALAllRestaurantListViewController.h"
#import "ALMapDirectionViewController.h"
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
#import "MapView.h"
#import "Place.h"

@interface ALMapDirectionViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UITapGestureRecognizer *tapGesture;
    UIImageView *loadingView;
}
@property (retain, nonatomic) UITextField *SearchTextField;
@property (retain, nonatomic) UIButton *SearchTextButton;
@property (retain, nonatomic) UIView *SearchBackgroundView;
@property (retain, nonatomic) IBOutlet UIView *HeaderView;
@end

@implementation ALMapDirectionViewController

@synthesize SearchTextField             = _SearchTextField;
@synthesize SearchTextButton            = _SearchTextButton;
@synthesize SearchBackgroundView        = _SearchBackgroundView;
@synthesize HeaderView                  = _HeaderView;

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
    
    UIView *HeaderTitleView = (UIView *)[self.view viewWithTag:75];
    [HeaderTitleView.layer setOpacity:0.2f];
    
    UIButton *HeaderBackButton = (UIButton *)[self.view viewWithTag:110];
    [HeaderBackButton addTarget:self action:@selector(GoBackTOPreviousScreen) forControlEvents:UIControlEventTouchUpInside];
    
    MapView* mapView = [[MapView alloc] initWithFrame:CGRectMake(0, 103, self.view.frame.size.width, self.view.frame.size.height-103)];
	
	[self.view addSubview:mapView];
	
	Place* home = [[Place alloc] init];
	home.name = @"Current Location";
	home.description = @"First Avenue,. New York, NY 10118-3299 USA";
	home.latitude = 41.029598;
	home.longitude = 28.972985;
	
	Place* office = [[Place alloc] init];
	office.name = @"Alpine Dubai Hotel";
	office.description = @"350 Fifth Avenue, 34th floor. New York, NY 10118-3299 USA";
	office.latitude = 41.033586;
	office.longitude = 28.984546;
    
    [self startSpin];
    
    [self AddfooterView];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    @try {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [mapView showRouteFrom:home to:office];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self stopSpin];
            });
        });
    }
    @catch (NSException *exception) {
        
        NSLog(@"There is some error");
    }
}

#pragma mark Spin Button

- (void)startSpin
{
    if (!loadingView) {
        loadingView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 380, 26, 26)];
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

- (void)stopSpin
{
    [loadingView.layer removeAllAnimations];
    loadingView.hidden = YES;
}

#pragma GoBack

-(void)GoBackTOPreviousScreen {
    
    ALRestaurantDetailsViewController *RestaurantDetails = [[ALRestaurantDetailsViewController alloc] init];
    [self GotoDifferentViewWithAnimation:RestaurantDetails];
    
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
    
    UIImageView *touchedImageView = (UIImageView *)[AllAirportListView viewWithTag:11];
    [touchedImageView setImage:[UIImage imageNamed:@"icon1ON.png"]];
    
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
    UIViewController *nextViewController;
    
    switch([touchedView tag])
    {
        case 233: nextViewController            =   [[ALAllRestaurantListViewController alloc] init];
            break;
        case 234: nextViewController            =   [[ALWaitlistViewController alloc] init];
            break;
        case 235: nextViewController            =   [[ALReservationsViewController alloc] init];
            break;
        case 236: nextViewController            =   [[ALCouponsViewController alloc] init];
            break;
        case 237: nextViewController            =   [[ALMoreViewController alloc] init];
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
-(IBAction)HideKeyboard:(id)sender {
    
    [_SearchTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
