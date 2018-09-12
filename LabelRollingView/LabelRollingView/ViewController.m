//
//  ViewController.m
//  LabelRollingView
//
//  Created by MrJalen on 2018/9/6.
//  Copyright © 2018年 onion. All rights reserved.
//
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#import "ViewController.h"
#import "AnnouncementView.h"
#import "LabelAcrossRollingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
	
	NSArray *arr = @[@"1.紧急公告...", @"2.到货通知...", @"3.您有新订单生成..."];
	AnnouncementView *announcementView = [[AnnouncementView alloc] initWithFrame:CGRectMake(15, (kIsiPhoneX?88:64), kScreenWidth-30, 30)];
	announcementView.textArray = [NSMutableArray arrayWithArray:arr];
	announcementView.hidden = NO;
	[self.view addSubview:announcementView];
	[announcementView setSelectRollingIndex:^(NSInteger index) {
		NSLog(@"---选中了第 %ld 条公告---", (long)index+1);
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",arr[index]]
													   message:[NSString stringWithFormat:@"选中了第 %ld 条公告", (long)index+1]
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil, nil];
		[alert show];
	}];
	
	LabelAcrossRollingView *acrossRollingView = [[LabelAcrossRollingView alloc] initWithFrame:CGRectMake(15, announcementView.frame.origin.y+announcementView.frame.size.height+20, kScreenWidth-30, 30) title:@"生活不曾取悦于我，所以我创造了自己的生活！"];
	[self.view addSubview:acrossRollingView];
	[acrossRollingView setSelectTextString:^(NSString *textString) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
														message:textString
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil, nil];
		[alert show];
	}];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
