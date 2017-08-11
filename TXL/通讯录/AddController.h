//
//  AddController.h
//  通讯录
//
//  Created by Macx on 2017/4/5.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddController,TXLModel;

@protocol AddControllerDelegate <NSObject>

- (void)addControllerWith:(AddController *)AddController andModel:(TXLModel *)model;

@end


@interface AddController : UIViewController

@property (nonatomic,weak) id<AddControllerDelegate> delegate;

@end
