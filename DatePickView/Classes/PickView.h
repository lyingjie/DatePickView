//
//  PickView.h
//  dataMaster
//
//  Created by 李英杰 on 2017/11/21.
//  Copyright © 2017年 lyingjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UIView+Catgory.h"

// 屏幕宽度
#define kScreenW [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define kScreenH [UIScreen mainScreen].bounds.size.height

@class PickView;

@protocol PickViewDataSource <NSObject>

@required

- (NSInteger)numberOfComponentsInPickerView:(PickView *)pickerView;

- (NSInteger)pickerView:(PickView *)pickerView numberOfRowsInComponent:(NSInteger)component;

@end

@protocol PickViewDelegate <NSObject>

- (NSString *)pickerView:(PickView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

- (void)pickView:(PickView *)pickerView confirmButtonClick:(UIButton *)button;

@optional
- (NSAttributedString *)pickerView:(PickView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)componen;

- (void)pickerView:(PickView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;


@end

@interface PickView : UIView

@property (nonatomic, weak) id<PickViewDelegate> delegate;
@property (nonatomic, weak) id<PickViewDataSource> dataSource;
- (void)show;
- (void)dismiss;
// 选中某一行
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
// 获取当前选中的row
- (NSInteger)selectedRowInComponent:(NSInteger)component;

//刷新某列数据
-(void)pickReloadComponent:(NSInteger)component;
//刷新数据
-(void)reloadData;

@property (nonatomic, copy) NSString * titleStr;

@end
