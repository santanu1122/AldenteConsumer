//
//  ALMapDirectionViewController.h
//  AlDenteConsumer
//
//  Created by Iphone_2 on 16/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

typedef enum
{
    RestaurantDetailsView = 1,
    WaitingListView
    
} LastVisitedView;

#import <UIKit/UIKit.h>
#import "ALGlobalViewController.h"
@interface ALMapDirectionViewController : ALGlobalViewController

@property (assign) LastVisitedView LastVisitedView;
@property (nonatomic,retain) NSString *RastaurantUniqueId;

@end
