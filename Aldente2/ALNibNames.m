//
//  ALNibNames.m
//  Aldente2
//
//  Created by Iphone_2 on 04/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALNibNames.h"
#import "ALConstants.h"

// Screen after app launch

NSString * const MainScreenIphoneFive                      = @"ALViewController";
NSString * const MainScreenIphoneFour                      = @"ALViewController_small";

// Login Screen

NSString * const LoginScreenIphoneFive                     = @"ALLoginMethodsViewController";
NSString * const LoginScreenIphoneFour                     = @"ALLoginMethodsViewController_small";

// Lost password screen

NSString * const LostPasswordScreenIphoneFive              = @"ALLostPasswordViewController";
NSString * const LostPasswordScreenIphoneFour              = @"ALLostPasswordViewController_small";

// Registration screen

NSString * const RegistrationScreenIphoneFive              = @"ALRegistrationViewController";
NSString * const RegistrationScreenIphoneFour              = @"ALRegistrationViewController_small";

// Social Registration Middle screen

NSString * const SocialRegistrationMiddleScreenIphoneFive  = @"ALSocialRegistrationViewController";
NSString * const SocialRegistrationMiddleScreenIphoneFour  = @"ALSocialRegistrationViewController_small";

// Landing screen

NSString * const LandingScreenIphoneFive                    = @"ALLandingViewController";
NSString * const LandingScreenIphoneFour                    = @"ALLandingViewController_small";

// Restaurant Listing Screen

NSString * const RestaurantListingFive                      = @"ALAllRestaurantListViewController";
NSString * const RestaurantListingFour                      = @"ALAllRestaurantListViewController_small";

// Rastaurant Deatils Screen

NSString * const RestaurantDetailsFive                      = @"ALRestaurantDetailsViewController";
NSString * const RestaurantDetailsFour                      = @"ALRestaurantDetailsViewController_small";

// Reserve Table Screen

NSString * const ReserveTableFive                           = @"ALReserveTableViewController";
NSString * const ReserveTableFour                           = @"ALReserveTableViewController_small";

// All Waitinglist Screen

NSString * const WaitingListFive                            = @"ALWaitlistViewController";
NSString * const WaitingListFour                            = @"ALWaitlistViewController_small";

// Add to Waitinglist Screen

NSString * const AddtoWaitingListFive                       = @"ALAddwaitlistViewController";
NSString * const AddtoWaitingListFour                       = @"ALAddwaitlistViewController_small";

// Map Direction Screen

NSString * const MapDirectionViewFive                       = @"ALMapDirectionViewController";
NSString * const MapDirectionViewFour                       = @"ALMapDirectionViewController_small";

// Reservation Listing Screen

NSString * const ReservationListingFive                     = @"ALReservationsViewController";
NSString * const ReservationListingFour                     = @"ALReservationsViewController_small";

// Reservation Details Screen

NSString * const ReservationDetailsFive                     = @"ALReservationDetailsViewController";
NSString * const ReservationDetailsFour                     = @"ALReservationDetailsViewController_small";

// Coupon Listing Screen

NSString * const CouponsListingFive                         = @"ALCouponsViewController";
NSString * const CouponsListingFour                         = @"ALCouponsViewController_small";

// Coupon Details Screen

NSString * const CouponDetailsFive                          = @"ALCouponDetailsViewController";
NSString * const CouponDetailsFour                          = @"ALCouponDetailsViewController_small";

// More View Screen

NSString * const MoreViewListingFive                        = @"ALMoreViewController";
NSString * const MoreViewListingFour                        = @"ALMoreViewController_small";

// Survey Listing Screen

NSString * const SurveyListingFive                          = @"ALSurveysViewController";
NSString * const SurveyListingFour                          = @"ALSurveysViewController_small";

// Survey Details Screen

NSString * const SurveyDetailsFive                          = @"ALSurveyDetailsViewController";
NSString * const SurveyDetailsFour                          = @"ALSurveyDetailsViewController_small";

// MyAccount Screen

NSString * const EditProfileFive                            = @"ALEditProfileViewController";
NSString * const EditProfileFour                            = @"ALEditProfileViewController_small";

// Terms and services Screen

NSString * const TermsOfServicesFive                        = @"ALTermsandServicesViewController";
NSString * const TermsOfServicesFour                        = @"ALTermsandServicesViewController_small";

// PrivacyPolicy Screen

NSString * const PrivacyPolicyFive                          = @"ALPrivacyPolicyViewController";
NSString * const PrivacyPolicyFour                          = @"ALPrivacyPolicyViewController_small";


@implementation ALNibNames

+(NSString *)MainViewScreen { return (ALConstants.DeviceIsIphoneFive)?MainScreenIphoneFive:MainScreenIphoneFour; }

+(NSString *)LoginViewScreen { return (ALConstants.DeviceIsIphoneFive)?LoginScreenIphoneFive:LoginScreenIphoneFour; }

+(NSString *)LostPasswordViewScreen { return (ALConstants.DeviceIsIphoneFive)?LostPasswordScreenIphoneFive:LostPasswordScreenIphoneFour; }

+(NSString *)RegistrationViewScreen { return (ALConstants.DeviceIsIphoneFive)?RegistrationScreenIphoneFive:RegistrationScreenIphoneFour; }

+(NSString *)SocialRegistrationMiddleViewScreen { return (ALConstants.DeviceIsIphoneFive)?SocialRegistrationMiddleScreenIphoneFive:SocialRegistrationMiddleScreenIphoneFour; }

+(NSString *)landingViewScreen { return (ALConstants.DeviceIsIphoneFive)?LandingScreenIphoneFive:LandingScreenIphoneFour; }

+(NSString *)RastaurentListingScreen { return (ALConstants.DeviceIsIphoneFive)?RestaurantListingFive:RestaurantListingFour; }

+(NSString *)RastaurentDetailsScreen { return (ALConstants.DeviceIsIphoneFive)?RestaurantDetailsFive:RestaurantDetailsFour; }

+(NSString *)ReservetableScreen { return (ALConstants.DeviceIsIphoneFive)?ReserveTableFive:ReserveTableFour; }

+(NSString *)WaitingListScreen { return (ALConstants.DeviceIsIphoneFive)?WaitingListFive:WaitingListFour; }

+(NSString *)AddtoWaitingListScreen {return (ALConstants.DeviceIsIphoneFive)?AddtoWaitingListFive:AddtoWaitingListFour; }

+(NSString *)MapDirectionViewScreenScreen { return (ALConstants.DeviceIsIphoneFive)?MapDirectionViewFive:MapDirectionViewFour; }

+(NSString *)ReservationListingScreen { return (ALConstants.DeviceIsIphoneFive)?ReservationListingFive:ReservationListingFour; }

+(NSString *)ReservationdetailsScreen { return (ALConstants.DeviceIsIphoneFive)?ReservationDetailsFive:ReservationDetailsFour; }

+(NSString *)CouponsListingScreen { return (ALConstants.DeviceIsIphoneFive)?CouponsListingFive:CouponsListingFour; }

+(NSString *)CouponDetailsScreen { return (ALConstants.DeviceIsIphoneFive)?CouponDetailsFive:CouponDetailsFour; }

+(NSString *)MoreViewListingScreen { return (ALConstants.DeviceIsIphoneFive)?MoreViewListingFive:MoreViewListingFour; }

+(NSString *)SurveysListingScreen { return (ALConstants.DeviceIsIphoneFive)?SurveyListingFive:SurveyListingFour; }

+(NSString *)SurveyDetailsScreen { return (ALConstants.DeviceIsIphoneFive)?SurveyDetailsFive:SurveyDetailsFour; }

+(NSString *)MyAccountScreen { return (ALConstants.DeviceIsIphoneFive)?EditProfileFive:EditProfileFour; }

+(NSString *)TermsOfServicesScreen { return (ALConstants.DeviceIsIphoneFive)?TermsOfServicesFive:TermsOfServicesFour; }

+(NSString *)PrivacyPolicyScreen { return (ALConstants.DeviceIsIphoneFive)?PrivacyPolicyFive:PrivacyPolicyFour; }

@end
