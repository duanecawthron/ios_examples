//
//  AppDelegate.m
//  SQLite
//
//  Created by Duane Cawthron on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "/usr/include/sqlite3.h" // also add libsqlite3.dylib to the project

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)example1
{
    NSLog(@"\n\n\n");
          
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    NSURL *url = [[defaultFileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"SQLite Database"];
    NSString *databasePath = [url path];
    const char *charDatabasePath = [databasePath UTF8String];
    sqlite3 *sqliteDatabase;
    
    // create the database
    if (![defaultFileManager fileExistsAtPath:databasePath]) {
        if (sqlite3_open(charDatabasePath, &sqliteDatabase) == SQLITE_OK) {
            char *errMsg;
            const char *sql = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)";
            if (sqlite3_exec(sqliteDatabase, sql, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"ERROR: cannot create table\n");
            }
            sqlite3_close(sqliteDatabase);
        } else {
            NSLog(@"ERROR: cannot open database\n");
        }
    }
    
    NSError *error;
    if ([url checkResourceIsReachableAndReturnError:&error]) NSLog(@"found file %@\n", databasePath);
    else NSLog(@"ERROR: cannot find file %@\n", databasePath);

    // write to the database
    if (sqlite3_open(charDatabasePath, &sqliteDatabase) == SQLITE_OK) {
        NSString *sqlString = [NSString stringWithFormat:@"INSERT INTO CONTACTS (name, address, phone) VALUES (\"%@\", \"%@\", \"%@\")",
                               @"John", @"100 Elm", @"555-555-5555"];
        const char *sql = [sqlString UTF8String];
        sqlite3_stmt *statement;
        
        sqlite3_prepare_v2(sqliteDatabase, sql, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) NSLog(@"write to database\n");
        else NSLog(@"ERROR: cannot write to database\n");
        sqlite3_finalize(statement);
        sqlite3_close(sqliteDatabase);
    }
    
    // query the database
    if (sqlite3_open(charDatabasePath, &sqliteDatabase) == SQLITE_OK) {
        NSString *sqlString = [NSString stringWithFormat: @"SELECT address, phone FROM contacts WHERE name=\"%@\"", @"John"];
        const char *sql = [sqlString UTF8String];
        sqlite3_stmt *statement;
        
        if (sqlite3_prepare_v2(sqliteDatabase, sql, -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *address = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *phone =   [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSLog(@"found John, %@, %@\n", address, phone);

            } else {
                NSLog(@"ERROR: cannot find John\n");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(sqliteDatabase);
    }
        
        
        
    NSLog(@"\n\n\n");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    [self example1];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
