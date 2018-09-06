//
//  LabelRollingView.h
//  onion
//
//  Created by MrJalen on 2018/9/6.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LabelRollingView;

@protocol LabelRollingDelegate <NSObject>

- (void)clickLabelRolling:(LabelRollingView *)labelRollingView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface LabelRollingView : UIView

@property (nonatomic, weak) id<LabelRollingDelegate> delegate;
@property (nonatomic, assign) CFTimeInterval rollingTimeInterval;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;

@end
