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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
	
	AnnouncementView *announcementView = [[AnnouncementView alloc] initWithFrame:CGRectMake(15, (kIsiPhoneX?88:64), kScreenWidth-30, 30)];
	announcementView.textArray = [NSMutableArray arrayWithArray:@[@"1.紧急公告...", @"2.到货通知...", @"3.您有新订单生成..."]];
	announcementView.hidden = NO;
	[self.view addSubview:announcementView];
	[announcementView setSelectRollingIndex:^(NSInteger index) {
		NSLog(@"---选中了第 %ld 条公告---", (long)index);
	}];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
