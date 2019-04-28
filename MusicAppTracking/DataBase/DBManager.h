//
//  DBManager.h
//  DatabaseDemo
//
//  Created by admin on 8/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
   // NSString *databasePath;
   
    NSArray *dirPaths;
}

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
+(DBManager*)getSharedInstance;


-(BOOL)saveData:(NSString*)userId fromID:(NSString*)fid message:(NSString*)msg viaUser:(NSString *)via msgType:(NSString *)messageType msgTime:(NSString *)mTime imageData:(NSData *)imgData videoData:(NSData *)videodata thumbData:(NSData *)thumb documentPath:(NSString *)filePath contact:(NSString *)strContact traslatedMessage:(NSString *)tMsg historyTime:(NSString *)hisTime messageDate:(NSString *)msgDate;

-(NSMutableArray *)getChatData:(NSString *)userId fromID:(NSString *)fid;
-(NSMutableArray *)getLastMessage:(NSString *)fromID;
//-(BOOL)deleteData:(NSString*)deleteRecords;


#pragma mark- userTabel
-(BOOL)saveContact:(NSString*)userId fromID:(NSString*)fid  uName:(NSString *)name uMobile:(NSString *)mobile uImage:(NSString *)img profileStatus:(NSString *)status uLanguage:(NSString *)lang uBlockStatus:(NSString *)blockStatus;
-(NSMutableArray *)getUserDetail:(NSString *)strid;
-(NSMutableArray *)getFromIdFromAppContact;
-(NSMutableArray *)getChatFromID;
-(NSMutableArray *)getChatSenderID;
-(BOOL)updateUserDetail:(NSString*)pMobile strName:(NSString*)pName;
-(BOOL)updateChatDetail:(NSString*)pId strName:(NSString*)pName strMobile:(NSString*)pMobile strImage:(NSString*)pImage strStatus:(NSString*)pStatus strLanguage:(NSString*)pLanguage strBlockStatus:(NSString*)pBlockStatus strFromID:(NSString*)pFromID;
-(BOOL)updateUserBlockDetail:(NSString*)blockStatus fromID:(NSString*)fid;
-(NSString *)getUserBlockStatus:(NSString *)fid;
#pragma mark -groupChat
-(BOOL)saveGroupChat:(NSString*)groupName textMessage:(NSString *)textMessage msgType:(NSString *)messageType viaUser:(NSString *)via userName:(NSString *)username imageData:(NSData *)imgData videoData:(NSData *)videodata thumbData:(NSData *)thumb documentPath:(NSString *)filePath contact:(NSString *)strContact groupID:(NSString *)strGId time:(NSString *)strTime date:(NSString *)strDate historyTime:(NSString *)hisTime translatedText:(NSString *)strTText;

-(NSMutableArray *)getGroupChatData:(NSString *)groupID;
-(NSMutableArray *)getGroupLastMessage:(NSString *)gID;
//-(int)getGroupInFoCount;

-(NSMutableArray *)getGroupChatDate:(NSString *)groupID;
-(NSMutableArray *)getchatGroupHistory:(NSString *)gid currentDate:(NSString *)cDate previousDate:(NSString *)pDate;

-(BOOL)saveGroupInfo:(NSString*)gID groupIDName:(NSString *)gidName groupName:(NSString *)gName groupImage:(NSString *)gImage;
-(NSMutableArray *)getGroupInfo;
-(NSMutableArray *)getGroupID;
-(BOOL)updateGroupInfo:(NSString*)gID strName:(NSString*)gName strGroupImage:(NSString*)gImage;


#pragma mark - Chat History
-(NSMutableArray *)getChatDate:(NSString *)userId fromID:(NSString *)fid;

-(NSMutableArray *)getchatHistory:(NSString *)fid currentDate:(NSString *)cDate previousDate:(NSString *)pDate;
-(BOOL)deleteChatDate:(NSString *)fid currentDate:(NSString *)cDate previousDate:(NSString *)pDate;

#pragma mark -Save Sender ID
-(BOOL)saveSenderID:(NSString*)senderID;
-(int)countUnreadbleChat:(NSString *)sender;
-(BOOL)deleteCount:(NSString *)sender;

#pragma mark- AppContact
-(int)getAppContactCount;
-(void)TruncateAppContact;
-(BOOL)saveAppContact:(NSString*)cID ContactName:(NSString *)cName contactMobile:(NSString *)cMobile contactImage:(NSString *)cImage contactStatus:(NSString *)cStatus contactFav:(NSString *)cFav conLanguage:(NSString *)cLanguage contactBlockStatus:(NSString *)cBlock;
-(NSMutableArray *)getAppContact;
-(NSMutableDictionary *)getSingleAppContact:(NSString *)fid;
-(BOOL)updateFavotiteContact:(NSString*)pMobile strFav:(NSString*)fav;

//Group Id Count
-(BOOL)saveGroupSenderID:(NSString*)senderID;
-(int)countUnreadbleGroup:(NSString *)sender;
-(BOOL)deleteCountGroup:(NSString *)sender;


#pragma mark - Fetch Media History
-(NSMutableArray *)getMediaData:(NSString *)userId fromID:(NSString *)fid;
-(NSMutableArray *)getGroupMediaData:(NSString *)groupID;

-(NSMutableArray *)getAppMobileNumber;

#pragma mark - Working on Last Seen
-(BOOL)saveLastSeen:(NSString*)serverID lastTime:(NSString*)time;
-(NSMutableArray *)MethodForSelectLastSeen:(NSString *)sID;

-(NSMutableDictionary *)getGroupInfo:(NSString *)gid;
@end
