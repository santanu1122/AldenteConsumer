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
#import "ALCouponCell.h"

@interface ALCouponsViewController ()<UITextFieldDelegate, UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate> {
    
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UITapGestureRecognizer *tapGesture;
}

@property (retain, nonatomic) UITextField *SearchTextField;
@property (retain, nonatomic) UIButton *SearchTextButton;
@property (retain, nonatomic) UIView *SearchBackgroundView;
@property (retain, nonatomic) IBOutlet UIView *HeaderView;
@property (retain, nonatomic) IBOutlet UITableView *UITableView;
@end

@implementation ALCouponsViewController
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
    [self AddfooterView];
    
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
    
    UIImageView *touchedImageView = (UIImageView *)[AllCouponsListView viewWithTag:11];
    [touchedImageView setImage:[UIImage imageNamed:@"icon4ON.png"]];
    
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
    
    UILabel *TableviewDetails = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [TableviewDetails setText:@"Coupons"];
    [TableHeaderView addSubview:TableviewDetails];
    [TableviewDetails setTextAlignment:NSTextAlignmentCenter];
    [TableviewDetails setTextColor:[UIColor whiteColor]];
    [TableviewDetails setFont:[UIFont fontWithName:ALAppServices.AFFontSecondSemiBold size:22]];
    
    return TableHeaderView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ALCouponCell";
    ALCouponCell *cell = (ALCouponCell *)[_UITableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (ALCouponCell *)[nibArray objectAtIndex:0];
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
