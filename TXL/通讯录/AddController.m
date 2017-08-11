//
//  AddController.m
//  通讯录
//
//  Created by Macx on 2017/4/5.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "AddController.h"
#import "TXLModel.h"
@interface AddController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation AddController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _saveButton.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addContact) name:UITextFieldTextDidChangeNotification object:nil];
    
 
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)addContact
{
    _saveButton.enabled = _nameField.text.length && _phoneField.text.length;
}


//保存按钮,以及代理
- (IBAction)click:(id)sender
{
    TXLModel *model = [[TXLModel alloc] init];
    
    model.name  = _nameField.text;
    model.phone = _phoneField.text;
    
    if ([self.delegate respondsToSelector:@selector(addControllerWith:andModel:)])
    {
        [self.delegate addControllerWith:self andModel:model];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
