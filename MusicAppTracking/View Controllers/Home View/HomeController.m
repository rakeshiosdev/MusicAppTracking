//
//  HomeController.m
//  MusicAppTracking
//
//  Created by MMF on 18/12/1938 Saka.
//  Copyright © 1938 Saka MMF. All rights reserved.
//

#import "HomeController.h"
#import "Constant.h"

@interface HomeController ()

@end

@implementation HomeController

#pragma mark View Life Cycle :

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self methodForNavigation];
}

-(void)methodForNavigation {
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

#pragma mark Action Methods :

- (IBAction)actionPlay_now:(id)sender {
    MusicLibraryController *lib = [self.storyboard instantiateViewControllerWithIdentifier:@"MusicLibraryController"];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:lib animated:YES];
}

- (IBAction)actionLogin:(id)sender {
    LoginController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:login animated:YES];
}

- (IBAction)actionSignUp:(id)sender {
    SignUpController *signup = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpController"];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:signup animated:YES];
}


@end
