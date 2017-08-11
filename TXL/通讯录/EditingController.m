//
//  EditingController.m
//  通讯录
//
//  Created by Macx on 2017/4/5.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "EditingController.h"
#import "TXLModel.h"
@interface EditingController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *updateBut;
@property (nonatomic,weak) UIBarButtonItem *editBut;
@end

@implementation EditingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _nameField.enabled = NO;
    _phoneField.enabled = NO;
    _updateBut.enabled = NO;
    _nameField.text = self.model.name;
    _phoneField.text = self.model.phone;
    
    
    UIBarButtonItem *editBut = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editing)];
    
    self.navigationItem.rightBarButtonItem = editBut;
    
    _editBut = editBut;
    
}

//点击编辑按钮
- (void)editing
{
    _editBut.title = (_updateBut.isEnabled ? @"编辑":@"取消");
    
    if ([_editBut.title isEqualToString:@"取消"])
    {
        _nameField.enabled = YES;
        _phoneField.enabled = YES;
        _updateBut.enabled = YES;
        [_nameField becomeFirstResponder];
        
    }else
    {
        _nameField.text = self.model.name;
        _phoneField.text = self.model.phone;
        
        _nameField.enabled = NO;
        _phoneField.enabled = NO;
        _updateBut.enabled = NO;
        
    }
}

//点击更新按钮
- (IBAction)click:(id)sender
{
    
    TXLModel *model = [[TXLModel alloc] init];
    
    _model.name = _nameField.text;
    _model.phone = _phoneField.text;
    
    if ([self.delegate respondsToSelector:@selector(editingControllerWith:andModel:)])
    {
        [self.delegate editingControllerWith:self andModel:_model];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
