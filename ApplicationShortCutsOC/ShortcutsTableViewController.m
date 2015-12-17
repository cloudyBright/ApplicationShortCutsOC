//
//  ShortcutsTableViewController.m
//  ApplicationShortCutsOC
//
//  Created by cloudyBright on 15/12/4.
//  Copyright © 2015年 cloudyBright. All rights reserved.
//

#import "ShortcutsTableViewController.h"
#import "ShortcutDetailViewController.h"

@interface ShortcutsTableViewController ()

@end

@implementation ShortcutsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(NSMutableArray *)staticShortcuts
{
    
    if (_staticShortcuts) {
        return _staticShortcuts;
    }
    
    // Obtain the `UIApplicationShortcutItems` array from the Info.plist. If unavailable, there are no static shortcuts.
    NSMutableArray *shortcuts = [[NSBundle mainBundle].infoDictionary objectForKey:@"UIApplicationShortcutItems"];
    if (shortcuts == nil) {
        return  [NSMutableArray array];
    }
    
    NSMutableArray *shortcutItems = [NSMutableArray array];
    
    // Use `flatMap(_:)` to process each dictionary into a `UIApplicationShortcutItem`, if possible.
    for (NSDictionary *shortcut in shortcuts) {
        NSString *shortcutType = shortcut[@"UIApplicationShortcutItemType"];
        NSString *shortcutTitle = shortcut[@"UIApplicationShortcutItemTitle"];
        if ( !shortcutType || !shortcutTitle ) {
            return  [NSMutableArray array];
        }
        
        id localizedTitle = [NSBundle mainBundle].localizedInfoDictionary[shortcutTitle];
        if ([localizedTitle isKindOfClass:[NSString class]]) {
            shortcutTitle = localizedTitle;
        }
        
        id shortcutSubtitle = shortcut[@"UIApplicationShortcutItemSubtitle"];
        if ([shortcutSubtitle isKindOfClass:[NSString class]]) {
            shortcutSubtitle = [NSBundle mainBundle].localizedInfoDictionary[shortcutSubtitle];
        }
        
        UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:shortcutType localizedTitle:shortcutTitle localizedSubtitle:shortcutSubtitle icon:nil userInfo:nil];
        
        [shortcutItems addObject:item];
        
        
    }
    
    _staticShortcuts = shortcutItems;
    
    return _staticShortcuts;
    
}


-(NSMutableArray *)dynamicShortcuts
{
    
    if (_dynamicShortcuts) {
        return _dynamicShortcuts;
    }
    
    NSMutableArray *dShortcuts = [NSMutableArray arrayWithArray:[UIApplication sharedApplication].shortcutItems];
    
    if (dShortcuts) {
        
        _dynamicShortcuts = dShortcuts;
        return dShortcuts;
    }
    
    
    
    return [NSMutableArray array];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @[@"Static", @"Dynamic"][section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return section == 0 ? self.staticShortcuts.count : self.dynamicShortcuts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    
    
    UIApplicationShortcutItem *shortcut;
    
    if (indexPath.section == 0) {
        shortcut = self.staticShortcuts[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        shortcut = self.dynamicShortcuts[indexPath.row];
    }
    
    
    cell.textLabel.text = shortcut.localizedTitle;
    cell.detailTextLabel.text = shortcut.localizedSubtitle;
    
    return cell;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
   
    if ([segue.identifier isEqualToString:@"ShowShortcutDetail"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        ShortcutDetailViewController* controller = segue.destinationViewController;
        if (![controller isMemberOfClass:[ShortcutDetailViewController class]]) {
            controller = nil;
        }
        
        if (!indexPath || !controller) {
            return;
        }
        
        controller.shortcutItem = _dynamicShortcuts[indexPath.row];
        
    }
    
}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    // Block navigating to detail view controller for static shortcuts (which are not editable).
    
    NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
    
    if (!selectedIndexPath) {
        return false;
    }
    
    
    return selectedIndexPath.section > 0;
    
}


#pragma mark - Actions
-(IBAction)cancel:(UIStoryboardSegue*)sender
{
    
}

-(IBAction)done:(UIStoryboardSegue*)sender
{
    ShortcutDetailViewController *sourceViewController = sender.sourceViewController;
    NSIndexPath *selected = self.tableView.indexPathForSelectedRow;
    UIApplicationShortcutItem  *updateShortcutItem = sourceViewController.shortcutItem;
    
    
    if (![sourceViewController isMemberOfClass:[ShortcutDetailViewController class]] || !selected || !updateShortcutItem) {
        
        return;
    }
    
    
    
    
    self.dynamicShortcuts[selected.row] = updateShortcutItem;
    
    [UIApplication sharedApplication].shortcutItems = _dynamicShortcuts;
    
    [self.tableView reloadRowsAtIndexPaths:@[selected] withRowAnimation:UITableViewRowAnimationAutomatic];
    

}




@end


























