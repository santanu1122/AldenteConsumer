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
#import "ALReservationCell.h"

@interface ALReservationsViewController ()<UITextFieldDelegate, UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate> {
    
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    NSMutableArray *TableViewDataDictionary;
    UITapGestureRecognizer *tapGesture;
}

@property (retain, nonatomic) UITextField *SearchTextField;
@property (retain, nonatomic) UIButton *SearchTextButton;
@property (retain, nonatomic) UIView *SearchBackgroundView;
@property (retain, nonatomic) IBOutlet UIView *HeaderView;
@property (retain, nonatomic) IBOutlet UITableView *UITableView;
@end

@implementation ALReservationsViewController
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
    [super viewDidLoad];
    [self AddfooterView:3];
    
    GlobalAccess = [[ALGlobalAccess alloc] init];
    Alconstants  = [[ALConstants alloc] init];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    _SearchTextField       = [GlobalAccess GenerateTextFieldForAcess:111 Delegate:self TextFiledtextColor:[UIColor whiteColor] TextFieldsetFontSize:15.0f TextFieldFont:ALAppServices.AFFontRegular GlobalView:self.view PlaceholderText:@"Search by Restaurants or location"];
    [_SearchTextField setDelegate:self];
    
    _SearchBackgroundView   = (UIView *)[self.view viewWithTag:109];
    [_SearchBackgroundView.layer setOpacity:0.2f];
    [_HeaderView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_HeaderView.layer setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    
    [_UITableView setDelegate:self];
    [_UITableView setDataSource:self];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
}

-(void)GetAllReservationListForUser {
    
    [self startSpin];
    [_UITableView setHidden:YES];
    
//    @try {
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            
//            NSError *Err = nil;
//            
//            NSString *urlString = [NSString stringWithFormat:@"%@GetAllResrvationList?LogedinConsumerId=%@&UserCurrentLatitude=%@&UserCurrentLongitude",API,[NSString stringWithFormat:@"%@",[self GetLoginUserId]],@"0.00000",@"0.00000"];
//            NSLog(@"urlString ---%@",urlString);
//            NSURL *url = [NSURL URLWithString:urlString];
//            NSData *MainData = [[NSData alloc] initWithContentsOfURL:url options:kNilOptions error:&Err];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                NSError *Err = nil;
//                NSMutableDictionary *DataDictioNary = [NSJSONSerialization JSONObjectWithData:MainData options:kNilOptions error:&Err];
//                
//                @try {
//                    
//                    if (!Err) {
//                        
//                        if ([[[DataDictioNary objectForKey:@"response"] objectForKey:@"response"] isEqualToString:@"success"]) {
//                            
//                            TableViewDataDictionary = [[NSMutableArray alloc] init];
//                            
//                            for (NSMutableDictionary *DataDic in [DataDictioNary objectForKey:@"consumerdetails"]) {
//                                
//                                [TableViewDataDictionary addObject:[[ALCreateObjectForData alloc] initWithResturantId:[DataDic objectForKey:@"resturant_id"] ResturantAddress:[DataDic objectForKey:@"resturant_address"] ResturantCity:[DataDic objectForKey:@"resturant_city"] ResturantEmail:[DataDic objectForKey:@"resturant_email"] ResturantLogo:[DataDic objectForKey:@"resturant_logo"] ResturantName:[DataDic objectForKey:@"resturant_name"] ResturantPhoneNo:[DataDic objectForKey:@"phone_number"] ResturantState:[DataDic objectForKey:@"restaurant_state"] ResturantZip:[DataDic objectForKey:@"restaurant_zipcode"] ResturantDistance:[DataDic objectForKey:@"resturantDistance"] ResturantAverageWaitTime:[DataDic objectForKey:@"resturantAverageWaitTime"]]];
//                            }
//                            [self stopSpin];
//                            [_UITableView setHidden:NO];
//                            [_UITableView reloadData];
//                            
//                        } else {
//                            
//                            NSException *theException = [NSException exceptionWithName:NSInvalidArgumentException reason:@"Some error just occurred!" userInfo:nil];
//                            NSLog(@"exception1 ---- %@",theException);
//                            @throw theException;
//                        }
//                    } else {
//                        NSException *theException = [NSException exceptionWithName:NSInvalidArgumentException reason:@"Some error just occurred!" userInfo:nil];
//                        NSLog(@"exception2 ---- %@",theException);
//                        @throw theException;
//                    }
//                }
//                @catch (NSException *Exception) {
//                    
//                    [self stopSpin];
//                    NSLog(@"exception3 ---- %@",Exception);
//                    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",Exception] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
//                    [Alert setTag:121];
//                    [Alert show];
//                }
//            });
//            
//        });
//    }
//    @catch (NSException *exception) {
//        
//        [self stopSpin];
//        NSLog(@"exception ---- %@",exception);
//        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",exception] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
//        [Alert setTag:122];
//        [Alert show];
//    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma tableview details

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *TableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 39.0f)];
    [TableHeaderView.layer setShadowColor:[UIColor blackColor].CGColor];
    [TableHeaderView.layer setShadowOffset:CGSizeMake(0.0f, 0.9f)];
    [TableHeaderView setBackgroundColor:[UIColor clearColor]];
    
    UIView *TableHeaderBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 39.0f)];
    [TableHeaderBackView.layer setOpacity:0.2f];
    [TableHeaderBackView setBackgroundColor:[UIColor whiteColor]];
    [TableHeaderView addSubview:TableHeaderBackView];
    
    UILabel *TableviewDetails = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 20)];
    [TableviewDetails setText:@"Reservations"];
    [TableHeaderView addSubview:TableviewDetails];
    [TableviewDetails setTextAlignment:NSTextAlignmentCenter];
    [TableviewDetails setTextColor:[UIColor whiteColor]];
    [TableviewDetails setFont:[UIFont fontWithName:ALAppServices.AFFontSecondSemiBold size:22]];
    
    return TableHeaderView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ALReservationCell";
    ALReservationCell *cell = (ALReservationCell *)[_UITableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (ALReservationCell *)[nibArray objectAtIndex:0];
    }
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"row-bgwaitinglist"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    cell.selectedBackgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"row-bgwaitinglist"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    
    return cell;
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
}

@end
