//
//  TXLController.m
//  通讯录
//
//  Created by Macx on 2017/4/5.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "TXLController.h"
#import "AddController.h"
#import "TXLTableViewCell.h"
#import "TXLModel.h"
#import "EditingController.h"

@interface TXLController ()<AddControllerDelegate,EditingControllerDelegate>
@property (nonatomic,copy) NSMutableArray *arrayM;
@property (nonatomic,weak) UIBarButtonItem *editBut;
@property (nonatomic,weak) UIBarButtonItem *cancelBut;

@end

@implementation TXLController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *cancelBut = [[UIBarButtonItem alloc] initWithTitle:@"撤销" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    UIBarButtonItem *editBut = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStyleDone target:self action:@selector(editting)];
    
    UIBarButtonItem *addBut = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    
    self.navigationItem.rightBarButtonItems = @[addBut,editBut];
    
    self.navigationItem.leftBarButtonItem = cancelBut;
    
    [self.tableView registerClass:[TXLTableViewCell class] forCellReuseIdentifier:@"hehe"];
    
    _editBut = editBut;
    
    editBut.enabled = NO;
    
    self.tableView.tableFooterView = [UIView new];
    
    _cancelBut = cancelBut;
    
}


//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EditingController *con = [[EditingController alloc] init];
    
    [self.navigationController pushViewController:con animated:YES];
    
    TXLModel *model = self.arrayM[indexPath.row];
    
    con.model = model;
    
    con.delegate = self;
    
    self.tableView.tintColor = [UIColor orangeColor];
    
}

//更新之后的代理方法
- (void)editingControllerWith:(EditingController *)controller andModel:(TXLModel *)model
{
    NSInteger index = [self.arrayM indexOfObject:model];
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]withRowAnimation:UITableViewRowAnimationLeft];
  
}


//能出现左划删除的状态
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //点击移除按钮,移除该行
        [self.arrayM removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        
        //重新判断ediBut按钮的可点击状态
          _editBut.enabled = self.arrayM.count;
    }
}


//删除和取消两种Action
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *cancelAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"取消" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        tableView.editing = NO;
        
    }];
    
    UITableViewRowAction *deletelAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.arrayM removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        
        //重新判断ediBut按钮的可点击状态
        _editBut.enabled = self.arrayM.count;
    }];

    NSArray *arr = @[cancelAction,deletelAction];
    
    return arr;
}

//顺序改变
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.arrayM exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}


//编辑按钮
- (void)editting
{
    //编辑状态
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    
    //按钮的文字发生变化,当处于编辑状态时时Edit,当未处于编辑时是Done
    _editBut.title = (self.tableView.isEditing ? @"Done":@"Edit");
    
}

//添加按钮
- (void)add
{
    
    AddController *con = [[AddController alloc] init];
    
    con.delegate = self;

    [self.navigationController pushViewController:con animated:YES];
    
}

//实现代理方法
- (void)addControllerWith:(AddController *)AddController andModel:(TXLModel *)model
{
        [self.arrayM addObject:model];
    //刷新数据
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.arrayM.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    
     _editBut.enabled = self.arrayM.count;
   
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TXLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hehe" forIndexPath:indexPath];
    
    TXLModel *model = self.arrayM[indexPath.row];
    
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.phone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    return cell;
}

- (NSMutableArray *)arrayM
{
    
    if (_arrayM == nil)
    {
        _arrayM = [NSMutableArray array];
    }
    
    return _arrayM;
}



//撤销弹框
- (void)cancel
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"是否离开" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *goAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
   
    [alert addAction:goAction];
    
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    
    
}
@end
