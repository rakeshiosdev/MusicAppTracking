//
//  DBManager.m
//  DatabaseDemo
//
//  Created by admin on 8/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "DBManager.h"
#import "Constant.h"
#import <AVFoundation/AVFoundation.h>

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
    }
    return sharedInstance;
}
#pragma mark -Save Single chat data
-(BOOL)saveData:(NSString*)userId fromID:(NSString*)fid message:(NSString*)msg viaUser:(NSString *)via msgType:(NSString *)messageType msgTime:(NSString *)mTime imageData:(NSData *)imgData videoData:(NSData *)videodata thumbData:(NSData *)thumb documentPath:(NSString *)filePath contact:(NSString *)strContact traslatedMessage:(NSString *)tMsg historyTime:(NSString *)hisTime messageDate:(NSString *)msgDate
{

    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
   {
       
            const char *sqliteQuery = "insert into chatTabel(ToID, FromID, Message, VIA, MessageType,time, Photo, Video, thumbImage, FilePath, Contact, Tmessage, historyTime, messageDate) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
          sqlite3_stmt *sqlstatement = nil;

    
        if (sqlite3_prepare_v2(database, sqliteQuery, -1, &sqlstatement, NULL)==SQLITE_OK )
        {
            
            sqlite3_bind_text(sqlstatement, 1, [[NSString stringWithFormat:@"%@", userId] UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 2, [[NSString stringWithFormat:@"%@", fid] UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 3, [msg UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 4, [via UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 5, [messageType UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 6, [mTime UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_blob(sqlstatement, 7, [imgData bytes], (unsigned int)[imgData length], SQLITE_TRANSIENT);
            sqlite3_bind_blob(sqlstatement, 8, [videodata bytes], (unsigned int)[videodata length], SQLITE_TRANSIENT);
            sqlite3_bind_blob(sqlstatement, 9, [thumb bytes], (unsigned int)[thumb length], SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 10, [filePath UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 11, [strContact UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 12, [tMsg UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 13, [hisTime UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 14, [msgDate UTF8String], -1,  SQLITE_TRANSIENT);
            
            
            // executes the sql statement with the data you need to insert in the db
            sqlite3_step(sqlstatement);
            
            // clearing the sql statement
            sqlite3_finalize(sqlstatement);
            //closing the database after the query execution
            sqlite3_close(database);
            
            return YES;
        }
        else
        {
            return NO;
        }
   }
    return NO;
}

#pragma mark -Save Group chat data
-(BOOL)saveGroupChat:(NSString*)groupName textMessage:(NSString *)textMessage msgType:(NSString *)messageType viaUser:(NSString *)via userName:(NSString *)username imageData:(NSData *)imgData videoData:(NSData *)videodata thumbData:(NSData *)thumb documentPath:(NSString *)filePath contact:(NSString *)strContact groupID:(NSString *)strGId time:(NSString *)strTime date:(NSString *)strDate historyTime:(NSString *)hisTime translatedText:(NSString *)strTText
{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
    
        const char *sqliteQuery = "insert into groupChat(GroupName, TextMessage, MessageType, VIA, UserName, Photo, Video, thumbImage, FilePath, Contact, GID, Time, Date, historyTime, TMessage) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        
        sqlite3_stmt *sqlstatement = nil;
        
        if (sqlite3_prepare_v2(database, sqliteQuery, -1, &sqlstatement, NULL)==SQLITE_OK )
        {
            sqlite3_bind_text(sqlstatement, 1, [groupName UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 2, [textMessage UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 3, [messageType UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 4, [via UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 5, [username UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_blob(sqlstatement, 6, [imgData bytes], (unsigned int)[imgData length], SQLITE_TRANSIENT);
            sqlite3_bind_blob(sqlstatement, 7, [videodata bytes], (unsigned int)[videodata length], SQLITE_TRANSIENT);
            sqlite3_bind_blob(sqlstatement, 8, [thumb bytes], (unsigned int)[thumb length], SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 9, [filePath UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 10, [strContact UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 11, [[NSString stringWithFormat:@"%@", strGId] UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 12, [strTime UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 13, [strDate UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 14, [hisTime UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 15, [strTText UTF8String], -1,  SQLITE_TRANSIENT);
            
            // executes the sql statement with the data you need to insert in the db
            sqlite3_step(sqlstatement);
            
            // clearing the sql statement
            sqlite3_finalize(sqlstatement);
            //closing the database after the query execution
            sqlite3_close(database);
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

-(NSMutableArray *)getChatData:(NSString *)userId fromID:(NSString *)fid
{
    NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];

    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];

    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
//        SELECT * FROM chatTabel where 1 and `ToID` = '131' and `FromID` = '116'
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select  * from chatTabel where 1 and ToID = %ld and FromID = %ld",(long)[userId integerValue],(long)[fid integerValue]];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictData=[[NSMutableDictionary alloc]init];
    
                NSString *strMessage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 3)];
                
                NSData *data1 = [strMessage dataUsingEncoding:NSUTF8StringEncoding];
                NSString *decodevalue1 = [[NSString alloc] initWithData:data1 encoding:NSNonLossyASCIIStringEncoding];
                [dictData setValue:decodevalue1 forKey:@"message"];
                
                
                NSString *strVia=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                [dictData setValue:strVia forKey:@"fromMe"];
                NSString *strMType=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                [dictData setValue:strMType forKey:@"type"];
                
                NSString *strTime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                [dictData setValue:strTime forKey:@"chat_time"];
                
                NSData *imgData = [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 7)
                                              length:sqlite3_column_bytes(statement, 7)];
                
                [dictData setValue:imgData forKey:@"image"];
                
                NSData *videoData = [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 8)
                                                         length:sqlite3_column_bytes(statement, 8)];
                
                [dictData setValue:videoData forKey:@"video"];
                
                NSData *thumbData = [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 9)
                                                           length:sqlite3_column_bytes(statement, 9)];
                [dictData setValue:thumbData forKey:@"thumbnail"];
                
                NSString *strDocument=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 10)];
                [dictData setValue:strDocument forKey:@"DocumentPath"];
                
                NSString *strContact=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 11)];
                [dictData setValue:strContact forKey:@"Contact"];
                
                NSString *strTranslateMessage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 12)];
                
                NSData *data = [strTranslateMessage dataUsingEncoding:NSUTF8StringEncoding];
                NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                [dictData setValue:decodevalue forKey:@"translatedText"];

                NSString *strDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 14)];
                [dictData setValue:strDate forKey:@"chat_Date"];
                
                [arrForAddChpter addObject:dictData];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
    return arrForAddChpter;
}


-(NSMutableArray *)getGroupChatData:(NSString *)groupID
{
    NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //        SELECT * FROM chatTabel where 1 and `ToID` = '131' and `FromID` = '116'
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select * from groupChat where 1 and GID = \"%ld\"",(long)[groupID integerValue]];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictData=[[NSMutableDictionary alloc]init];
                
                NSString *strMessage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 2)];
                [dictData setValue:strMessage forKey:@"message"];
                NSString *strMType=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                [dictData setValue:strMType forKey:@"type"];
                NSString *strVia=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                [dictData setValue:strVia forKey:@"fromMe"];
                NSString *strSenderName=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 5)];
                [dictData setValue:strSenderName forKey:@"SenderName"];
                NSData *imgData = [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 6)
                                                         length:sqlite3_column_bytes(statement, 6)];
                
                [dictData setValue:imgData forKey:@"image"];
                
                NSData *videoData = [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 7)
                                                           length:sqlite3_column_bytes(statement, 7)];
                
                [dictData setValue:videoData forKey:@"video"];
                
                NSData *thumbData = [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 8)
                                                           length:sqlite3_column_bytes(statement, 8)];
                [dictData setValue:thumbData forKey:@"thumbnail"];
                
                
                NSString *strDocument=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 9)];
                [dictData setValue:strDocument forKey:@"DocumentPath"];

                NSString *strContact=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 10)];
                [dictData setValue:strContact forKey:@"Contact"];
                
                NSString *strTime=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 12)];
                [dictData setValue:strTime forKey:@"chat_time"];
                
                NSString *strDate=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 13)];
                [dictData setValue:strDate forKey:@"chat_Date"];
                
                NSString *strTranslateMessage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 15)];
                
                NSData *data = [strTranslateMessage dataUsingEncoding:NSUTF8StringEncoding];
                NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
                [dictData setValue:decodevalue forKey:@"translatedText"];
                
                [arrForAddChpter addObject:dictData];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
    return arrForAddChpter;
}


//-(BOOL)deleteData:(NSString*)deleteRecords
//{
//
//    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//    _databasePath = [libraryPath stringByAppendingPathComponent:@"userchat.sqlite"];
//
//    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
//        // database doesn't exist in your library path... copy it from the bundle
//        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"userchat" ofType:@"sqlite"];
//        NSError *error = nil;
//
//        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
//            NSLog(@"Error: %@", error);
//        }
//    }
//
//    const char *dbpath = [_databasePath UTF8String];
//    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
//    {
//        NSString *querySQL = [NSString
//                              stringWithFormat: @"delete from stuRecord where stu_id='%ld'",(long)[deleteRecords integerValue]];
//
//        const char *insert_stmt = [querySQL UTF8String];
//        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
//        if (sqlite3_step(statement) == SQLITE_DONE)
//        {
//            return YES;
//        }
//        else {
//            return NO;
//        }
//        sqlite3_reset(statement);
//    }
//    return NO;
//
//}

-(BOOL)saveContact:(NSString*)userId fromID:(NSString*)fid  uName:(NSString *)name uMobile:(NSString *)mobile uImage:(NSString *)img profileStatus:(NSString *)status uLanguage:(NSString *)lang uBlockStatus:(NSString *)blockStatus
{
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO userTabel (ToID, FromID, fromName, mobile, Image, status, language, blockStatus) VALUES (\"%ld\", \"%ld\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                               (long)[userId integerValue],(long)[fid integerValue],name, mobile, img, status, lang, blockStatus];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

#pragma mark - Update UserDetail
-(BOOL)updateChatDetail:(NSString*)pId strName:(NSString*)pName strMobile:(NSString*)pMobile strImage:(NSString*)pImage strStatus:(NSString*)pStatus strLanguage:(NSString*)pLanguage strBlockStatus:(NSString*)pBlockStatus strFromID:(NSString*)pFromID {
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"UPDATE userTabel SET ToID = \"%ld\", fromName = \"%@\", mobile = \"%@\", Image = \"%@\", status = \"%@\", language = \"%@\", blockStatus = \"%@\" WHERE fromID = \"%ld\"" ,(long)[pId integerValue], pName, pMobile, pImage, pStatus, pLanguage, pBlockStatus, (long)[pFromID integerValue]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}


-(BOOL)saveGroupInfo:(NSString*)gID groupIDName:(NSString *)gidName groupName:(NSString *)gName groupImage:(NSString *)gImage
{

    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        const char *sqliteQuery = "insert into groupInfo(GorupID, GroupIdName, GroupName, GroupImage) values(?,?,?,?)";
        
        sqlite3_stmt *sqlstatement = nil;
        
        
        if (sqlite3_prepare_v2(database, sqliteQuery, -1, &sqlstatement, NULL)==SQLITE_OK )
        {
            
            sqlite3_bind_text(sqlstatement, 1, [[NSString stringWithFormat:@"%@", gID] UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 2, [gidName UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 3, [gName UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 4, [gImage UTF8String], -1,  SQLITE_TRANSIENT);
            
            
            // executes the sql statement with the data you need to insert in the db
            sqlite3_step(sqlstatement);
            
            // clearing the sql statement
            sqlite3_finalize(sqlstatement);
            //closing the database after the query execution
            sqlite3_close(database);
            
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

#pragma mark - Update UserDetail
-(BOOL)updateGroupInfo:(NSString*)gID strName:(NSString*)gName strGroupImage:(NSString*)gImage  {
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"UPDATE groupInfo SET GroupName = \"%@\", GroupImage = \"%@\" WHERE GorupID = \"%ld\"" ,gName, gImage, (long)[gID integerValue]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

//-(int)getGroupInFoCount {
//    int contactCount;
//    
//    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
//    
//    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
//    {
//        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
//    }
//    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
//    {
//        NSString *insertSQL = [NSString stringWithFormat:
//                               @"SELECT  COUNT(*) FROM groupInfo"];
//        
//        const char *sql = [insertSQL UTF8String];
//        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
//        {
//            while (sqlite3_step(statement) == SQLITE_ROW)
//            {
//                contactCount = sqlite3_column_int(statement, 0);
//                NSLog(@"%d",contactCount);
//            }
//        }
//    }
//    else {
//        
//        sqlite3_close(database);
//    }
//    
//    return contactCount;
//}


-(NSMutableArray *)getGroupLastMessage:(NSString *)gID
{
    NSMutableArray *arrmsg=[[NSMutableArray alloc]init];
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //        SELECT Message FROM chatTabel where 1 group by FromID=116
        
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select  * from groupChat where 1 and GID = \"%ld\"",(long)[gID integerValue]];
        
        
        const char *sql = [insertSQL UTF8String];
        // const char *sql = "select  *from chatTabel";
        //sqlite3_stmt *selectstmt;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                NSMutableDictionary *dictData=[[NSMutableDictionary alloc]init];
                
                NSString *strMessage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 2)];
                [dictData setValue:strMessage forKey:@"message"];
                
                NSString *strMType=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                [dictData setValue:strMType forKey:@"type"];
                
                NSString *strVia=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                [dictData setValue:strVia forKey:@"fromMe"];
                
                NSString *strSenderName=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 5)];
                [dictData setValue:strSenderName forKey:@"SenderName"];
                
                NSString *strTime=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 12)];
                [dictData setValue:strTime forKey:@"Time"];
                
                NSString *strDate=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 13)];
                [dictData setValue:strDate forKey:@"Date"];
                
                [arrmsg addObject:dictData];            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    return arrmsg;
}


-(NSMutableArray *)getLastMessage:(NSString *)fromID
{
    NSMutableArray *arrmsg=[[NSMutableArray alloc]init];
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //        SELECT Message FROM chatTabel where 1 group by FromID=116
        
       
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select  * from chatTabel where 1 and FromID = %ld",(long)[fromID integerValue]];
        
        
        const char *sql = [insertSQL UTF8String];
        // const char *sql = "select  *from chatTabel";
        //sqlite3_stmt *selectstmt;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictData=[[NSMutableDictionary alloc]init];
                NSString *senderID=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement,2)];
                [dictData setValue:senderID forKey:@"senderID"];
                
                NSString *strMessage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 3)];
                NSData *data1 = [strMessage dataUsingEncoding:NSUTF8StringEncoding];
                NSString *decodevalue1 = [[NSString alloc] initWithData:data1 encoding:NSNonLossyASCIIStringEncoding];
                [dictData setValue:decodevalue1 forKey:@"msg"];
                
                NSString *strMsgType=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                [dictData setValue:strMsgType forKey:@"msgType"];
                
                NSString *strTime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                [dictData setValue:strTime forKey:@"tym"];
                
                NSString *strDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 14)];
                [dictData setValue:strDate forKey:@"date"];
                [arrmsg addObject:dictData];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    return arrmsg;
}

-(NSMutableArray *)getUserDetail:(NSString *)strid {
    
    if ([strid isEqualToString:@"(null)"]) {
        return 0;
    }
    
    
        NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];
        
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
        
        NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSFileManager *fileManager=[NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
        {
            [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
        }
        if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
        {
            
            NSString *selectSQL = [NSString stringWithFormat:
                                   @"select  * from userTabel where fromID = \"%ld\"",(long)[strid integerValue]];
            
            
            const char *sql = [selectSQL UTF8String];
            
            if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSMutableDictionary *dictData=[[NSMutableDictionary alloc]init];
                    //1.
                    NSString *strContactName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                    [dictData setValue:strContactName forKey:@"name"];
                    //2.
                    NSString *strContactPhone=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                    [dictData setValue:strContactPhone forKey:@"phone"];
                    //3.
                    NSString *strImage=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                    [dictData setValue:strImage forKey:@"picture"];
                    
                    //4.
                    NSString *strStatus=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 5)];
                    [dictData setValue:strStatus forKey:@"userStatus"];
                   
                    //5
                    NSString *strLanguage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 6)];
                    [dictData setValue:strLanguage forKey:@"userLanguage"];
                    
                    //6
                    NSString *strBlockStatus=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 7)];
                    [dictData setValue:strBlockStatus forKey:@"userBlockStatus"];
                    
                    [arrForAddChpter addObject:dictData];
                }
            }
        }
        else {
            
            sqlite3_close(database);
        }
    
        NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
        return arrForAddChpter;
}

-(NSMutableArray *)getFromIdFromAppContact {
    
    NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        
        NSString *selectSQL = [NSString stringWithFormat:
                               @"select  * from appContactTbl"];
        
        
        const char *sql = [selectSQL UTF8String];
        
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //1.
                NSString *strFromID=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                [arrForAddChpter addObject:strFromID];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
    return arrForAddChpter;
}

#pragma mark - Update UserDetail
-(BOOL)updateUserDetail:(NSString*)pMobile strName:(NSString*)pName {
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"UPDATE userTabel SET fromName = \"%@\" WHERE mobile = \"%@\"" ,pName, pMobile];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

#pragma mark - Update User Block Detail
-(BOOL)updateUserBlockDetail:(NSString*)blockStatus fromID:(NSString*)fid {
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"UPDATE userTabel SET blockStatus = \"%@\" WHERE fromID = \"%ld\"" ,blockStatus, (long)[fid integerValue]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}


-(NSMutableArray *)getChatFromID
    {
            NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];
            
            NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
            _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
            
            NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
            NSFileManager *fileManager=[NSFileManager defaultManager];
            if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
            {
                [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
            }
            if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
            {
                
                const char *sql = "SELECT * FROM chatTabel  where 1 group by FromID order by id DESC";
                //sqlite3_stmt *selectstmt;
                if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
                {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        //1.
                        NSString *strfID=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 2)];
                        [arrForAddChpter addObject:strfID];
                    }
                }
            }
            else {
                
                sqlite3_close(database);
            }
            
            NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
            return arrForAddChpter;
}

-(NSMutableArray *)getChatSenderID
{
    NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        
        const char *sql = "SELECT * FROM chatTabel  where 1 group by FromID order by id DESC";
        //sqlite3_stmt *selectstmt;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *strfID=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 2)];
                [arrForAddChpter addObject:strfID];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
    return arrForAddChpter;
}


-(NSMutableArray *)getGroupInfo
{
    NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //  where 1 group by GroupName order by id DESC
//        const char *sql = "SELECT * FROM groupInfo";

        const char *sql = "SELECT * FROM groupInfo  where 1 group by GorupID order by SID DESC";
//        SELECT * FROM chatTabel  where 1 group by GorupID order by SID DESC
        //sqlite3_stmt *selectstmt;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictData=[[NSMutableDictionary alloc]init];
                //1.
                NSString *strGroupID=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 1)];
                [dictData setValue:strGroupID forKey:@"group_id"];
                
                NSString *strGroupNameID=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 2)];
                [dictData setValue:strGroupNameID forKey:@"group_name_id"];
                
                NSString *strGroupName=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 3)];
                [dictData setValue:strGroupName forKey:@"group_name"];
                
                NSString *strGroupImage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 4)];
                [dictData setValue:strGroupImage forKey:@"group_image"];
                [arrForAddChpter addObject:dictData];
            }
        }
    }
    else {
        sqlite3_close(database);
    }
    
    NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
    return arrForAddChpter;
}

-(NSMutableArray *)getGroupID
{
    NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //  where 1 group by GroupName order by id DESC
        const char *sql = "SELECT * FROM groupInfo  where 1 group by GorupID order by SID DESC";
        //sqlite3_stmt *selectstmt;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *strGroupID=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 1)];
                [arrForAddChpter addObject:strGroupID];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
    return arrForAddChpter;
}

#pragma mark - Chat History
-(NSMutableArray *)getChatDate:(NSString *)userId fromID:(NSString *)fid {
    
    NSMutableArray *arrTime=[[NSMutableArray alloc]init];
    
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
        
        NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSFileManager *fileManager=[NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
        {
            [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
        }
        if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
        {
            
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"select  * from chatTabel where 1 and ToID = %ld and FromID = %ld",(long)[userId integerValue],(long)[fid integerValue]];
            
            const char *sql = [insertSQL UTF8String];
            if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                  NSString *strTime=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 13)];
//                    NSLog(@"Time %@",strTime);
                    [arrTime addObject:strTime];
                }
            }
        }
        else {
            
            sqlite3_close(database);
        }
    
        return arrTime;
}

-(NSMutableArray *)getGroupChatDate:(NSString *)groupID {
    
    NSMutableArray *arrTime=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select  * from groupChat where 1 and GID = %ld",(long)[groupID integerValue]];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *strTime=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 14)];
                //                    NSLog(@"Time %@",strTime);
                [arrTime addObject:strTime];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    return arrTime;
}

#pragma mark - Chat History
-(BOOL)deleteChatDate:(NSString *)fid currentDate:(NSString *)cDate previousDate:(NSString *)pDate {
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"delete from chatTabel where FromID = %ld and historyTime between \"%@\" and \"%@\"",(long)[fid integerValue], cDate, pDate];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}



// IF Find previous date
-(NSMutableArray *)getchatHistory:(NSString *)fid currentDate:(NSString *)cDate previousDate:(NSString *)pDate {
    NSMutableArray *arrHistory=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //select * from tbl_chat where key_receiver = '9669387011' AND key_date BETWEEN '2017 03 04' AND '2017 03 04'
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select  * from chatTabel where FromID = %ld and historyTime between \"%@\" and \"%@\"",(long)[fid integerValue], cDate, pDate];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *strTime=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 6)];
                NSString *strMessage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 3)];
                NSString *strHistory=[[[[strTime stringByAppendingString:@" - "] stringByAppendingString:[userDefaults valueForKey:@"uName"]] stringByAppendingString:@" - "]stringByAppendingString:strMessage];
                [arrHistory addObject:strHistory];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    return arrHistory;
}

// IF Find previous date
-(NSMutableArray *)getchatGroupHistory:(NSString *)gid currentDate:(NSString *)cDate previousDate:(NSString *)pDate {
    NSMutableArray *arrHistory=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //select * from tbl_chat where key_receiver = '9669387011' AND key_date BETWEEN '2017 03 04' AND '2017 03 04'
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select  * from groupChat where GID = %ld and historyTime between \"%@\" and \"%@\"",(long)[gid integerValue], cDate, pDate];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *strTime=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 12)];
                NSString *strMessage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 2)];
                NSString *strGroupName=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 1)];

                
                NSString *strHistory=[[[[strTime stringByAppendingString:@" - "] stringByAppendingString:strGroupName] stringByAppendingString:@" - "]stringByAppendingString:strMessage];
                [arrHistory addObject:strHistory];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    return arrHistory;
}


#pragma mark - Save Sender ID
-(BOOL)saveSenderID:(NSString*)senderID {
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        const char *sqliteQuery = "insert into UnReadMessageTbl(senderID) values(?)";
        sqlite3_stmt *sqlstatement = nil;
        if (sqlite3_prepare_v2(database, sqliteQuery, -1, &sqlstatement, NULL)==SQLITE_OK )
        {
            
            sqlite3_bind_text(sqlstatement, 1, [[NSString stringWithFormat:@"%@", senderID] UTF8String], -1,  SQLITE_TRANSIENT);
            
            // executes the sql statement with the data you need to insert in the db
            sqlite3_step(sqlstatement);
            
            // clearing the sql statement
            sqlite3_finalize(sqlstatement);
            //closing the database after the query execution
            sqlite3_close(database);
            
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return NO;
}

-(int)countUnreadbleChat:(NSString *)sender {
    int chatCount;
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //select * from tbl_chat where key_receiver = '9669387011' AND key_date BETWEEN '2017 03 04' AND '2017 03 04'
        NSString *insertSQL = [NSString stringWithFormat:
                               @"SELECT  COUNT(senderID) FROM UnReadMessageTbl where senderID = \"%ld\"",(long)[sender integerValue]];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                chatCount = sqlite3_column_int(statement, 0);
                NSLog(@"%d",chatCount);
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    return chatCount;
}
-(BOOL)deleteCount:(NSString *)sender {
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"DELETE FROM UnReadMessageTbl where senderID = \"%ld\"",(long)[sender integerValue]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

#pragma mark - Group Sender ID
-(BOOL)saveGroupSenderID:(NSString*)senderID {
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        const char *sqliteQuery = "insert into UnReadMessageGroupTbl(GroupID) values(?)";
        sqlite3_stmt *sqlstatement = nil;
        if (sqlite3_prepare_v2(database, sqliteQuery, -1, &sqlstatement, NULL)==SQLITE_OK )
        {
            
            sqlite3_bind_text(sqlstatement, 1, [[NSString stringWithFormat:@"%@", senderID] UTF8String], -1,  SQLITE_TRANSIENT);
            
            // executes the sql statement with the data you need to insert in the db
            sqlite3_step(sqlstatement);
            
            // clearing the sql statement
            sqlite3_finalize(sqlstatement);
            //closing the database after the query execution
            sqlite3_close(database);
            
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return NO;
}

-(int)countUnreadbleGroup:(NSString *)sender {
    int chatCount;
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //select * from tbl_chat where key_receiver = '9669387011' AND key_date BETWEEN '2017 03 04' AND '2017 03 04'
        NSString *insertSQL = [NSString stringWithFormat:
                               @"SELECT  COUNT(GroupID) FROM UnReadMessageGroupTbl where GroupID = \"%ld\"",(long)[sender integerValue]];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                chatCount = sqlite3_column_int(statement, 0);
                NSLog(@"%d",chatCount);
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    return chatCount;
}

-(BOOL)deleteCountGroup:(NSString *)sender {
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"DELETE FROM UnReadMessageGroupTbl where GroupID = \"%ld\"",(long)[sender integerValue]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}



#pragma mark - App Contact
-(int)getAppContactCount {
    int contactCount;
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"SELECT  COUNT(*) FROM appContactTbl"];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                contactCount = sqlite3_column_int(statement, 0);
                NSLog(@"%d",contactCount);
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    return contactCount;
}

-(void)TruncateAppContact
{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        const char *sql = "DELETE FROM appContactTbl";
        //sqlite3_stmt *selectstmt;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
}

-(BOOL)saveAppContact:(NSString*)cID ContactName:(NSString *)cName contactMobile:(NSString *)cMobile contactImage:(NSString *)cImage contactStatus:(NSString *)cStatus contactFav:(NSString *)cFav conLanguage:(NSString *)cLanguage contactBlockStatus:(NSString *)cBlock
{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        const char *sqliteQuery = "insert into appContactTbl(pId, pName, pMobile, pImage, pStatus,pFav, pLanguage, pBlockStatus) values(?,?,?,?,?,?,?,?)";
        
        sqlite3_stmt *sqlstatement = nil;
        
        
        if (sqlite3_prepare_v2(database, sqliteQuery, -1, &sqlstatement, NULL)==SQLITE_OK )
        {
            
            sqlite3_bind_text(sqlstatement, 1, [cID UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 2, [cName UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 3, [cMobile UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 4, [cImage UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 5, [cStatus UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 6, [cFav UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 7, [cLanguage UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 8, [cBlock UTF8String], -1,  SQLITE_TRANSIENT);
    
            
            // executes the sql statement with the data you need to insert in the db
            sqlite3_step(sqlstatement);
            
            // clearing the sql statement
            sqlite3_finalize(sqlstatement);
            //closing the database after the query execution
            sqlite3_close(database);
            
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return NO;
}

-(NSMutableArray *)getAppContact
{
    NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select  *from appContactTbl"];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictData=[[NSMutableDictionary alloc]init];
                
                NSString *strPID=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 1)];
                [dictData setValue:strPID forKey:@"speaka_id"];
                
                NSString *strName=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 2)];
                [dictData setValue:strName forKey:@"person_name"];
                
                NSString *strMobile=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 3)];
                [dictData setValue:strMobile forKey:@"speaka_number"];
                
                NSString *strImage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 4)];
                [dictData setValue:strImage forKey:@"user_image"];
                
                NSString *strProfileStatus=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 5)];
                [dictData setValue:strProfileStatus forKey:@"userProfileStatus"];
                
                NSString *strFav=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 6)];
                [dictData setValue:strFav forKey:@"faviroute"];

                NSString *strLanguage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 7)];
                [dictData setValue:strLanguage forKey:@"language"];
                
                NSString *strBlockStatus=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 8)];
                [dictData setValue:strLanguage forKey:@"blockStatus"];

                [arrForAddChpter addObject:dictData];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
    return arrForAddChpter;
}

-(NSMutableDictionary *)getSingleAppContact:(NSString *)fid
{
    NSMutableDictionary *dictContact=[[NSMutableDictionary alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select * from appContactTbl where 1 and pId = \"%ld\"",(long)[fid integerValue]];
        
        
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                NSString *strPID=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 1)];
                [dictContact setValue:strPID forKey:@"speaka_id"];
                
                NSString *strName=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 2)];
                [dictContact setValue:strName forKey:@"person_name"];
                
                NSString *strMobile=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 3)];
                [dictContact setValue:strMobile forKey:@"speaka_number"];
                
                NSString *strImage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 4)];
                [dictContact setValue:strImage forKey:@"user_image"];
                
                NSString *strProfileStatus=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 5)];
                [dictContact setValue:strProfileStatus forKey:@"userProfileStatus"];
                
                NSString *strFav=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 6)];
                [dictContact setValue:strFav forKey:@"faviroute"];
                
                NSString *strLanguage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 7)];
                [dictContact setValue:strLanguage forKey:@"language"];
                
                NSString *strBlockStatus=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 8)];
                [dictContact setValue:strLanguage forKey:@"blockStatus"];
                
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    return dictContact;
}


-(BOOL)updateFavotiteContact:(NSString*)pMobile strFav:(NSString*)fav {
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"UPDATE appContactTbl SET pFav = \"%@\" WHERE pMobile = \"%@\"" ,fav, pMobile];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

-(NSString *)getUserBlockStatus:(NSString *)fid
{
    NSString *strMessage;
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //        SELECT Message FROM chatTabel where 1 group by FromID=116
        
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select  * from userTabel where 1 and fromID = \"%ld\"",(long)[fid integerValue]];
        
        
        const char *sql = [insertSQL UTF8String];
        // const char *sql = "select  *from chatTabel";
        //sqlite3_stmt *selectstmt;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                strMessage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 7)];
                
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    return strMessage;
}

#pragma mark - Fetch Media History
-(NSMutableArray *)getMediaData:(NSString *)userId fromID:(NSString *)fid
{
    NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //        SELECT * FROM chatTabel where 1 and `ToID` = '131' and `FromID` = '116'
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select  * from chatTabel where 1 and ToID = %ld and FromID = %ld",(long)[userId integerValue],(long)[fid integerValue]];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                
                NSData *imgData = [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 7)
                                                         length:sqlite3_column_bytes(statement, 7)];
                
                if (imgData.length != 0) {
                    UIImage *image = [[UIImage alloc] initWithData:imgData];
                    [dict setObject:image forKey:@"image"];
                    [dict setObject:imgData forKey:@"data"];
                    [arrForAddChpter addObject:dict];
                }
               
               NSData *videoData = [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 8)
                                                           length:sqlite3_column_bytes(statement, 8)];
                
                if (videoData.length !=0) {

                    NSString *appFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"video.mp4"];
                    NSURL *url = [NSURL fileURLWithPath:appFile];
                    
                    AVAsset *asset = [AVAsset assetWithURL:url];
                    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
                    imageGenerator.appliesPreferredTrackTransform = YES;
                    CMTime time = [asset duration];
                    time.value = 0;
                    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
                    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
                    
                    [dict setObject:thumbnail forKey:@"video"];
                    [dict setObject:videoData forKey:@"data"];
                    [arrForAddChpter addObject:dict];

                }
                
//                NSString *strDocument=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 10)];
//                NSArray *parts = [strDocument componentsSeparatedByString:@"/"];
//                NSString *filename = [parts lastObject];
//                NSLog(@"Document Url: %@",filename);
//                [dict setValue:strDocument forKey:@"DocumentPath"];
                
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
    return arrForAddChpter;
}

-(NSMutableArray *)getGroupMediaData:(NSString *)groupID
{
    NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //        SELECT * FROM chatTabel where 1 and `ToID` = '131' and `FromID` = '116'
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select * from groupChat where 1 and GID = \"%ld\"",(long)[groupID integerValue]];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {

                NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                
                NSData *imgData = [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 6)
                                                         length:sqlite3_column_bytes(statement, 6)];
                
                if (imgData.length != 0) {
                    UIImage *image = [[UIImage alloc] initWithData:imgData];
                    [dict setObject:image forKey:@"image"];
                    [dict setObject:imgData forKey:@"data"];
                    [arrForAddChpter addObject:dict];
                }
                
                NSData *videoData = [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 7)
                                                           length:sqlite3_column_bytes(statement, 7)];
                
                if (videoData.length !=0) {
                    
                    NSString *appFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"video.mp4"];
                    NSURL *url = [NSURL fileURLWithPath:appFile];
                    
                    AVAsset *asset = [AVAsset assetWithURL:url];
                    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
                    imageGenerator.appliesPreferredTrackTransform = YES;
                    CMTime time = [asset duration];
                    time.value = 0;
                    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
                    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
                    
                    [dict setObject:thumbnail forKey:@"video"];
                    [dict setObject:videoData forKey:@"data"];
                    [arrForAddChpter addObject:dict];
                    
                }
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
    return arrForAddChpter;
}

#pragma mark -Manage Typing Status
-(NSMutableArray *)getAppMobileNumber
{
    NSMutableArray *arrForAddChpter=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select  *from appContactTbl"];
        
        const char *sql = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *strMobile=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 3)];
                NSString *strFullMobile=[[strMobile stringByReplacingOccurrencesOfString:@"+" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                [arrForAddChpter addObject:strFullMobile];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
    return arrForAddChpter;
}

#pragma mark - Working on Last Seen
-(BOOL)saveLastSeen:(NSString*)serverID lastTime:(NSString*)time
{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    NSLog(@"DatabasePath %@", _databasePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        // database doesn't exist in your library path... copy it from the bundle
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:_databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        const char *sqliteQuery = "insert into UserLastSeen(serverID, LastSeen) values(?,?)";
        
        sqlite3_stmt *sqlstatement = nil;
        
        
        if (sqlite3_prepare_v2(database, sqliteQuery, -1, &sqlstatement, NULL)==SQLITE_OK )
        {
            
            sqlite3_bind_text(sqlstatement, 1, [serverID UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 2, [time UTF8String], -1,  SQLITE_TRANSIENT);
            
            // executes the sql statement with the data you need to insert in the db
            sqlite3_step(sqlstatement);
            
            // clearing the sql statement
            sqlite3_finalize(sqlstatement);
            //closing the database after the query execution
            sqlite3_close(database);
            
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return NO;
}

-(NSMutableArray *)MethodForSelectLastSeen:(NSString *)sID {
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //select * from tbl_chat where key_receiver = '9669387011' AND key_date BETWEEN '2017 03 04' AND '2017 03 04'
        NSString *insertSQL = [NSString stringWithFormat:
                               @"SELECT  * FROM UserLastSeen where serverID = \"%@\"",sID];
        
        const char *sql = [insertSQL UTF8String];
        
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *strMessage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 2)];
                [arr addObject:strMessage];
            }
        }
    }
    else {
        
        sqlite3_close(database);
    }
    
    return arr;
}


-(NSMutableDictionary *)getGroupInfo:(NSString *)gid
{NSMutableDictionary *dictData=[[NSMutableDictionary alloc]init];
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    _databasePath = [libraryPath stringByAppendingPathComponent:@"ConversationDB.sqlite"];
    
    NSLog(@"SAVE PATH OF DATA BASE %@",_databasePath);
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ConversationDB" ofType:@"sqlite"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_databasePath isDirectory:false])
    {
        [fileManager copyItemAtPath:sourcePath toPath:_databasePath error:nil];
    }
    if (sqlite3_open([_databasePath UTF8String], &database) == SQLITE_OK)
    {
        //  where 1 group by GroupName order by id DESC
        //        const char *sql = "SELECT * FROM groupInfo";
        
       // const char *sql = "SELECT * FROM groupInfo  where 1 group by GorupID order by SID DESC";
        
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"select * from groupInfo where 1 and GorupID = \"%ld\"",(long)[gid integerValue]];
        
        const char *sql=[insertSQL UTF8String];
        
        //        SELECT * FROM chatTabel  where 1 group by GorupID order by SID DESC
        //sqlite3_stmt *selectstmt;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) ==SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                //1.
                NSString *strGroupID=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 1)];
                [dictData setValue:strGroupID forKey:@"group_id"];
                
                NSString *strGroupNameID=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 2)];
                [dictData setValue:strGroupNameID forKey:@"group_name_id"];
                
                NSString *strGroupName=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 3)];
                [dictData setValue:strGroupName forKey:@"group_name"];
                
                NSString *strGroupImage=[NSString stringWithFormat:@"%s",(const char*)sqlite3_column_text(statement, 4)];
                [dictData setValue:strGroupImage forKey:@"group_image"];
            }
        }
    }
    else {
        sqlite3_close(database);
    }
    
   // NSLog(@"array fetch total count is %lu ",(unsigned long)arrForAddChpter.count);
    return dictData;
}

@end
