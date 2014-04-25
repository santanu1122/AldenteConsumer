//
//  ALAddwaitlistViewController.m
//  AlDenteConsumer
//
//  Created by Esolz_Mac on 15/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "ALAddwaitlistViewController.h"
#import "ALNibNames.h"
#import "ALAllImages.h"
#import "ALStrings.h"
#import "ALAppServices.h"
#import "ALRedirectViews.h"
#import "ALGlobalAccess.h"
#import "NSString+Extend.h"
#import "ALConstants.h"
#import "ALWaitlistViewController.h"

@interface ALAddwaitlistViewController ()<UITextFieldDelegate,UIAlertViewDelegate>{
    ALGlobalAccess *GlobalAccess;
    ALConstants    *Alconstants;
    UIView *FadelayoutView;
}
@property (retain, nonatomic) UIView *topView;
@property (retain, nonatomic) UIView *bgtopView;
@property (retain, nonatomic) UIView *dataView;
@property (retain, nonatomic) UIView *detailsView;
@property (retain, nonatomic) UILabel *Restaurantname;
@property (retain, nonatomic) UILabel *distance;
@property (retain, nonatomic) UILabel *position;
@property (retain, nonatomic) UILabel *party;
@property (retain, nonatomic) UILabel *size;
@property (retain, nonatomic) UITextField *partysize_txt;
@end

@implementation ALAddwaitlistViewController
@synthesize RestaurantId                    = _RestaurantId;
@synthesize topView                         = _topView;
@synthesize bgtopView                       = _bgtopView;
@synthesize dataView                        = _dataView;
@synthesize detailsView                     = _detailsView;
@synthesize Restaurantname                  = _Restaurantname;
@synthesize distance                        = _distance;
@synthesize position                        = _position;
@synthesize party                           = _party;
@synthesize size                            = _size;
@synthesize partysize_txt                   = _partysize_txt;


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
    
     _topView   = (UIView *)[self.view viewWithTag:123];
    _bgtopView   = (UIView *)[_topView viewWithTag:109];
    [_bgtopView.layer setOpacity:0.2f];
    
    _detailsView   = (UIView *)[self.view viewWithTag:120];
   _detailsView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.png"]];
    
    _dataView   = (UIView *)[self.view viewWithTag:121];
   _dataView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"row1.png"]];
    
    _Restaurantname=(UILabel *)[_dataView viewWithTag:111];
    _Restaurantname.font=[UIFont fontWithName:ALAppServices.AFFontSemibold size:16.0f];
    
    _distance=(UILabel *)[_dataView viewWithTag:112];
    _distance.font=[UIFont fontWithName:ALAppServices.AFFontLight size:13.0f];
    
    _distance=(UILabel *)[_dataView viewWithTag:114];
    _distance.font=[UIFont fontWithName:ALAppServices.AFFontLight size:13.0f];
    
    _party=(UILabel *)[_detailsView viewWithTag:117];
    _party.font=[UIFont fontWithName:ALAppServices.AFFontRegular size:20.0f];
    
    _size=(UILabel *)[_detailsView viewWithTag:122];
    _size.font=[UIFont fontWithName:ALAppServices.AFFontLight size:20.0f];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 38)];
    _partysize_txt=(UITextField *)[_detailsView viewWithTag:118];
    _partysize_txt.leftView = paddingView;
    _partysize_txt.leftViewMode = UITextFieldViewModeAlways;
    _partysize_txt.font=[UIFont fontWithName:ALAppServices.AFFontRegular  size:14.0f];
    _partysize_txt.delegate=self;
    
    UIButton *AddtoWaitListButton = (UIButton *)[self.view viewWithTag:119];
    [AddtoWaitListButton addTarget:self action:@selector(AddtoWaitList:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
}
-(IBAction)AddtoWaitList:(id)sender {
    
    BOOL Is_validate = YES;
    
    if (![Alconstants CleanTextField:_partysize_txt.text].length > 0) {
        
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Partysize can't be blank" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        Is_validate = NO;
    }
    
    if (Is_validate) {
        
        [self.view endEditing:YES];
        
        FadelayoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 390)];
        [FadelayoutView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:FadelayoutView];
        [self.view bringSubviewToFront:FadelayoutView];
        
        [self startSpin];
        
        @try {
            
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString *StringData = [NSString stringWithFormat:@"%@ConsumerAddToWaitList?LogedinConsumerId=%@&PartySize=%@&RestaurantId=%@",API,[NSString stringWithFormat:@"%@",[self GetLoginUserId]],[[Alconstants CleanTextField:_partysize_txt.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[NSString stringWithFormat:@"%@",_RestaurantId]];
            
            NSLog(@"StringData --- %@",StringData);
            
            NSData *dataFromContainingUrl = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:StringData]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self stopSpin];
                
                NSDictionary *getArray=[NSJSONSerialization JSONObjectWithData:dataFromContainingUrl options:kNilOptions error:nil];
                
                NSLog(@"getArray --- %@",getArray);
                
                if ([[getArray objectForKey:@"response"] isEqualToString:@"error"]) {
                    
                    UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[getArray objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [AlertView setTag:121];
                    [FadelayoutView removeFromSuperview];
                    [AlertView show];
                    
                } else {
                    
                    UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"Success" message:[getArray objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [AlertView setTag:122];
                    [FadelayoutView removeFromSuperview];
                    [AlertView show];
                }
            });
            
        });
         }
        @catch (NSException *Exception) {
            NSLog(@"Exception --- %@",[NSString stringWithFormat:@"%@",Exception]);
        }
    }
}
- (void)keyboardWillShow:(NSNotification *)note {
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setImage:[UIImage imageNamed:@"Doneup.png"] forState:UIControlStateNormal];
    [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(doneButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *keyboardView = [[[[[UIApplication sharedApplication] windows] lastObject] subviews] firstObject];
            [doneButton setFrame:CGRectMake(0, keyboardView.frame.size.height - 53, 104, 53)];
            [keyboardView addSubview:doneButton];
            [keyboardView bringSubviewToFront:doneButton];
            
            [UIView animateWithDuration:[[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]-.02
                                  delay:.0
                                options:[[note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]
                             animations:^{
                                 self.view.frame = CGRectOffset(self.view.frame, 0, 0);
                             } completion:nil];
        });
    }else {
        // locate keyboard view
        dispatch_async(dispatch_get_main_queue(), ^{
            UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
            UIView* keyboard;
            for(int i=0; i<[tempWindow.subviews count]; i++) {
                keyboard = [tempWindow.subviews objectAtIndex:i];
                // keyboard view found; add the custom button to it
                if([[keyboard description] hasPrefix:@"UIKeyboard"] == YES)
                    [keyboard addSubview:doneButton];
            }
        });
    }
}
- (void)doneButtonDidPressed:(id)sender {
    [_partysize_txt resignFirstResponder];
}
-(IBAction)performBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 122) {
        ALWaitlistViewController *WaitlistView = [[ALWaitlistViewController alloc] init];
        [self GotoDifferentViewWithAnimation:WaitlistView];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
