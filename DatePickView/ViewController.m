//
//  ViewController.m
//  DatePickView
//
//  Created by 李英杰 on 2018/6/26.
//  Copyright © 2018年 liyingjie. All rights reserved.
//

#import "ViewController.h"
#import "PickView.h"
#import "DatePickView.h"
#import "TimePickView.h"
#import "SingleLinePickView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *timeButton;
@property (nonatomic, strong) UIButton *dateButton;
@property (nonatomic, strong) UIButton *singalButton;

@property (nonatomic, strong) DatePickView *datePickView;
@property (nonatomic, strong) SingleLinePickView *pickView;
@property (nonatomic, strong) TimePickView *timePickView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.timeButton];
    [self.view addSubview:self.singalButton];
    [self.view addSubview:self.dateButton];
    
    [@[self.timeButton,self.dateButton,self.singalButton] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:100 leadSpacing:20 tailSpacing:20];
    [@[self.timeButton,self.dateButton,self.singalButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
}

-(void)timeAction{
    [[UIApplication sharedApplication].keyWindow addSubview:self.timePickView];
    [self.timePickView show];
}

-(void)dateAction{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.datePickView];
    [self.datePickView show];
}
-(void)singleAction{
    [[UIApplication sharedApplication].keyWindow addSubview:self.pickView];
    [self.pickView showWith:@[@"0",@"1",@"2",@"3",@"4"] andShowkey:@""];
}


-(UIButton *)timeButton{
    if (!_timeButton) {
        _timeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_timeButton setTitle:@"time" forState:UIControlStateNormal];
        
        [_timeButton sizeToFit];
        [_timeButton addTarget:self action:@selector(timeAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _timeButton;
}

-(UIButton *)dateButton{
    if (!_dateButton) {
        _dateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_dateButton setTitle:@"date" forState:UIControlStateNormal];
        [_dateButton sizeToFit];
        [_dateButton addTarget:self action:@selector(dateAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dateButton;
}

-(UIButton *)singalButton{
    if (!_singalButton) {
        _singalButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_singalButton setTitle:@"singal" forState:UIControlStateNormal];
        [_singalButton sizeToFit];
        [_singalButton addTarget:self action:@selector(singleAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _singalButton;
}

-(DatePickView *)datePickView{
    if (!_datePickView) {
        _datePickView = [[DatePickView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    }
    return _datePickView;
}
-(TimePickView *)timePickView{
    if (!_timePickView) {
        _timePickView = [[TimePickView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    }
    return _timePickView;
}
-(SingleLinePickView *)pickView{
    if (!_pickView) {
        _pickView = [[SingleLinePickView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    }
    return _pickView;
}


@end
