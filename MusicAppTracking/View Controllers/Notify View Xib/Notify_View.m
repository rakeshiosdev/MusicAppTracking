//
//  Notify_View.m
//  MusicAppTracking
//
//  Created by MMF on 23/12/1938 Saka.
//  Copyright © 1938 Saka MMF. All rights reserved.
//

#import "Notify_View.h"

@implementation Notify_View


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {

    _view_Popup.layer.borderWidth = 1.0f;
    _view_Popup.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}


@end
