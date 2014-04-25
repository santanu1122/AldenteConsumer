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
#import "ALRestaurantDetailsViewController.h"
#import "AFNetworking.h"
#import "ALCreateObject.h"
#import "ZSImageView.h"

@interface ALAllRestaurantListViewController ()<CLLocationManagerDelegate,CoreLocationControllerDelegate,CLLocationManagerDelegate,UITextFieldDelegate, UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,NSURLConnectionDelegate,UIAlertViewDelegate> {
    
    ALGlobalAccess              *GlobalAccess;
    ALConstants                 *Alconstants;
    CLLocationManager           *UserLocation;
    CLLocation                  *currentLocation;
    UITapGestureRecognizer      *tapGesture;
    NSURLConnection             *UrlConnection;
    NSMutableData               *responseData;
    UIImageView                 *loadingView;
    NSMutableArray              *TableViewDataDictionary;
    NSString                    *UserCurrentLLatitude;
    NSString                    *UserCurrentLLongitude;
}
@property (nonatomic,retain)  CLLocationManager *MYLOCATION;
@property (nonatomic, retain) CoreLocationController *locationController;
@property (strong, nonatomic) CLLocationManager *location;
@property (retain, nonatomic) UITextField *SearchTextField;
@property (retain, nonatomic) UIButton *SearchTextButton;
@property (retain, nonatomic) UIView *SearchBackgroundView;
@property (retain, nonatomic) IBOutlet UIView *HeaderView;
@property (retain, nonatomic) IBOutlet UITableView *UITableView;

@end

@implementation ALAllRestaurantListViewController

@synthesize MYLOCATION                  = _MYLOCATION;
@synthesize SearchTextField             = _SearchTextField;
@synthesize SearchTextButton            = _SearchTextButton;
@synthesize SearchBackgroundView        = _SearchBackgroundView;
@synthesize HeaderView                  = _HeaderView;
@synthesize UITableView                 = _UITableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    
/**
    Load Curreent View
*/
    
[super viewDidLoad];
    
/**
    allocate the memory for GlobalAccess and App constance data, to access all the globally decleared variable
*/
    
GlobalAccess = [[ALGlobalAccess alloc] init];
Alconstants  = [[ALConstants alloc] init];
    
/**
    preapere scrren for create the layout
*/
    
[self PrepareScreenIntomainView];
    
/* 
 
 Set Uitableview Delegate and datasource
 @param tableview is _UITableView
 
*/
    
[_UITableView setDelegate:self];
[_UITableView setDataSource:self];
    
/*
 
 Get use location using the corelocation manager
 user Current latitude and Longitude store parameter is
 @param UserCurrentLLatitude
 @param UserCurrentLLongitude
 
*/

// Allocate @CLLocationManager

_location = [[CLLocationManager alloc] init];
    
// Identify user @current Location
    
[self CurrentLocationIdentifier];

// get user current location latitude using @param location.coordinate.latitude
    
UserCurrentLLatitude    = [NSString stringWithFormat:@"%f",_location.location.coordinate.latitude];

// get user current location longitude using @param location.coordinate.longitude
    
UserCurrentLLongitude   = [NSString stringWithFormat:@"%f",_location.location.coordinate.longitude];

/*
 
 Start Call URL for fetch restaurant around the user
 if #user @latitude and @longitude is nil, will show all the restaurant
 @param UserCurrentLLatitude
 @param UserCurrentLLongitude
 
*/
    
[self GetAllRestaurantListingAgainstUserLocation:UserCurrentLLatitude UserCurrentLongitude:UserCurrentLLongitude];
   
}
#pragma Prepare Scren

-(void)PrepareScreenIntomainView
{
    // Prepare Scrren
    
    [self AddfooterView:1];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [_HeaderView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_HeaderView.layer setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    
    _SearchBackgroundView   = (UIView *)[self.view viewWithTag:109];
    [_SearchBackgroundView.layer setOpacity:0.2f];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    _SearchTextField       = [GlobalAccess GenerateTextFieldForAcess:111 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALGetGlobalSearchTermsTextFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.GlobalSearchTermsText];
    [_SearchTextField setDelegate:self];
    
    // Prepare Scrren Done
}

-(void)GetAllRestaurantListingAgainstUserLocation:(NSString *)UserCurrentLatitude UserCurrentLongitude:(NSString *)UserCurrentLongitude
{
    [self startSpin];
    [_UITableView setHidden:YES];
    
    @try {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSError *Err = nil;
            UserCurrentLLatitude = UserCurrentLatitude;
            UserCurrentLLongitude = UserCurrentLongitude;
            
            NSString *urlString = [NSString stringWithFormat:@"%@get_resturantlist?UserCurrentLatitude=%@&UserCurrentLongitude=%@",API,UserCurrentLatitude,UserCurrentLongitude];
            NSLog(@"urlString ---%@",urlString);
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *MainData = [[NSData alloc] initWithContentsOfURL:url options:kNilOptions error:&Err];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSError *Err = nil;
                NSMutableDictionary *DataDictioNary = [NSJSONSerialization JSONObjectWithData:MainData options:kNilOptions error:&Err];
                
                @try {
                    
                    if (!Err) {
                        
                        if ([[[DataDictioNary objectForKey:@"response"] objectForKey:@"response"] isEqualToString:@"success"]) {
                            
                            TableViewDataDictionary = [[NSMutableArray alloc] init];
                            
                            for (NSMutableDictionary *DataDic in [DataDictioNary objectForKey:@"consumerdetails"]) {
                                
                                [TableViewDataDictionary addObject:[[ALCreateObjectForData alloc] initWithResturantId:[DataDic objectForKey:@"resturant_id"] ResturantAddress:[DataDic objectForKey:@"resturant_address"] ResturantCity:[DataDic objectForKey:@"resturant_city"] ResturantEmail:[DataDic objectForKey:@"resturant_email"] ResturantLogo:[DataDic objectForKey:@"resturant_logo"] ResturantName:[DataDic objectForKey:@"resturant_name"] ResturantPhoneNo:[DataDic objectForKey:@"phone_number"] ResturantState:[DataDic objectForKey:@"restaurant_state"] ResturantZip:[DataDic objectForKey:@"restaurant_zipcode"] ResturantDistance:[DataDic objectForKey:@"resturantDistance"] ResturantAverageWaitTime:[DataDic objectForKey:@"resturantAverageWaitTime"]]];
                            }
                            [self stopSpin];
                            [_UITableView setHidden:NO];
                            [_UITableView reloadData];
                            
                        } else {
                           
                            NSException *theException = [NSException exceptionWithName:NSInvalidArgumentException reason:@"Some error just occurred!" userInfo:nil];
                             NSLog(@"exception1 ---- %@",theException);
                            @throw theException;
                        }
                    } else {
                        NSException *theException = [NSException exceptionWithName:NSInvalidArgumentException reason:@"Some error just occurred!" userInfo:nil];
                         NSLog(@"exception2 ---- %@",theException);
                        @throw theException;
                    }
                }
                @catch (NSException *Exception) {
                    
                    [self stopSpin];
                    NSLog(@"exception3 ---- %@",Exception);
                    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",Exception] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
                    [Alert setTag:121];
                    [Alert show];
                }
            });
            
        });
    }
    @catch (NSException *exception) {
        
        [self stopSpin];
        NSLog(@"exception ---- %@",exception);
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",exception] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
        [Alert setTag:122];
        [Alert show];
    }
}
-(void)CurrentLocationIdentifier
{
    NSLog(@"CurrentLocationIdentifier --");
    UserLocation = [CLLocationManager new];
    UserLocation.delegate = self;
    UserLocation.distanceFilter = kCLDistanceFilterNone;
    UserLocation.desiredAccuracy = kCLLocationAccuracyBest;
    [UserLocation startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    
    [UserLocation stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             UserCurrentLLatitude    =  [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
             UserCurrentLLongitude   =  [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
            // [self GetAllRestaurantListingAgainstUserLocation:UserCurrentLLatitude UserCurrentLongitude:UserCurrentLLongitude];
         }
         else
         {
             UserCurrentLLatitude    =  @"";
             UserCurrentLLongitude   =  @"";
            // [self GetAllRestaurantListingAgainstUserLocation:UserCurrentLLatitude UserCurrentLongitude:UserCurrentLLongitude];
         }
     }];
}

#pragma tableview details

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [TableViewDataDictionary count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ALRestaurantViewCell";
    
    ALRestaurantViewCell *cell = (ALRestaurantViewCell *)[_UITableView dequeueReusableCellWithIdentifier:CellIdentifier];
    ALCreateObjectForData *LocalData = [TableViewDataDictionary objectAtIndex:indexPath.row];
    if (cell == nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (ALRestaurantViewCell *)[nibArray objectAtIndex:0];
    }
    
    UILabel *RestaurantNameLabel = (UILabel *)[cell.contentView viewWithTag:192];
    [RestaurantNameLabel setText:LocalData.ResturantName];
    
    UILabel *RestaurantDistance = (UILabel *)[cell.contentView viewWithTag:193];
    [RestaurantDistance setText:[NSString stringWithFormat:@"Distance : %@",LocalData.ResturantDistance]];
    
    UILabel *RestaurantAvgWaitTime = (UILabel *)[cell.contentView viewWithTag:194];
    [RestaurantAvgWaitTime setText:[NSString stringWithFormat:@"Average Wait Time : %@",LocalData.ResturantAverageWaitTime]];
    
    UIImageView *ResLogoView = (UIImageView *)[cell.contentView viewWithTag:191];
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(ResLogoView.layer.frame.origin.x, ResLogoView.layer.frame.origin.y, ResLogoView.layer.frame.size.width, ResLogoView.layer.frame.size.height)];
	imageView.defaultImage = [UIImage imageNamed:@"logoDL.png"];
	imageView.imageUrl = LocalData.ResturantLogo;
	imageView.contentMode = UIViewContentModeScaleAspectFill;
	imageView.clipsToBounds = YES;
	imageView.corners = ZSRoundCornerAll;
	imageView.cornerRadius = 23;
	[cell.contentView addSubview:imageView];
    
    cell.backgroundView         =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"row-bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    cell.selectedBackgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"row-bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALCreateObjectForData *LocalData = [TableViewDataDictionary objectAtIndex:indexPath.row];
    ALRestaurantDetailsViewController *RestaurantDetails = [[ALRestaurantDetailsViewController alloc] init];
    [RestaurantDetails setRestaurantUniqueId:LocalData.ResturantId];
    [self GotoDifferentViewWithAnimation:RestaurantDetails];
}

-(IBAction)HideKeyboard:(id)sender {
    
    [_SearchTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 121 || alertView.tag == 122) {
        [self GetAllRestaurantListingAgainstUserLocation:UserCurrentLLatitude UserCurrentLongitude:UserCurrentLLongitude];
    }
}

@end
