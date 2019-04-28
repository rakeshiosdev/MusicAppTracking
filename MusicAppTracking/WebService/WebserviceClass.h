//
//  WebserviceClass.h
//  SpeakAMe
//
//  Created by MMF on 24/04/1938 Saka.
//  Copyright © 1938 Saka Havantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface WebserviceClass : NSObject
{
    NSDictionary *jsondictionary;
}

-(void)methodForOpenPopup:(UIView *)viewAlert WithBlackTransperentView:(UIView *)viewblackTransperent withParentView:(UIView *)parentView WithBool:(BOOL)isAlertShow;

-(void)ValidatewebservicewithURL:(NSString*)url andDictionary:(NSMutableDictionary*)Dict  andcontroller:(NSString*)controller and:(id) obj;
-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
- (BOOL)MobileNumberValidateForCountryCode:(NSString *)checkNumber;
-(BOOL) MobileNumberValidate:(NSString *)checkNumber;
-(void)showMessage:(NSString*)message withTitle:(NSString *)title;
-(UIImageView *)setImage:(UIImageView *)img url:(NSString *)strURL;
@end

