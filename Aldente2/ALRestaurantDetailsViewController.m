//
//  ALRestaurantDetailsViewController.m
//  AlDenteConsumer
//
//  Created by Iphone_2 on 15/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "ALRestaurantDetailsViewController.h"
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
#import "ALMapDirectionViewController.h"
#import "ALReserveTableViewController.h"
#import "ALAddwaitlistViewController.h"
#import "ALCreateObject.h"
#import "ZSImageView.h"

@interface ALRestaurantDetailsViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UITapGestureRecognizer *tapGesture;
    UIImageView *loadingView;
    NSMutableArray *TableViewDataDictionary;
    UIView *MainBackgroundView;
}
@property (retain, nonatomic) UITextField *SearchTextField;
@property (retain, nonatomic) UIButton *SearchTextButton;
@property (retain, nonatomic) UIView *SearchBackgroundView;
@property (retain, nonatomic) IBOutlet UIView *HeaderView;
@end

@implementation ALRestaurantDetailsViewController

@synthesize SearchTextField             = _SearchTextField;
@synthesize SearchTextButton            = _SearchTextButton;
@synthesize SearchBackgroundView        = _SearchBackgroundView;
@synthesize HeaderView                  = _HeaderView;
@synthesize RestaurantUniqueId          = _RestaurantUniqueId;

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
    
    [self AddfooterView];
    
    UIButton *AddWaitingList = (UIButton *)[self.view viewWithTag:945];
    [AddWaitingList addTarget:self action:@selector(AddWaitingListToRestaurant) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ShowDirectionButton = (UIButton *)[self.view viewWithTag:77];
    [ShowDirectionButton addTarget:self action:@selector(ShowDirectionToRestaurant) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *Reservetable = (UIButton *)[self.view viewWithTag:79];
    [Reservetable addTarget:self action:@selector(ReserveTableInRestaurant) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    MainBackgroundView = (UIView *)[self.view viewWithTag:777];
    [MainBackgroundView setHidden:YES];
    
    [self startSpin];
    
    @try {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSError *Err = nil;
            NSString *urlString = [NSString stringWithFormat:@"%@GetReataurantDetails?RastaurantUniqueId=%@",API,_RestaurantUniqueId];
            
            NSLog(@"urlString ---- %@",urlString);
            
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *MainData = [[NSData alloc] initWithContentsOfURL:url options:kNilOptions error:&Err];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSError *Err = nil;
                NSMutableDictionary *DataDictioNary = [NSJSONSerialization JSONObjectWithData:MainData options:kNilOptions error:&Err];
                
                if (!Err) {
                    
                    [self stopSpin];
                    
                    if ([[[DataDictioNary objectForKey:@"response"] objectForKey:@"response"] isEqualToString:@"success"]) {
                        
                        TableViewDataDictionary = [[NSMutableArray alloc] init];
                        
                        NSMutableDictionary *DataDic = [DataDictioNary objectForKey:@"consumerdetails"];
                            
                        NSLog(@"DataDic --- %@",DataDic);
                            
                        ALCreateObjectForData *LocalData = [[ALCreateObjectForData alloc] initWithResturantId:[DataDic objectForKey:@"resturant_id"] ResturantAddress:[DataDic objectForKey:@"resturant_address"] ResturantCity:[DataDic objectForKey:@"resturant_city"] ResturantEmail:[DataDic objectForKey:@"resturant_email"] ResturantLogo:[DataDic objectForKey:@"resturant_logo"] ResturantName:[DataDic objectForKey:@"resturant_name"] ResturantPhoneNo:[DataDic objectForKey:@"phone_number"] ResturantState:[DataDic objectForKey:@"restaurant_state"] ResturantZip:[DataDic objectForKey:@"restaurant_zipcode"] ResturantDistance:[DataDic objectForKey:@"resturantDistance"] ResturantAverageWaitTime:[DataDic objectForKey:@"resturantAverageWaitTime"]];
                        
                        UILabel *Reataurantnamelabel = (UILabel *)[MainBackgroundView viewWithTag:73];
                        [Reataurantnamelabel setText:LocalData.ResturantName];
                        
                        UILabel *ReataurantAddressLineOne = (UILabel *)[MainBackgroundView viewWithTag:74];
                        [ReataurantAddressLineOne setText:LocalData.ResturantAddress];
                        
                        UILabel *ReataurantAddressLineTwo = (UILabel *)[MainBackgroundView viewWithTag:75];
                        [ReataurantAddressLineTwo setText:[NSString stringWithFormat:@"%@, %@, USA - %@",LocalData.ResturantState,LocalData.ResturantCity,LocalData.ResturantZip]];
                        
                        UILabel *ReataurantPhone = (UILabel *)[MainBackgroundView viewWithTag:76];
                        [ReataurantPhone setText:[NSString stringWithFormat:@"+1%@",LocalData.ResturantPhoneNo]];
                        
                        UILabel *ReataurantAvgWaittime = (UILabel *)[MainBackgroundView viewWithTag:46];
                        [ReataurantAvgWaittime setText:[NSString stringWithFormat:@"Average wait time : %@",LocalData.ResturantAverageWaitTime]];
                        
                        UIImageView *ResLogoView = (UIImageView *)[MainBackgroundView viewWithTag:72];
                        
                        ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(ResLogoView.layer.frame.origin.x, ResLogoView.layer.frame.origin.y, ResLogoView.layer.frame.size.width, ResLogoView.layer.frame.size.height)];
                        imageView.defaultImage = [UIImage imageNamed:@"logoDL.png"];
                        imageView.imageUrl = LocalData.ResturantLogo;
                        imageView.contentMode = UIViewContentModeScaleAspectFill;
                        imageView.clipsToBounds = YES;
                        imageView.corners = ZSRoundCornerAll;
                        imageView.cornerRadius = 23;
                        [MainBackgroundView addSubview:imageView];
                        
                        [MainBackgroundView setHidden:NO];
                        
                    } else {
                        
                        @throw [NSException exceptionWithName:@"Exception" reason:[NSString stringWithFormat:@"%@",Err] userInfo:nil];
                    }
                } else {
                    
                    @throw [NSException exceptionWithName:@"Exception" reason:[[DataDictioNary objectForKey:@"response"] objectForKey:@"message"] userInfo:nil];
                }
            });
            
        });
    }
    @catch (NSException *exception) {
        
        [self stopSpin];
        
        UIAlertView *DataError = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",exception] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [DataError show];
    }
}

#pragma add waitinglist

-(void)AddWaitingListToRestaurant {
    
    ALAddwaitlistViewController *AddwaitlistView = [[ALAddwaitlistViewController alloc] init];
    [AddwaitlistView setRestaurantId:_RestaurantUniqueId];
    [self GotoDifferentViewWithAnimation:AddwaitlistView];
}

#pragma Reserve Table

-(void)ReserveTableInRestaurant {
    
    ALReserveTableViewController *ReserveTableView = [[ALReserveTableViewController alloc] init];
    [self GotoDifferentViewWithAnimation:ReserveTableView];
}

#pragma ShowMapDirection

-(void)ShowDirectionToRestaurant {
    
    ALMapDirectionViewController *ShowMapDirectionView = [[ALMapDirectionViewController alloc] init];
    [self GotoDifferentViewWithAnimation:ShowMapDirectionView];
}

-(IBAction)HideKeyboard:(id)sender {
    
    [_SearchTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
