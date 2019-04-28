
#ifndef Constant_h
#define Constant_h
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define deviceWidth         ([[UIScreen mainScreen] bounds].size.width)
#define deviceHeight        ([[UIScreen mainScreen] bounds].size.height)

#define STORYBOARD          [UIStoryboard storyboardWithName:@"Main" bundle: nil]

#define IS_IOS_8            [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define IS_IOS_7            [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0

#define userDefaults    [NSUserDefaults standardUserDefaults]

#define NavigationBackground       [UIColor colorWithRed:44/255.0f green:65/255.0f blue:143/255.0f alpha:1.0f]

#define FieldPlaceHolderColor  [UIColor darkGrayColor]
#define constantObj  [[WebserviceClass alloc]init]
#define userDefaults    [NSUserDefaults standardUserDefaults]


#define mainUrl  @"http://truckslogistics.com/Projects-Work/SpeakAme/user/genral_api.php"
#define newMainUrl  @"http://truckslogistics.com/Projects-Work/SpeakAme/user/general_apis_speakMe.php"


//DRAWER CLASESS

#import "CommonSideBarViewController.h"
#import "MJPopupBackgroundView.h"
#import "UIViewController+MJPopupViewController.h"



//All Screens

#import "HomeController.h"
#import "LoginController.h"
#import "SignUpController.h"
#import "MusicLibraryController.h"
#import "YSLContainerViewController.h"
#import "ArtistController.h"
#import "GenersController.h"
#import "AlbumController.h"
#import "SongsController.h"
#import "SongsCollectionViewCell.h"
#import "SelectedSongController.h"
#import "PlayersController.h"
#import "PlayersTableViewCell.h"
#import "PaymentController.h"
#import "PlayersDetailController.h"
#import "MyAccountController.h"
#import "MyAccountTableViewCell.h"
#import "ThankYouController.h"
#import "PaymentProcessingController.h"


#endif /* Constant_h */
