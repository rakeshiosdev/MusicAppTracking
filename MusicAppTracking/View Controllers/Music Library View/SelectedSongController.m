//
//  SelectedSongController.m
//  MusicAppTracking
//
//  Created by MMF on 19/12/1938 Saka.
//  Copyright © 1938 Saka MMF. All rights reserved.
//

#import "SelectedSongController.h"

@interface SelectedSongController ()

{
    UIView *root;
}



@end

@implementation SelectedSongController

#pragma mark View Life Cycle :

- (void)viewDidLoad {
    [super viewDidLoad];
    root = [[[NSBundle mainBundle] loadNibNamed:@"Notify_View" owner:self options:nil] objectAtIndex:0];
    root.hidden=YES;

    NSLog(@"%@",_stringimg);
   
    _img_SelectedSong.image =[UIImage imageNamed:_stringimg];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self methodForNavigation];
}

-(void)methodForNavigation {
    
    self.navigationItem.title=@"";
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
    [rightButtontwo setImage:[UIImage imageNamed:@"Star_icon"] forState:UIControlStateNormal];
    rightButtontwo.frame = CGRectMake(0, 0, 22, 22);
    [rightButtontwo addTarget:self action:@selector(methodStar) forControlEvents:UIControlEventTouchUpInside];
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

-(void)methodStar{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
