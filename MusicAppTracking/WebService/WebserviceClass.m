//
//  WebserviceClass.m
//  SpeakAMe
//
//  Created by MMF on 24/04/1938 Saka.
//  Copyright © 1938 Saka Havantage. All rights reserved.
//

#import "WebserviceClass.h"
#import "Constant.h"
#import <UIKit/UIKit.h>
@implementation WebserviceClass

-(void)ValidatewebservicewithURL:(NSString*)url andDictionary:(NSMutableDictionary*)Dict  andcontroller:(NSString*)controller and:(id) obj
{  
    NSURL* URL = [NSURL URLWithString:url];
    NSMutableArray *jsonArry = [[NSMutableArray alloc]init];
    [jsonArry addObject:Dict];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArry options:NSJSONWritingPrettyPrinted error:&error];
    NSString *resultAsString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsonData as string:\n%@ Error:%@", resultAsString,error);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:URL];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPBody:jsonData];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSLog(@"errorxyz %@",error.domain);
         NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
         NSInteger statusCode = [HTTPResponse statusCode];
         NSLog(@"response %@ status code  %ld ",HTTPResponse,(long)statusCode);
         if (!error)
         {
             if (data!=nil)
             {
                 jsondictionary=[[NSMutableDictionary alloc] init];
                 jsondictionary= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
             }
             if (statusCode==200)
             {
                 NSString *err=[jsondictionary valueForKey:@"ERROR"];
                 if ([err intValue]==0)
                 {
                     @try {
                         
                         //SignIn
                         if ([controller isEqualToString:@"Login"]) {
                             SignINViewController *ss=(SignINViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         
                         //SignIn
                         if ([controller isEqualToString:@"LoginFB"]) {
                             SignINViewController *ss=(SignINViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:2];
                         }
                        //LoginAnotherDevice
                         if ([controller isEqualToString:@"LoginAnotherDevice"]) {
                             SignINViewController *ss=(SignINViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:3];
                         }
                        
                         //SighInWithFb
                         if ([controller isEqualToString:@"LoginWithFB"]) {
                             InputContactViewController *ss=(InputContactViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         
                         //SingUp
                         if ([controller isEqualToString:@"SignUp"]) {
                             RegisterViewController *ss=(RegisterViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //otp verification
                         if ([controller isEqualToString:@"OTP"]) {
                             VerifyViewController *ss=(VerifyViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         if ([controller isEqualToString:@"RequestOTP"]) {
                             VerifyViewController *ss=(VerifyViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:2];
                         }
                         //otp_fb verification
                         if ([controller isEqualToString:@"OTP_fb"]) {
                             VerifyViewController *ss=(VerifyViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:3];
                         }
                         //RequestOtpOther verification
                         if ([controller isEqualToString:@"RequestOtpOther"]) {
                             VerifyViewController *ss=(VerifyViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:4];
                         }
                         //Change Number Verify
                         if ([controller isEqualToString:@"ChangeNumberVerify"]) {
                             VerifyViewController *ss=(VerifyViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:5];
                         }
                         //Change Language
                         if ([controller isEqualToString:@"ChangeLanguage"]) {
                             SettingsViewController *ss=(SettingsViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //background
                         if ([controller isEqualToString:@"back"]) {
                             SettingsViewController *ss=(SettingsViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:2];
                         }
                         //EditProfile
                         if ([controller isEqualToString:@"EditProfile"]) {
                             EditProfileViewController *ss=(EditProfileViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         
                         //AfterEditProfile
                         if ([controller isEqualToString:@"AfterEditProfile"]) {
                             EditProfileViewController *ss=(EditProfileViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:2];
                         }
                         //ContactUs
                         if ([controller isEqualToString:@"ContactUs"]) {
                             ContactUsViewController *ss=(ContactUsViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //PushContactOnServer
                         if ([controller isEqualToString:@"PushContact"]) {
                             SpeakMeFriends *ss=(SpeakMeFriends*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //CreateNewGroup
                         if ([controller isEqualToString:@"CreateGroup"]) {
                             CreateGroupChatViewController *ss=(CreateGroupChatViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //getCheckList
                         if ([controller isEqualToString:@"getCheckList"]) {
                             ContactsViewController *ss=(ContactsViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //AddFev
                         if ([controller isEqualToString:@"Addfav"]) {
                             ContactsViewController *ss=(ContactsViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:2];
                         }
                         //RemoveFav
                         if ([controller isEqualToString:@"Removefav"]) {
                             ContactsViewController *ss=(ContactsViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:3];
                         }
                         //GroupList
                         if ([controller isEqualToString:@"GroupList"]) {
                             ChatViewController *ss=(ChatViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         if ([controller isEqualToString:@"AddContact"]) {
                             NewGroupAddContactViewController *ss=(NewGroupAddContactViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //AddGroupMember
                         if ([controller isEqualToString:@"SendGroupID"]) {
                             NewGroupAddContactViewController *ss=(NewGroupAddContactViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:2];
                         }
                         //MyFavourite
                         if ([controller isEqualToString:@"myFavourate"]) {
                             FavourateViewController *ss=(FavourateViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //ForgotPassword
                         if ([controller isEqualToString:@"ForgotPassword"]) {
                             ForgotPasswordViewController *ss=(ForgotPasswordViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //ChangePassword
                         if ([controller isEqualToString:@"ChangePassword"]) {
                             ResetPasswordViewController *ss=(ResetPasswordViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //UserContinue
                         if ([controller isEqualToString:@"UserContinue"]) {
                             ContinueViewController *ss=(ContinueViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         // Get otp for delete account
                         if ([controller isEqualToString:@"GetOtpForDeleteAccount"]) {
                             DeleteMyAccountViewController *ss=(DeleteMyAccountViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //Delete my Account
                         if ([controller isEqualToString:@"DeleteAccount"]) {
                             DeleteMyAccountViewController *ss=(DeleteMyAccountViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:2];
                         }
                         //Change Number
                         if ([controller isEqualToString:@"ChangeContact"]) {
                             ChangeNumberViewController *ss=(ChangeNumberViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //ProfilePicPreivacy
                         if ([controller isEqualToString:@"ProfilePicPrivacy"]) {
                             PrivacyViewController *ss=(PrivacyViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //StatusPreivacy
                         if ([controller isEqualToString:@"StatusPrivacy"]) {
                             PrivacyViewController *ss=(PrivacyViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:2];
                         }
                         //Update Group Name
                         if ([controller isEqualToString:@"updateGroupName"]) {
                             UpdateGroupInfoViewController *ss=(UpdateGroupInfoViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //Update Group Name
                         if ([controller isEqualToString:@"updateGroupIcon"]) {
                             GroupChatWindowViewController *ss=(GroupChatWindowViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //BlockUser
                         if ([controller isEqualToString:@"BlockUser"]) {
                             UserChatViewController *ss=(UserChatViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //UnBlockUser
                         if ([controller isEqualToString:@"UnBlockUser"]) {
                             UserChatViewController *ss=(UserChatViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:2];
                         }
                         //BlockUserContact
                         if ([controller isEqualToString:@"BlockUserContact"]) {
                             ViewContactViewController *ss=(ViewContactViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                         }
                         //UnBlockUserContact
                         if ([controller isEqualToString:@"UnBlockUserContact"]) {
                             ViewContactViewController *ss=(ViewContactViewController*)obj;
                             [ss Responsewithjsondictionary:jsondictionary andstatus:2];
                         }

                         
                    }
                     @catch (NSException *exception)
                     {
                     }
                 }
                 else
                 {
                     [constantObj showMessage:err withTitle:@"ERROR"];
                 }
             }
             else
             {
             }
             
         }
         else
         {
                     //SignIn
                     if ([controller isEqualToString:@"Login"]) {
                         SignINViewController *ss=(SignINViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //SignIn
                     if ([controller isEqualToString:@"LoginFB"]) {
                         SignINViewController *ss=(SignINViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //LoginAnotherDevice
                     if ([controller isEqualToString:@"LoginAnotherDevice"]) {
                         SignINViewController *ss=(SignINViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //SingUp
                     if ([controller isEqualToString:@"SignUp"]) {
                         RegisterViewController *ss=(RegisterViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //otp verification
                     if ([controller isEqualToString:@"OTP"]) {
                         VerifyViewController *ss=(VerifyViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //otp_fb verification
                     if ([controller isEqualToString:@"OTP_fb"]) {
                         VerifyViewController *ss=(VerifyViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     if ([controller isEqualToString:@"RequestOTP"]) {
                         VerifyViewController *ss=(VerifyViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //RequestOtpOther verification
                     if ([controller isEqualToString:@"RequestOtpOther"]) {
                         VerifyViewController *ss=(VerifyViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //Change Number Verify
                     if ([controller isEqualToString:@"ChangeNumberVerify"]) {
                         VerifyViewController *ss=(VerifyViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //Change Language
                     if ([controller isEqualToString:@"ChangeLanguage"]) {
                         SettingsViewController *ss=(SettingsViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //background
                     if ([controller isEqualToString:@"back"]) {
                         SettingsViewController *ss=(SettingsViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //EditProfile
                     if ([controller isEqualToString:@"EditProfile"]) {
                         EditProfileViewController *ss=(EditProfileViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //AfterEditProfile
                     if ([controller isEqualToString:@"AfterEditProfile"]) {
                         EditProfileViewController *ss=(EditProfileViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //ContactUs
                     if ([controller isEqualToString:@"ContactUs"]) {
                         ContactUsViewController *ss=(ContactUsViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //PushContactOnServer
                     if ([controller isEqualToString:@"PushContact"]) {
                         SpeakMeFriends *ss=(SpeakMeFriends*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //CreateNewGroup
                     if ([controller isEqualToString:@"CreateGroup"]) {
                         CreateGroupChatViewController *ss=(CreateGroupChatViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //ckeckList
                     if ([controller isEqualToString:@"getCheckList"]) {
                         ContactsViewController *ss=(ContactsViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //AddFev
                     if ([controller isEqualToString:@"Addfav"]) {
                         ContactsViewController *ss=(ContactsViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //RemoveFav
                     if ([controller isEqualToString:@"Removefav"]) {
                         ContactsViewController *ss=(ContactsViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }

                     //GroupList
                     if ([controller isEqualToString:@"GroupList"]) {
                         ChatViewController *ss=(ChatViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }

                     if ([controller isEqualToString:@"AddContact"]) {
                         NewGroupAddContactViewController *ss=(NewGroupAddContactViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //AddGroupMember
                     if ([controller isEqualToString:@"SendGroupID"]) {
                         NewGroupAddContactViewController *ss=(NewGroupAddContactViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //MyFavourite
                     if ([controller isEqualToString:@"myFavourate"]) {
                         FavourateViewController *ss=(FavourateViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //SighInWithFb
                     if ([controller isEqualToString:@"LoginWithFB"]) {
                         InputContactViewController *ss=(InputContactViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //ForgotPassword
                     if ([controller isEqualToString:@"ForgotPassword"]) {
                         ForgotPasswordViewController *ss=(ForgotPasswordViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //ChangePassword
                     if ([controller isEqualToString:@"ChangePassword"]) {
                         ResetPasswordViewController *ss=(ResetPasswordViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //UserContinue
                     if ([controller isEqualToString:@"UserContinue"]) {
                         ContinueViewController *ss=(ContinueViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     // Get otp for delete account
                     if ([controller isEqualToString:@"GetOtpForDeleteAccount"]) {
                         DeleteMyAccountViewController *ss=(DeleteMyAccountViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //Delete my Account
                     if ([controller isEqualToString:@"DeleteAccount"]) {
                         DeleteMyAccountViewController *ss=(DeleteMyAccountViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //Change Number
                     if ([controller isEqualToString:@"ChangeContact"]) {
                         ChangeNumberViewController *ss=(ChangeNumberViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //ProfilePicPreivacy
                     if ([controller isEqualToString:@"ProfilePicPrivacy"]) {
                         PrivacyViewController *ss=(PrivacyViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //StatusPreivacy
                     if ([controller isEqualToString:@"StatusPrivacy"]) {
                         PrivacyViewController *ss=(PrivacyViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //Update Group Name
                     if ([controller isEqualToString:@"updateGroupName"]) {
                         UpdateGroupInfoViewController *ss=(UpdateGroupInfoViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //Update Group Name
                     if ([controller isEqualToString:@"updateGroupIcon"]) {
                         GroupChatWindowViewController *ss=(GroupChatWindowViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //BlockUser
                     if ([controller isEqualToString:@"BlockUser"]) {
                         UserChatViewController *ss=(UserChatViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //UnBlockUser
                     if ([controller isEqualToString:@"UnBlockUser"]) {
                         UserChatViewController *ss=(UserChatViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:0];
                     }
                     //BlockUserContact
                     if ([controller isEqualToString:@"BlockUserContact"]) {
                         ViewContactViewController *ss=(ViewContactViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:1];
                     }
                     //UnBlockUserContact
                     if ([controller isEqualToString:@"UnBlockUserContact"]) {
                         ViewContactViewController *ss=(ViewContactViewController*)obj;
                         [ss Responsewithjsondictionary:jsondictionary andstatus:2];
                     }
             }
       }];
}


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


- (BOOL)MobileNumberValidate:(NSString *)checkNumber
{
    NSString *numberRegEx = @"[789][0-9]{3}([0-9]{6,14})?";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    
    if ([numberTest evaluateWithObject:checkNumber] == YES)
        return TRUE;
    else
        return FALSE;
}

- (BOOL)MobileNumberValidateForCountryCode:(NSString *)checkNumber
{
    NSString *strNumber=[self getString_After_Space:checkNumber];
    
    NSString *numberRegEx = @"[789][0-9]{3}([0-9]{6,14})?";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    
    if ([numberTest evaluateWithObject:strNumber] == YES)
        return TRUE;
    else
        return FALSE;
}

-(NSString *)getString_After_Space:(NSString *)str
{
    NSString *strContact;
    NSString *string = str;
    NSRange equalRange = [string rangeOfString:@" " options:NSBackwardsSearch];
    if (equalRange.location != NSNotFound) {
        NSString *result = [string substringFromIndex:equalRange.location + equalRange.length];
        strContact=result;
    } else {
        strContact=string;
    }
    return strContact;
}



-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {//do something when click button
                                   
                                   //                                   [self doclickOk];
                                   
                               }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

#pragma mark -ForPopUpView
-(void)methodForOpenPopup:(UIView *)viewAlert WithBlackTransperentView:(UIView *)viewblackTransperent withParentView:(UIView *)parentView WithBool:(BOOL)isAlertShow
{
    if (isAlertShow)
    {
        viewAlert.hidden = YES;
        [UIView animateWithDuration:0.5 animations:^{
            viewAlert.transform = CGAffineTransformIdentity;
            viewAlert.transform = CGAffineTransformMakeScale(0, 0);
            viewblackTransperent.hidden = YES;
        } completion:^(BOOL finished) {
            viewAlert.hidden= YES;
        }];
    }
    if (!isAlertShow)
    {
        [parentView bringSubviewToFront:viewAlert];
        viewAlert.transform = CGAffineTransformMakeScale(0, 0);
        viewAlert.hidden= NO;
        [UIView animateWithDuration:0.5 animations:^{
            viewAlert.transform = CGAffineTransformIdentity;
            viewblackTransperent.hidden = NO;
            
        } completion:^(BOOL finished) {
        }];
    }
}

-(UIImageView *)setImage:(UIImageView *)img url:(NSString *)strURL{
    
    [img sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:strURL] andPlaceholderImage:[UIImage imageNamed:@"profile_icon"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //Nothing.
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //Nothing.
    }];
    
    return img;
}

@end
