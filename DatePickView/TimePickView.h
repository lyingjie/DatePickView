//
//  TimePickView.h
//  lhcx_official
//
//  Created by 李英杰 on 2018/1/10.
//  Copyright © 2018年 赵永杰. All rights reserved.
//

#import "PickView.h"

@protocol TimePickViewDelegate <NSObject>

- (void)timePickHasSlectTime:(NSString *)selectTime WeekStr:(NSString *)weekStr TimeStr:(NSString *)timeStr;

@end

@interface TimePickView : UIView

@property (nonatomic, weak) id<TimePickViewDelegate>delegate;

- (void)show;
- (void)dismiss;

@property (nonatomic, copy) NSString * titleStr;

@end
