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
#import "ALWaitlistCell.h"
#import "ALMapDirectionViewController.h"
#import "ALReserveTableViewController.h"
#import "ALCreateObject.h"
#import "ZSImageView.h"
#import "AFNetworking.h"
#import "FHSStream.h"
#import "FHSTwitterEngine.h"

static float const streamingTimeoutInterval = 30.0f;

@interface ALWaitlistViewController ()<UITextFieldDelegate, UIGestureRecognizerDelegate,UIScrollViewDelegate,NSURLConnectionDelegate, UIAlertViewDelegate> {
    
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UITapGestureRecognizer *tapGesture;
    NSMutableData *_responseData;
    NSURLConnection *Connection;
    UIView          *MainDataView;
    NSMutableArray *TableViewDataDictionary;
    ALCreateObjectForData *LocalWaitingListData;
}

@property (retain, nonatomic) UITextField *SearchTextField;
@property (retain, nonatomic) UIButton *SearchTextButton;
@property (retain, nonatomic) UIView *SearchBackgroundView;
@property (retain, nonatomic) IBOutlet UIView *HeaderView;
@property (strong, nonatomic) IBOutlet DPMeterView *shape4View;
@property (nonatomic, strong) NSTimer* animationTimer;

@end

@implementation ALWaitlistViewController
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
    [self AddfooterView:2];
    
    GlobalAccess = [[ALGlobalAccess alloc] init];
    Alconstants  = [[ALConstants alloc] init];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    _SearchTextField       = [GlobalAccess GenerateTextFieldForAcess:111 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:ALAppServices.ALGetGlobalSearchTermsTextFontSize TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:ALStrings.GlobalSearchTermsText];
    [_SearchTextField setDelegate:self];
    
    _SearchBackgroundView   = (UIView *)[self.view viewWithTag:109];
    [_SearchBackgroundView.layer setOpacity:0.2f];
    [_HeaderView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_HeaderView.layer setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    
    MainDataView = (UIView *)[self.view viewWithTag:423];
    [MainDataView setHidden:YES];
    
    UIView *TableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 320, 39.0f)];
    [TableHeaderView.layer setShadowColor:[UIColor blackColor].CGColor];
    [TableHeaderView.layer setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    [TableHeaderView setBackgroundColor:[UIColor clearColor]];
    
    UIView *TableHeaderBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 39.0f)];
    [TableHeaderBackView.layer setOpacity:0.2f];
    [TableHeaderBackView setBackgroundColor:[UIColor whiteColor]];
    [TableHeaderView addSubview:TableHeaderBackView];
    
    UILabel *TableviewDetails = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 20)];
    [TableviewDetails setText:ALStrings.WaitListViewHeaderTitle];
    [TableHeaderView addSubview:TableviewDetails];
    [TableviewDetails setTextAlignment:NSTextAlignmentCenter];
    [TableviewDetails setTextColor:[UIColor whiteColor]];
    [TableviewDetails setFont:[UIFont fontWithName:ALAppServices.AFFontSecondSemiBold size:ALAppServices.ALWaitListViewTitleFontSize]];
    [self.view addSubview:TableHeaderView];
    
    UIButton *AddWaitingList = (UIButton *)[self.view viewWithTag:945];
    [AddWaitingList addTarget:self action:@selector(RemoveWaitingListToRestaurant) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ShowDirectionButton = (UIButton *)[self.view viewWithTag:77];
    [ShowDirectionButton addTarget:self action:@selector(ShowDirectionToRestaurant) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *Reservetable = (UIButton *)[self.view viewWithTag:79];
    [Reservetable addTarget:self action:@selector(ReserveTableInRestaurant) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    // Search user waitinglist details for today
    
    [self SearchUserWaitingListInfo];
    
}

#pragma Search for user ,waitinglist info for today

-(void)SearchUserWaitingListInfo
{
    
    
    [self startSpin];
    
    @try {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@GetConsumerWaitListDetails?LogedinConsumerId=%@",API,[NSString stringWithFormat:@"%@",[self GetLoginUserId]]]]];
        NSLog(@"request --- %@",request);
        Connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (Connection) {
            
            _responseData = [[NSMutableData alloc] init];
            
        } else {
            
            UIAlertView *connectFailMessage = [[UIAlertView alloc] initWithTitle:@"Internet connection error" message:@"Failed in to connection"  delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [connectFailMessage show];
            
        }
        [Connection start];
    }
    @catch (NSException *exception) {
        NSLog(@"NSException %@",[NSString stringWithFormat:@"%@",exception]);
    }
   
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
   
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse {

    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    NSError *Err = nil;
    
    [self stopSpin];
    
    @try {
        
        NSMutableDictionary *DataDictioNary = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&Err];
        
        if ([[[DataDictioNary objectForKey:@"response"] objectForKey:@"response"] isEqualToString:@"success"]) {
            
            [MainDataView setHidden:NO];
            
            TableViewDataDictionary = [[NSMutableArray alloc] init];
            NSMutableDictionary *DataDic = [DataDictioNary objectForKey:@"waitinglistdetails"];
            
            ALCreateObjectForData *LocalData = [[ALCreateObjectForData alloc] initWithResturantId:[DataDic objectForKey:@"resturant_id"] ResturantAddress:[DataDic objectForKey:@"resturant_address"] ResturantCity:[DataDic objectForKey:@"resturant_city"] ResturantEmail:[DataDic objectForKey:@"resturant_email"] ResturantLogo:[DataDic objectForKey:@"resturant_logo"] ResturantName:[DataDic objectForKey:@"resturant_name"] ResturantPhoneNo:[DataDic objectForKey:@"phone_number"] ResturantState:[DataDic objectForKey:@"restaurant_state"] ResturantZip:[DataDic objectForKey:@"restaurant_zipcode"] ResturantDistance:@"" ResturantAverageWaitTime:@"20 Mints"];
            
            LocalWaitingListData = [[ALCreateObjectForData alloc] initWithReservationId:[DataDic objectForKey:@"reservationId"] PartySize:[DataDic objectForKey:@"Party_Size"] RestaurantownerId:[DataDic objectForKey:@"restaurantownerId"] Quotedtime:[DataDic objectForKey:@"Quotedtime"] Notedata:[DataDic objectForKey:@"Notedata"] AheadOfMe:[DataDic objectForKey:@"ahead_of_me"]];
            
            UILabel *UserInFrontOfMe = (UILabel *)[MainDataView viewWithTag:107];
            [UserInFrontOfMe setText:[NSString stringWithFormat:@"%@ People in front of you",[DataDic objectForKey:@"ahead_of_me"]]];
            
            UILabel *Reataurantnamelabel = (UILabel *)[MainDataView viewWithTag:73];
            [Reataurantnamelabel setText:LocalData.ResturantName];
            
            UILabel *ReataurantAddressLineOne = (UILabel *)[MainDataView viewWithTag:74];
            [ReataurantAddressLineOne setText:LocalData.ResturantAddress];
            
            UILabel *ReataurantAddressLineTwo = (UILabel *)[MainDataView viewWithTag:75];
            [ReataurantAddressLineTwo setText:[NSString stringWithFormat:@"%@, %@, USA - %@",LocalData.ResturantState,LocalData.ResturantCity,LocalData.ResturantZip]];
            
            UILabel *ReataurantPhone = (UILabel *)[MainDataView viewWithTag:76];
            [ReataurantPhone setText:[NSString stringWithFormat:@"+1%@",LocalData.ResturantPhoneNo]];
            
            UILabel *ReataurantAvgWaittime = (UILabel *)[MainDataView viewWithTag:46];
            [ReataurantAvgWaittime setText:[NSString stringWithFormat:@"Average wait time : %@",LocalData.ResturantAverageWaitTime]];
            
            UIImageView *ResLogoView = (UIImageView *)[MainDataView viewWithTag:72];
            
            ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(ResLogoView.layer.frame.origin.x, ResLogoView.layer.frame.origin.y, ResLogoView.layer.frame.size.width, ResLogoView.layer.frame.size.height)];
            imageView.defaultImage = [UIImage imageNamed:@"logoDL.png"];
            imageView.imageUrl = LocalData.ResturantLogo;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.corners = ZSRoundCornerAll;
            imageView.cornerRadius = 23;
            [MainDataView addSubview:imageView];
            
        }
        else
        {
            UIAlertView *ConnectionError = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[[DataDictioNary objectForKey:@"response"] objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [ConnectionError show];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception is %@",[NSString stringWithFormat:@"%@",exception]);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [self stopSpin];
    UIAlertView *ConnectionError = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"There is some error in data fatching, Please try again later!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [ConnectionError setTag:301];
    [ConnectionError show];
}

#pragma remove user from waitinglist

-(void)RemoveWaitingListToRestaurant
{
    UIAlertView *RemoveWaitingListToRestaurantAlert = [[UIAlertView alloc] initWithTitle:@"Remove From WaitList" message:@"Are you sure to remove yourself from WaitList ? " delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [RemoveWaitingListToRestaurantAlert setTag:110];
    [RemoveWaitingListToRestaurantAlert show];
}

#pragma Reserve Table

-(void)ReserveTableInRestaurant {
    
    ALReserveTableViewController *ReserveTableView = [[ALReserveTableViewController alloc] init];
    [self GotoDifferentViewWithAnimation:ReserveTableView];
}

#pragma ShowMapDirection

-(void)ShowDirectionToRestaurant {
    
    ALMapDirectionViewController *ShowMapDirectionView = [[ALMapDirectionViewController alloc] init];
    ShowMapDirectionView.LastVisitedView = WaitingListView;
    [self GotoDifferentViewWithAnimation:ShowMapDirectionView];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 301:
            
            [MainDataView setHidden:YES];
            [self SearchUserWaitingListInfo];
            break;
        case 110:
            if (buttonIndex == 0) {
                
                [MainDataView setHidden:YES];
                [self RemoveUserFromWaitList];
            }
            break;
    }
}
-(void)RemoveUserFromWaitList
{
    @try {
        
        [self startSpin];
        
        NSString* path = [NSString stringWithFormat:@"%@RemoveFromWaitingList?ReservationId=%@&ReservationStatus=W",API,LocalWaitingListData.ReservationId];
        
        NSLog(@"path ---- %@",path);
        NSMutableURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [self stopSpin];
            
            UIAlertView *RemoveWaitingListToRestaurantAlert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Waitinglist deleted Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [RemoveWaitingListToRestaurantAlert show];
            
            NSLog(@"success: %@", operation.responseString);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self stopSpin];
            NSLog(@"error: %@",  operation.responseString);
        }];
        
        [operation start];
    }
    @catch (NSException *exception) {
        
        NSLog(@"exception --- %@",[NSString stringWithFormat:@"%@",exception]);
    }
}
-(IBAction)HideKeyboard:(id)sender {
     
    [_SearchTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
