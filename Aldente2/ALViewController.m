//
//  ALViewController.m
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALViewController.h"
#import "ALRedirectViews.h"
#import "ALConstants.h"
#import "ALAllImages.h"
#import "ALNibNames.h"
#import "ALVerifyPhoneViewController.h"
#import "ALAllRestaurantListViewController.h"
#import "ALLandingViewController.h"

@interface ALViewController () {
    
    UIImage *image;
    UIImageView *loadingView;
}

@property (nonatomic,weak) NSTimer  *IndecaterTime;
- (void)startSpin;
@end

@implementation ALViewController

@synthesize IndecaterTime               = _IndecaterTime;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    IMFAPPPRINTMETHOD();
    
    self        = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self    = [super initWithNibName:ALNibNames.MainViewScreen bundle:nil];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startSpin];
    
    if (ALConstants.IsConnectedToInternet) {
        
        _IndecaterTime = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(StopAnimatingLoaderAndRedirect) userInfo:nil repeats:NO];
    } else {
        
    }
}

-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:ViewControllerName animated:NO];
    
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
-(void)StopAnimatingLoaderAndRedirect {
    
    [self stopSpin];
    ALLandingViewController *AllRestaurantListViewController = [[ALLandingViewController alloc] init];
    [self GotoDifferentViewWithAnimation:AllRestaurantListViewController];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewDidUnload
{
    [_IndecaterTime invalidate];
}

@end
