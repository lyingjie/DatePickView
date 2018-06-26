//
//  DatePickView.m
//  dataMaster
//
//  Created by 李英杰 on 2017/11/17.
//  Copyright © 2017年 lyingjie. All rights reserved.
//

#import "DatePickView.h"

@interface DatePickView()

//当前控制器选择的时间
@property (nonatomic,copy) NSString * nowSelectTime;

@end


@implementation DatePickView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.grayOverView];
        [self.grayOverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(kScreenH);
        }];
        
        [self addSubview:self.whiteOverView];
        self.whiteOverView.frame = CGRectMake(0, kScreenH, kScreenW, 260);
        
        [self.whiteOverView addSubview:self.cancleButton];
        [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(60, 40));
        }];
        [self.whiteOverView addSubview:self.sureButton];
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(60, 40));
        }];
        [self.whiteOverView addSubview:self.pickerDate];
        [self.pickerDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(@40);
            make.height.equalTo(@200);
        }];
    }
    
    return self;
}

-(UIView *)grayOverView{
    if(!_grayOverView){
        _grayOverView = [[UIView alloc]init];
        _grayOverView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        _grayOverView.alpha = 0.0;
        _grayOverView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [_grayOverView addGestureRecognizer:tap];
    }
    
    return _grayOverView;
}

-(UIView *)whiteOverView{
    if(!_whiteOverView){
        _whiteOverView = [[UIView alloc]init];
        _whiteOverView.backgroundColor = [UIColor whiteColor];
    }
    
    return _whiteOverView;
}

-(UIButton *)cancleButton{
    if(!_cancleButton){
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancleButton setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancleButton;
}

- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.grayOverView.alpha = 0.0;
        self.whiteOverView.y = kScreenH;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)show{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.whiteOverView.y = kScreenH - 260;
        self.grayOverView.alpha = 0.4;
    }];
    
    /*
     return;
     [UIView animateWithDuration:0.1 animations:^{
     
     self.grayOverView.alpha = 0.4;
     
     } completion:^(BOOL finished) {
     [UIView animateWithDuration:0.3 animations:^{
     self.whiteOverView.y = kScreenH - 260;
     }];
     }];
     */
}

-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureButton setTitle:@"确认" forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sureButton;
}

- (void)sureAction:(UIButton *)button{
    NSLog(@"确认");
    if ([self.delegate respondsToSelector:@selector(DatePickselectTimeYYMMDD:)]) {
        [self.delegate DatePickselectTimeYYMMDD:self.nowSelectTime];
    }
    [self dismiss];
}

- (UIDatePicker *)pickerDate{
    if(!_pickerDate){
        _pickerDate = [ [ UIDatePicker alloc] init];
        _pickerDate.datePickerMode = UIDatePickerModeDate;
        
        NSLocale * locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        _pickerDate.locale = locale;
        
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        
        [formatter1 setDateFormat:@"yyyy-MM-dd"];//此处使用的formater格式要与字符串格式完全一致，否则转换失败
        
        [formatter1 setTimeZone:[NSTimeZone localTimeZone]];//将字符串转换成日期
        
        //设置初始
        _pickerDate.date = [NSDate date];
        
        self.nowSelectTime = [formatter1 stringFromDate:[NSDate date]];
        
        _pickerDate.minimumDate = [formatter1 dateFromString:self.starTime.length == 0 ? @"1950-01-01" : self.starTime];
        
        //        _pickerDate.maximumDate = (self.endTime.length == 0 ? [NSDate date] : [formatter1 dateFromString: self.endTime]);
        
        [_pickerDate addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _pickerDate;
}

-(void)changeTime:(UIDatePicker *)picker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    self.nowSelectTime = [dateFormatter stringFromDate:picker.date];
    
//    NSLog(@"%@",self.nowSelectTime);
}


@end
