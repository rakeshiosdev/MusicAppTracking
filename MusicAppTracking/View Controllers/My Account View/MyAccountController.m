//
//  MyAccountController.m
//  MusicAppTracking
//
//  Created by MMF on 20/12/1938 Saka.
//  Copyright © 1938 Saka MMF. All rights reserved.
//

#import "MyAccountController.h"
#import "Constant.h"

@interface MyAccountController () <UITableViewDelegate,UITableViewDataSource>

#pragma mark IBOUTLET :

@property (weak, nonatomic) IBOutlet UIButton *btnMyTracks;
@property (weak, nonatomic) IBOutlet UIButton *btnProfile;

@end

@implementation MyAccountController

#pragma mark IBOUTLET :

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
    
    self.navigationItem.title=@"My Account";
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"Backnavigate_icon"] forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0,0,22,22);
    [backButton addTarget:self action:@selector(methodForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navBackBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=navBackBtn;
    
}

-(void)methodForBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableview DataSource Methods :

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark Action Methods :

- (IBAction)actionTrack:(id)sender {
    _btnMyTracks.backgroundColor = [UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1];
     _btnProfile.backgroundColor = [UIColor whiteColor];
}
- (IBAction)actionProfile:(id)sender {
     _btnProfile.backgroundColor = [UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1];
     _btnMyTracks.backgroundColor = [UIColor whiteColor];
}
@end
