//
//  UIView+Catgory.h
//  DatePickView
//
//  Created by 李英杰 on 2018/6/26.
//  Copyright © 2018年 liyingjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Catgory)

@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;

- (UIViewController *)hl_getCurrentViewController;


@end
