//
//  DatePickView.h
//  dataMaster
//
//  Created by 李英杰 on 2017/11/17.
//  Copyright © 2017年 lyingjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickView.h"

@protocol DatePickViewDelegate <NSObject>

- (void)DatePickselectTimeYYMMDD:(NSString *)dateTime;

@end

@interface DatePickView : UIView

//透明背景
@property (nonatomic,strong) UIView * grayOverView;

//白色背景
@property (nonatomic,strong) UIView * whiteOverView;

//取消按钮
@property (nonatomic,strong) UIButton * cancleButton;

//确定按钮
@property (nonatomic,strong) UIButton * sureButton;

//日历
@property (nonatomic,strong) UIDatePicker * pickerDate;

/**
 起始时间
 */
@property (nonatomic,copy) NSString * starTime;

/**
 结束时间
 */
@property (nonatomic,copy) NSString * endTime;

@property (nonatomic,assign) id<DatePickViewDelegate> delegate;

/**
 移除
 */
- (void)dismiss;

/**
 显示
 */
-(void)show;

@end
