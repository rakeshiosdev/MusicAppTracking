//
//  PlayersController.m
//  MusicAppTracking
//
//  Created by MMF on 19/12/1938 Saka.
//  Copyright © 1938 Saka MMF. All rights reserved.
//

#import "PlayersController.h"
#import "Constant.h"

@interface PlayersController ()  <UITableViewDelegate,UITableViewDataSource>
{
    UIView *root;
}
@end

@implementation PlayersController

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
}

-(void)methodForNavigation {
    
    self.navigationItem.title=@"Players";
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"Backnavigate_icon"] forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0,0,22,22);
    [backButton addTarget:self action:@selector(methodForBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navBackBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=navBackBtn;
    
    UIButton *rightButtonone = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButtonone setImage:[UIImage imageNamed:@"Notify_icon"] forState:UIControlStateNormal];
    rightButtonone.frame = CGRectMake(0, 0, 22, 22);
    [rightButtonone addTarget:self action:@selector(methodNotify) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navRight = [[UIBarButtonItem alloc] initWithCustomView:rightButtonone];
    
    UIButton *rightButtontwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButtontwo setImage:[UIImage imageNamed:@"Search_icon"] forState:UIControlStateNormal];
    rightButtontwo.frame = CGRectMake(0, 0, 22, 22);
    [rightButtontwo addTarget:self action:@selector(methodSearch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navRighttwo = [[UIBarButtonItem alloc] initWithCustomView:rightButtontwo];
    
    self.navigationItem.rightBarButtonItems = @[navRight,navRighttwo];
}

-(void)methodForBack{
   [self.navigationController popViewControllerAnimated:YES];
}

-(void)methodNotify{
    if (root.hidden == YES) {
        root.frame = CGRectMake(220, 80, 150, 120);
        root.hidden=NO;
        [self.view addSubview:root];
    }
    
    else if (root.hidden == NO){
        root.hidden=YES;
    }

}

-(void)methodSearch{
    
}


-(void)doBuy{
    PaymentController *payment = [self.storyboard instantiateViewControllerWithIdentifier:@"PaymentController"];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:payment animated:YES];
}

#pragma mark UITableview Data Source Methods :

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.view_Content.layer.masksToBounds = NO;
    cell.view_Content.layer.backgroundColor = [UIColor whiteColor].CGColor;
    cell.view_Content.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    cell.view_Content.layer.shadowOpacity = 10.0;
    
    cell.lbl_Track.text = @"Players Text";
    cell.lbl_Trackname.text = @"Unknown Track";
    
    cell.btnBuy.layer.borderWidth = 1.0;
    cell.btnBuy.layer.borderColor = [UIColor blackColor].CGColor;
    
    cell.btnBuy.tag = indexPath.row;
    [cell.btnBuy addTarget:self action:@selector(doBuy) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayersDetailController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"PlayersDetailController"];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:detail animated:YES];
}
@end
