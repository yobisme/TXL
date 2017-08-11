//
//  EditingController.h
//  通讯录
//
//  Created by Macx on 2017/4/5.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TXLModel,EditingController;


@protocol EditingControllerDelegate <NSObject>

- (void)editingControllerWith:(EditingController *)controller andModel:(TXLModel *)model;

@end


@interface EditingController : UIViewController

@property (nonatomic,strong)TXLModel *model;

@property (nonatomic,weak)id<EditingControllerDelegate > delegate;

@end
