

#import "CommonSideBarViewController.h"
#import "Constant.h"

@interface CommonSideBarViewController ()
@end

@implementation CommonSideBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [_btnHome addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_btnMyPlaylist addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_btnAccount addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_btnPlayers addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_btnMusic addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_btnSettings addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)btnClickEvent:(UIButton*)sender
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(menuForBusiness:secondParam:)])
    {
        [self.delegate menuForBusiness:self secondParam:sender.tag];
    }
}
@end








































