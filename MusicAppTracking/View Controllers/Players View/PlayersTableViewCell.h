//
//  PlayersTableViewCell.h
//  MusicAppTracking
//
//  Created by MMF on 20/12/1938 Saka.
//  Copyright © 1938 Saka MMF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;
@property (weak, nonatomic) IBOutlet UIView *view_Content;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Trackname;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Track;

@end
