//
//  AppDelegate.h
//  ApplicationShortCutsOC
//
//  Created by cloudyBright on 15/12/3.
//  Copyright © 2015年 cloudyBright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


+(NSString*)applicationShortcutUserInfoIconKey;
+(void)setApplicationShortcutUserInfoIconKey:(NSString*)newValue;


@end

