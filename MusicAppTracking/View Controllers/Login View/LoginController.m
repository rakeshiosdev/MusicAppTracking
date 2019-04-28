//
//  LoginController.m
//  MusicAppTracking
//
//  Created by MMF on 18/12/1938 Saka.
//  Copyright © 1938 Saka MMF. All rights reserved.
//

#import "LoginController.h"
#import "Constant.h"
#import "UITextField+PendingTextFieldWithImage.h"

@interface LoginController ()

#pragma mark IBOUTLET 

@property (weak, nonatomic) IBOutlet UITextField *TfUsername;
@property (weak, nonatomic) IBOutlet UITextField *TfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername_placeholder;
@property (weak, nonatomic) IBOutlet UILabel *lblPassword_placeholder;

@end

@implementation LoginController


#pragma mark View Life Cycle :

- (void)viewDidLoad {
    [super viewDidLoad];
    [_TfPassword leftMargin:40 and:40];
    [_TfUsername leftMargin:40 and:40];

    
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
    
   // [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.title=@"LOGIN";
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
    _btnLogin.layer.borderWidth = 2.0f;
    _btnLogin.layer.borderColor = [UIColor colorWithRed:191/255.0 green:255/255.0 blue:0/255.0 alpha:1].CGColor;
    
    _TfPassword.textAlignment = NSTextAlignmentLeft;
    _TfUsername.textAlignment = NSTextAlignmentLeft;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _TfUsername) {
        _lblUsername_placeholder.hidden = YES;
    }
    if (textField == _TfPassword) {
      _lblPassword_placeholder.hidden = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _TfUsername) {
        _lblUsername_placeholder.hidden = NO;
        
    }
    if (textField == _TfPassword) {
        _lblPassword_placeholder.hidden = NO;
    }

}

#pragma mark Action Methods :

- (IBAction)actionLoginNow:(id)sender {
    MusicLibraryController *lib = [self.storyboard instantiateViewControllerWithIdentifier:@"MusicLibraryController"];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:lib animated:YES];
}

- (IBAction)actionCreateAccount:(id)sender {
    SignUpController *signup = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpController"];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:signup animated:YES];
}


@end
