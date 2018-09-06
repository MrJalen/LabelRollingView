//
//  AnnouncementView.m
//  onion
//
//  Created by MrJalen on 2018/9/6.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import "AnnouncementView.h"
#import "LabelRollingView.h"

@interface AnnouncementView () <LabelRollingDelegate> {
	
}

@end

@implementation AnnouncementView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.hidden = YES;
	}
	return self;
}

- (void)setTextArray:(NSMutableArray *)textArray {
	_textArray = textArray;
	
	self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
	self.layer.masksToBounds = YES;
	self.layer.cornerRadius = 15;
	
//	UIImageView *imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//	imgBg.image = [UIImage imageNamed:@"announcement_prompted"];
//	[self addSubview:imgBg];
	
	UIImageView *annImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 18, 18)];
	annImg.image = [UIImage imageNamed:@"announcement"];
	[self addSubview:annImg];
	
	LabelRollingView *rollingView = [[LabelRollingView alloc] initWithFrame:CGRectMake(35, 5, self.frame.size.width - 60, 20)];
	rollingView.titles = _textArray;
	rollingView.titleFont = [UIFont systemFontOfSize:14];
	rollingView.delegate = self;
	[self addSubview:rollingView];
	
	UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-22, 9, 12, 12)];
	arrowImg.image = [UIImage imageNamed:@"arrow_image"];
	[self addSubview:arrowImg];
}

#pragma mark - LabelRollingDelegate
- (void)clickLabelRolling:(LabelRollingView *)labelRollingView didSelectedItemAtIndex:(NSInteger)index {
	if (self.selectRollingIndex) {
		self.selectRollingIndex(index);
	}
}

@end
