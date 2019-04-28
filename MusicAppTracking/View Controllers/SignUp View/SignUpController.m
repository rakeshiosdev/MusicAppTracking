//
//  SignUpController.m
//  MusicAppTracking
//
//  Created by MMF on 18/12/1938 Saka.
//  Copyright © 1938 Saka MMF. All rights reserved.
//

#import "SignUpController.h"
#import "Constant.h"
#import "UITextField+PendingTextFieldWithImage.h"

@interface SignUpController ()

#pragma mark IBOUTLET :

@property (weak, nonatomic) IBOutlet UIButton *btnRegisterNow;
@property (weak, nonatomic) IBOutlet UITextField *TfName;
@property (weak, nonatomic) IBOutlet UITextField *TfEmail;
@property (weak, nonatomic) IBOutlet UITextField *TfMobile;
@property (weak, nonatomic) IBOutlet UITextField *TfPassword;
@property (weak, nonatomic) IBOutlet UITextField *TfConfirmPassword;

@end

@implementation SignUpController

#pragma mark View Life Cycle :

- (void)viewDidLoad {
    [super viewDidLoad];
    [_TfName leftMargin:10 and:10];
    [_TfEmail leftMargin:10 and:10];
    [_TfMobile leftMargin:10 and:10];
    [_TfPassword leftMargin:10 and:10];
    [_TfConfirmPassword leftMargin:10 and:10];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self methodForNavigation];
    [self decorateUI];
}

#pragma mark Custom Methods :

-(void)methodForNavigation {
     
   // [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    
    //[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.title=@"SIGN UP";
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"Cross_icon"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0,0,22,22);
    [backButton addTarget:self action:@selector(methodForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navBackBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=navBackBtn;
    
}

-(void)methodForBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)decorateUI{
    _btnRegisterNow.layer.borderWidth = 2.0f;
    _btnRegisterNow.layer.borderColor = [UIColor colorWithRed:191/255.0 green:255/255.0 blue:0/255.0 alpha:1].CGColor;
    
}

#pragma mark Action Method :

- (IBAction)actionRegisterNow:(id)sender {
    MusicLibraryController *music = [self.storyboard instantiateViewControllerWithIdentifier:@"MusicLibraryController"];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:music animated:YES];
}

@end
