//
//  AppDelegate.m
//  ApplicationShortCutsOC
//
//  Created by cloudyBright on 15/12/3.
//  Copyright © 2015年 cloudyBright. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@property(strong, nonatomic) UIApplicationShortcutItem *lanuchedShortcutItem;


@end


static NSString *sApplicationShortcutUserInfoIconKey = @"applicationShortcutUserInfoIconKey";

@implementation AppDelegate


+(NSString*)applicationShortcutUserInfoIconKey
{
    return sApplicationShortcutUserInfoIconKey;
}

+(void)setApplicationShortcutUserInfoIconKey:(NSString*)newValue
{
    sApplicationShortcutUserInfoIconKey = newValue;
}


-(BOOL)handleShortCutItem:(UIApplicationShortcutItem*)shortcutItem
{
    BOOL handled = NO;
    
    if ([shortcutItem.type isEqualToString:[self convertToType:@"First"]] ||
        [shortcutItem.type isEqualToString:[self convertToType:@"Second"]] ||
        [shortcutItem.type isEqualToString:[self convertToType:@"Third"]] ||
        [shortcutItem.type isEqualToString:[self convertToType:@"Fourth"]]) {
        
        handled = YES;
    }else{
        return NO;
    }
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Shortcut Handled" message:shortcutItem.localizedTitle preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:^{
        
    }];
    
    
    
    return handled;
}

-(NSString*)convertToType:(NSString*)shortcutIdentifier
{
    return [NSString stringWithFormat:@"%@.%@", [NSBundle mainBundle].bundleIdentifier,shortcutIdentifier];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    BOOL shouldPerformAdditionalDelegateHandling = YES;
    
    
    UIApplicationShortcutItem *shortcutItem = [launchOptions objectForKey: UIApplicationLaunchOptionsShortcutItemKey];
    
    if (shortcutItem) {
        self.lanuchedShortcutItem = shortcutItem;
        
        // This will block "performActionForShortcutItem:completionHandler" from being called.
        shouldPerformAdditionalDelegateHandling = NO;
    }
    
    
    // Install initial versions of our two extra dynamic shortcuts.
    NSArray *shortcutItems = application.shortcutItems;
    if (shortcutItems.count == 0) {
        // Construct the items.
        
        UIApplicationShortcutItem *shortcut3 = [[UIMutableApplicationShortcutItem alloc] initWithType:[self convertToType:@"Third"] localizedTitle:@"Play" localizedSubtitle:@"Will Play an item" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay] userInfo:@{sApplicationShortcutUserInfoIconKey:[NSNumber numberWithInt:UIApplicationShortcutIconTypePlay]}];
        
        
        UIApplicationShortcutItem *shortcut4 = [[UIMutableApplicationShortcutItem alloc] initWithType:[self convertToType:@"Fourth"] localizedTitle:@"Pause" localizedSubtitle:@"Will Pause an item" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePause] userInfo:@{sApplicationShortcutUserInfoIconKey:[NSNumber numberWithInt:UIApplicationShortcutIconTypePause]}];
        
        
        application.shortcutItems = @[shortcut3, shortcut4];
        
    }
    
    
    
    
    return shouldPerformAdditionalDelegateHandling;
}





-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog(@"handle shortcutItem = %@", shortcutItem.type);
    
    
    [self handleShortCutItem:shortcutItem];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
