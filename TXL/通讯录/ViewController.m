//
//  ViewController.m
//  通讯录
//
//  Created by Macx on 2017/4/5.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ViewController.h"
#import "TXLController.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pswField;
@property (weak, nonatomic) IBOutlet UISwitch *pasSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

#define kDefault [NSUserDefaults standardUserDefaults]

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pasSwitch.on = [kDefault boolForKey:@"pasSwitch"];
    
    _autoSwitch.on = [kDefault boolForKey:@"autoSwitch"];
    
    if (_pasSwitch.on)
    {
        _loginButton.enabled = YES;
        
        _nameField.text = [kDefault objectForKey:@"nameField"];
        
        _pswField.text = [kDefault objectForKey:@"pswField"];
        
    }else
    {
        _loginButton.enabled = NO;
    }
    
    if (_autoSwitch.on)
    {
        [self click:_loginButton];
    }
    

    [_nameField addTarget:self action:@selector(edtting) forControlEvents:UIControlEventEditingChanged];
    [_pswField addTarget:self action:@selector(edtting) forControlEvents:UIControlEventEditingChanged];
     [_pasSwitch addTarget:self action:@selector(edtting) forControlEvents:UIControlEventTouchUpInside ];
    
    [_autoSwitch addTarget:self action:@selector(edttingAuto) forControlEvents:UIControlEventTouchUpInside ];
    
}

- (void)edtting
{
    _loginButton.enabled = _nameField.text.length && _pswField.text.length;
    
    if (!_pasSwitch.isOn)
    {
        [_autoSwitch setOn:NO animated:YES];
        
        [kDefault setBool:NO forKey:@"autoSwitch"];
    }
    [kDefault setBool:_pasSwitch.isOn forKey:@"pasSwitch"];
    
    [kDefault synchronize];
    
}
- (void)edttingAuto
{
    if (_autoSwitch.isOn)
    {
        [_pasSwitch setOn:YES animated:YES];
        
        [kDefault setBool:YES forKey:@"pasSwitch"];
    }
    [kDefault setBool:_autoSwitch.isOn forKey:@"autoSwitch"];
    
    [kDefault synchronize];
    
}

- (IBAction)click:(id)sender
{
    if ([_pswField.text isEqualToString:@"q"] && [_nameField.text isEqualToString:@"q"])
    {
        [kDefault setObject:_pswField.text forKey:@"pswField"];
        
        [kDefault setObject:_nameField.text forKey:@"nameField"];
        
        [kDefault synchronize];
        
        TXLController *con = [[TXLController alloc] init];
        
        con.navigationItem.title = [NSString stringWithFormat:@"%@的通讯录",_nameField.text];
        
        con.view.backgroundColor = [UIColor whiteColor];

        [self.navigationController pushViewController:con animated:YES];
    }

}


@end
