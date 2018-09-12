//
//  LabelAcrossRollingView.m
//  LabelRollingView
//
//  Created by onion on 2018/9/6.
//  Copyright © 2018年 onion. All rights reserved.
//

#import "LabelAcrossRollingView.h"

@interface LabelAcrossRollingView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LabelAcrossRollingView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
		self.layer.masksToBounds = YES;
		self.layer.cornerRadius = 15;
		[self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTextStringClick)]];
		
//		UIImageView *imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//		imgBg.image = [UIImage imageNamed:@"announcement_prompted"];
//		[self addSubview:imgBg];
		
		self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		self.titleLabel.textColor = [UIColor whiteColor];
		self.titleLabel.font = [UIFont systemFontOfSize:13];
		self.titleLabel.text = title;
		[self addSubview:self.titleLabel];
		
		[self showAnimations];
	}
	return self;
}

- (void)selectTextStringClick {
	if (self.selectTextString) {
		self.selectTextString(self.titleLabel.text);
	}
}

- (void)showAnimations {
	CGRect frame = self.titleLabel.frame;
	frame.origin.x = -self.frame.size.width+30;
	self.titleLabel.frame = frame;
	
	[UIView beginAnimations:@"testAnimation" context:NULL];
	[UIView setAnimationDuration:8.8f];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationRepeatAutoreverses:NO];
	[UIView setAnimationRepeatCount:999999];
	
	frame = self.titleLabel.frame;
	frame.origin.x = self.frame.size.width-30;
	self.titleLabel.frame = frame;
	[UIView commitAnimations];
}

@end
