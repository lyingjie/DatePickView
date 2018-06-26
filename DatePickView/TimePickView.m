//
//  TimePickView.m
//  lhcx_official
//
//  Created by 李英杰 on 2018/1/10.
//  Copyright © 2018年 赵永杰. All rights reserved.
//

#import "TimePickView.h"

@interface TimePickView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIView *naviContainView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIPickerView *pickView;

@property (nonatomic, strong) UIButton *bgBtn;

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, assign) NSInteger currentSelectDay;

@property (nonatomic, strong) NSDictionary * dateDic;

@property (nonatomic,copy) NSString * weekStr;
@property (nonatomic,copy) NSString * timeStr;

@property (nonatomic, strong) NSString * selectTime;

@end

@implementation TimePickView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildViews];
    }
    return self;
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}

- (void)setupChildViews {
    
    [self addSubview:self.bgBtn];
    [self addSubview:self.mainView];
    
    [self.mainView addSubview:self.naviContainView];
    [self.naviContainView addSubview:self.cancelBtn];
    [self.naviContainView addSubview:self.titleLabel];
    [self.naviContainView addSubview:self.confirmBtn];
    [self.mainView addSubview:self.pickView];
    
    [self.bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.mainView setFrame:CGRectMake(0, kScreenH, kScreenW, 260)];
    
    [self.naviContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.mainView);
        make.height.mas_equalTo(44);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.equalTo(self.naviContainView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.naviContainView);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.equalTo(self.naviContainView);
    }];
    
    [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naviContainView.mas_bottom);
        make.left.right.bottom.equalTo(self.mainView);
    }];
}

#pragma mark - private methods

- (void)cancelAction:(UIButton *)btn {
    [self dismiss];
}

- (void)confirmAction:(UIButton *)btn {
    [self dismiss];
    
    NSInteger left = [self selectedRowInComponent:0];
    NSInteger right = [self selectedRowInComponent:1];
    
    self.selectTime = [self getTimeString:[[self.dateDic[@"time"] objectAtIndex:left] objectAtIndex:right] format:@"yyyy-MM-dd HH:mm:ss"];
        
    if ([self.delegate respondsToSelector:@selector(timePickHasSlectTime:WeekStr:TimeStr:)]) {
        [self.delegate timePickHasSlectTime:self.selectTime WeekStr:self.weekStr TimeStr:self.timeStr];
    }
}


-(NSString *)getTimeString:(NSDate *)date format:(NSString *)dateFormatStr{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = dateFormatStr;
    return [format stringFromDate:date];
}


#pragma mark - public methods

- (void)show {
    
    self.bgBtn.alpha = 0.3;
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.y = kScreenH - 260;
    }];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.y = kScreenH;
        self.bgBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    [self.pickView selectRow:row inComponent:component animated:animated];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component {
    return [self.pickView selectedRowInComponent:component];
}

#pragma mark - UIPickViewDelegate, UIPickViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [self.dateDic[@"week"] count];
    }else{
        NSInteger whichWeek = [pickerView selectedRowInComponent:0];
        return [[self.dateDic[@"time"] objectAtIndex:whichWeek] count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0){
        return self.dateDic[@"week"][row];
    }else{
        NSArray *arr = [[self.dateDic objectForKey:@"time"] objectAtIndex:self.currentSelectDay];
        NSDate *date = [arr objectAtIndex:row];
        NSString *str = [self getTimeString:date format:@"HH:mm"];
        return str;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(component == 0){
        self.currentSelectDay = [pickerView selectedRowInComponent:0];
        [self pickReloadComponent:1];
        self.weekStr = self.dateDic[@"week"][row];
        NSArray *arr = [[self.dateDic objectForKey:@"time"] objectAtIndex:self.currentSelectDay];
        NSDate *date = [arr objectAtIndex:[pickerView selectedRowInComponent:1]];
        self.timeStr = [self getTimeString:date format:@"HH:mm"];
    }else{
        NSInteger whichWeek = [pickerView selectedRowInComponent:0];
        NSDate *date = [[self.dateDic[@"time"] objectAtIndex:whichWeek] objectAtIndex:row];
        self.timeStr = [self getTimeString:date format:@"HH:mm"];
    }
}


#pragma mark - getter methods

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn sizeToFit];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_confirmBtn sizeToFit];
        
    }
    return _confirmBtn;
}

- (UIView *)naviContainView {
    if (!_naviContainView) {
        _naviContainView = [[UIView alloc] init];
        _naviContainView.backgroundColor = [UIColor whiteColor];
    }
    return _naviContainView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"title";
        _titleLabel.textColor = UIColor.redColor;
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

- (UIPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] init];
        _pickView.delegate = self;
        _pickView.dataSource = self;
    }
    return _pickView;
}

- (UIButton *)bgBtn {
    if (!_bgBtn) {
        _bgBtn = [[UIButton alloc] init];
        _bgBtn.backgroundColor = [UIColor blackColor];
        _bgBtn.alpha = 0.3;
        [_bgBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

-(NSDictionary *)dateDic{
    if (!_dateDic) {
        _dateDic = [self getStratTime:0];
        self.weekStr = self.dateDic[@"week"][0];
        NSDate *date  = [[self.dateDic[@"time"] objectAtIndex:0] objectAtIndex:0];
        self.timeStr = [self getTimeString:date format:@"HH:mm"];
    }
    return _dateDic;
}

-(void)pickReloadComponent:(NSInteger)component{
    [self.pickView reloadComponent:component];
}

-(void)reloadData{
    [self.pickView reloadAllComponents];
}

-(NSDictionary *)getStratTime:(NSInteger)aheadHour{
    // 获取当前date
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDictionary *weekDict = @{@"2" : @"周一", @"3" : @"周二", @"4" : @"周三", @"5" : @"周四", @"6" : @"周五", @"7" : @"周六", @"1" : @"周日"};
    // 日期格式
    NSDateFormatter *fullFormatter = [[NSDateFormatter alloc] init];
    fullFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    // 获取当前几时(晚上23点要把今天的时间做处理)
    NSInteger currentHour = [calendar component:NSCalendarUnitHour fromDate:date];
    // 存放周几和时间的数组
    NSMutableArray *weekStrArr = [NSMutableArray array];
    NSMutableArray *detailTimeArr = [NSMutableArray array];
    // 设置合适的时间
    for (int i = 0; i < 14; i++) {
        NSDate *new = [calendar dateByAddingUnit:NSCalendarUnitDay value:i toDate:date options:NSCalendarMatchStrictly];
        NSInteger week = [calendar component:NSCalendarUnitWeekday fromDate:new];
        // 周几
        NSString *weekStr = weekDict[[NSString stringWithFormat:@"%ld",week]];
        NSString *todayOrOther = @"";
        if (i == 0) {
            todayOrOther = @"今天";
        }else if (i == 1) {
            todayOrOther = @"明天";
        }else if (i == 2){
            todayOrOther = @"后天";
        }else{
            todayOrOther = [self getTimeString:new format:@"MM-dd"];
        }
        // 今天周几 明天周几 后天周几
        NSString *resultWeekStr = [NSString stringWithFormat:@"%@ %@",todayOrOther,weekStr];
        [weekStrArr addObject:resultWeekStr];
        
        NSInteger year = [calendar component:NSCalendarUnitYear fromDate:new];
        NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:new];
        NSInteger day = [calendar component:NSCalendarUnitDay fromDate:new];
        
        // 把符合条件的时间筛选出来
        int startHour = aheadHour > 0 ? 0 : 0;
        int endHour = aheadHour > 0 ? 24 : 24;
        NSMutableArray *smallArr = [NSMutableArray array];
        for (int hour = startHour; hour < endHour; hour++) {
            for (int min = 0; min < 60; min ++) {
                if (min % 15 == 0) {
                    NSString *tempDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld %d:%d",year,month,day,hour,min];
                    NSDate *tempDate = [fullFormatter dateFromString:tempDateStr];
                    // 今天 之后的时间段
                    if (i == 0) {
                        NSDateComponents * components = [[NSDateComponents alloc] init];
                        components.hour = aheadHour;
                        // 提前30分钟
                        components.minute = 30;
                        NSDate *usefulDate = [calendar dateByAddingComponents:components toDate:date options:NSCalendarMatchStrictly];
                        
                        if ([calendar compareDate:tempDate toDate:usefulDate toUnitGranularity:NSCalendarUnitMinute] == 1) {
                            
                            [smallArr addObject:tempDate];
                        }
                    }else{
                        [smallArr addObject:tempDate];
                    }
                }
            }
        }
        
        [detailTimeArr addObject:smallArr];
    }
    // 第一天
    if ([detailTimeArr.firstObject count] == 0) {
        [weekStrArr removeObjectAtIndex:0];
        [detailTimeArr removeObjectAtIndex:0];
    }
    // 晚上23点把今天对应的周几和今天的时间空数组去掉
    if (currentHour == 23) {
        [weekStrArr removeObjectAtIndex:0];
        [detailTimeArr removeObjectAtIndex:0];
    }
    NSDictionary *resultDic = @{@"week" : weekStrArr , @"time" : detailTimeArr};
    return resultDic;
}


@end
