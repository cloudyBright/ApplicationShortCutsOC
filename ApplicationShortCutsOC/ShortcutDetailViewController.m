//
//  ShortcutDetailViewController.m
//  ApplicationShortCutsOC
//
//  Created by cloudyBright on 15/12/4.
//  Copyright © 2015年 cloudyBright. All rights reserved.
//

#import "ShortcutDetailViewController.h"
#import "AppDelegate.h"

@interface ShortcutDetailViewController ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *subtitleTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (strong, nonatomic) NSMutableArray *pickerItems;

@property (strong, nonatomic) id<NSObject> textFieldObserverToken;

@end

@implementation ShortcutDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerItems = [NSMutableArray arrayWithArray:@[@"Copmpose", @"Play", @"Pause", @"Add", @"Location", @"Search", @"Share"]];
    
    UIApplicationShortcutItem *selectedShortcutItem = self.shortcutItem;
    NSAssert(selectedShortcutItem, @"The `selectedShortcutItem` was not set.");
   
    
    self.title = selectedShortcutItem.localizedTitle;
    
    self.titleTextField.text = selectedShortcutItem.localizedTitle;
    self.subtitleTextField.text = selectedShortcutItem.localizedSubtitle;
    
    id rawStr = selectedShortcutItem.userInfo[AppDelegate.applicationShortcutUserInfoIconKey];
    int iconRawValue = [rawStr intValue];
    
    UIApplicationShortcutIconType iconType = [self iconTypeForSelectedRow:iconRawValue];
    
    [self.pickerView selectRow:iconType inComponent:0 animated:NO];
    
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    self.textFieldObserverToken = [notificationCenter addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        if (!self) {
            return;
        }
        
        unsigned long titleTextLength = self.titleTextField.text.length;
        
        self.doneButton.enabled = titleTextLength > 0;
        
    }];
    
    
    
}

- (UIApplicationShortcutIconType)iconTypeForSelectedRow:(int)row
{
    
    if (row > 6) {
        return UIApplicationShortcutIconTypeCompose;
    }else{
        return row;
    }
    
    
}


-(void)dealloc
{
    if (self.textFieldObserverToken) {
        [[NSNotificationCenter defaultCenter] removeObserver:self.textFieldObserverToken];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIPickerviewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerItems.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerItems[row];
}




#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
