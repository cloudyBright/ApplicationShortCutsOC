//
//  ShortcutsTableViewController.h
//  ApplicationShortCutsOC
//
//  Created by cloudyBright on 15/12/4.
//  Copyright © 2015年 cloudyBright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShortcutsTableViewController : UITableViewController


@property(nonatomic, strong) NSMutableArray * staticShortcuts;
@property(nonatomic, strong) NSMutableArray * dynamicShortcuts;


-(IBAction)cancel:(UIStoryboardSegue*)sender;
-(IBAction)done:(UIStoryboardSegue*)sender;


@end
