//
//  SalesmanPickView.h
//  BeeBack
//
//  Created by 李英杰 on 2018/5/21.
//  Copyright © 2018年 Levante. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickView.h"

@protocol SingleLinePickViewDelegate <NSObject>

-(void)singleLinePickViewHasSelect:(id)selected and:(id)sender;

-(void)singleLinePickViewWillDismiss;

@end

@interface SingleLinePickView : UIView

@property (nonatomic, weak) id<SingleLinePickViewDelegate>delegate;

- (void)showWith:(NSArray *)dataArray andShowkey:(NSString *)key;
- (void)dismiss;

@property (nonatomic, copy) NSString * titleStr;

@end
