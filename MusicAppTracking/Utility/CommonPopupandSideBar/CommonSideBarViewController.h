//
//  CommonSideBarViewController.h
//  MinkBox
//
//  Created by mmf on 9/3/15.
//  Copyright (c) 2015 mmfinfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"


@protocol MJSecondPopupDelegate;
@interface CommonSideBarViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
@property (weak, nonatomic) IBOutlet UIButton *btnMyPlaylist;
@property (weak, nonatomic) IBOutlet UIButton *btnAccount;
@property (weak, nonatomic) IBOutlet UIButton *btnPlayers;
@property (weak, nonatomic) IBOutlet UIButton *btnMusic;

@property (weak, nonatomic) IBOutlet UIButton *btnSettings;



@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;
@end

@protocol MJSecondPopupDelegate<NSObject>
@optional

- (void)menuForBusiness:(CommonSideBarViewController*)businessController secondParam:(int)intGetTextId;

@end
