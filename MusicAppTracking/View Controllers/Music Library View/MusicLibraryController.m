//
//  MusicLibraryController.m
//  MusicAppTracking
//
//  Created by MMF on 19/12/1938 Saka.
//  Copyright © 1938 Saka MMF. All rights reserved.
//

#import "MusicLibraryController.h"
#import "Constant.h"

@interface MusicLibraryController ()
{
    UIView *root;
}

@end

@implementation MusicLibraryController

#pragma mark View Life Cycle :

- (void)viewDidLoad {
    [super viewDidLoad];
   root = [[[NSBundle mainBundle] loadNibNamed:@"Notify_View" owner:self options:nil] objectAtIndex:0];
    root.hidden=YES;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self methodForNavigation];
    [self initialConfig];
}

-(void)initialConfig{
   
    SongsController *OrderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SongsController"];
    // [self.navigationController pushViewController:OrderVC animated:YES];
    OrderVC.title = @"Songs";
    
    
    AlbumController *CustomizationVC =[self.storyboard instantiateViewControllerWithIdentifier:@"AlbumController"];
    CustomizationVC.title = @"Albums";
    
    ArtistController *OrderTypeVC1 = [[ArtistController alloc] init];
    OrderTypeVC1.title = @"Artist";
    
    GenersController  *StatusVC2 = [[GenersController alloc] init];
    StatusVC2.title = @"Geners";
    
    
    
    // ContainerView
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[OrderVC,CustomizationVC,OrderTypeVC1,StatusVC2]topBarHeight:statusHeight + navigationHeight+10 parentViewController:self];
    
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    
    [self.view addSubview:containerVC.view];
}

-(void)methodForNavigation {
   
    
    self.navigationItem.title=@"Music Library";
    [self.navigationController.navigationBar
    setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"Toggle_icon"] forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0,0,22,22);
    [backButton addTarget:self action:@selector(methodForToggle) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navBackBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=navBackBtn;
    
    UIButton *rightButtonone = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButtonone setImage:[UIImage imageNamed:@"Notify_icon"] forState:UIControlStateNormal];
    rightButtonone.frame = CGRectMake(0, 0, 22, 22);
    [rightButtonone addTarget:self action:@selector(methodNotify:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navRight = [[UIBarButtonItem alloc] initWithCustomView:rightButtonone];
    
    UIButton *rightButtontwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButtontwo setImage:[UIImage imageNamed:@"Search_icon"] forState:UIControlStateNormal];
    rightButtontwo.frame = CGRectMake(0, 0, 22, 22);
    [rightButtontwo addTarget:self action:@selector(methodSearch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navRighttwo = [[UIBarButtonItem alloc] initWithCustomView:rightButtontwo];
    
    self.navigationItem.rightBarButtonItems = @[navRight,navRighttwo];
}

-(void)methodForToggle{
    CommonSideBarViewController *objCommonSideBarViewController = [[CommonSideBarViewController alloc] initWithNibName:@"CommonSideBarViewController" bundle:nil];
    [[NSUserDefaults standardUserDefaults]setValue:@"commonPopup" forKey:@"session_checkforAutoHeightnWidth"];
    objCommonSideBarViewController.delegate = (id)self;
    [self presentPopupViewController:objCommonSideBarViewController animationType:MJPopupViewAnimationSlideLeftRight];
}

- (void)menuForBusiness:(CommonSideBarViewController*)businessController secondParam:(int)intGetTextId
{
    
    if(intGetTextId==100)
    {
        NSLog(@"Home");
        HomeController *home = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeController"];
        [self.navigationController setNavigationBarHidden:NO];
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideRightLeft];
        [self.navigationController pushViewController:home animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if(intGetTextId==200)
    {
        NSLog(@"My Playlist");
        
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideRightLeft];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if(intGetTextId==300)
    {
        NSLog(@"My Account");
        MyAccountController *account = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAccountController"];
        [self.navigationController setNavigationBarHidden:NO];
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideRightLeft];
        [self.navigationController pushViewController:account animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    else if(intGetTextId==400)
    {
        NSLog(@"Players");
        PlayersController *players = [self.storyboard instantiateViewControllerWithIdentifier:@"PlayersController"];
        [self.navigationController setNavigationBarHidden:NO];
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideRightLeft];
        [self.navigationController pushViewController:players animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    else if(intGetTextId==500)
    {
        NSLog(@"Music");
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideRightLeft];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    else if(intGetTextId==600)
    {
        NSLog(@"Settings");
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideRightLeft];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

-(void)methodNotify:(id)sender{
        if (root.hidden == YES) {
        root.frame = CGRectMake(225, 65, 150, 120);
        root.hidden=NO;
      
        [self.view addSubview:root];
           
    }
    
    else if (root.hidden == NO){
        root.hidden=YES;
    }
    
}
-(void)methodSearch{
   
}

#pragma mark -- YSLContainerViewControllerDelegate

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //    NSLog(@"current Index : %ld",(long)index);
    //    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}

@end
