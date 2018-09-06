# LabelRollingView

# 示例图
![image](https://github.com/MrJalen/LabelRollingView/raw/master/LabelRollingView/LabelRollingView/labelRolling.gif)

1. 单行文本广告轮播 
# LabelRollingView

```Objective-C
AnnouncementView *announcementView = [[AnnouncementView alloc] initWithFrame:CGRectMake(15, (kIsiPhoneX?88:64), kScreenWidth-30, 30)];
announcementView.textArray = [NSMutableArray arrayWithArray:@[@"1.紧急公告...", @"2.到货通知...", @"3.您有新订单生成..."]];
announcementView.hidden = NO;
[self.view addSubview:announcementView];
[announcementView setSelectRollingIndex:^(NSInteger index) {
	NSLog(@"---选中了第 %ld 条公告---", (long)index+1);
		
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
						message:[NSString stringWithFormat:@"选中了第 %ld 条公告", (long)index+1]
						delegate:nil
						cancelButtonTitle:@"确定"
						otherButtonTitles:nil, nil];
	[alert show];
}];
```

2. 单行文本横向滚动 
# LabelAcrossRollingView

```Objective-C
LabelAcrossRollingView *acrossRollingView = [[LabelAcrossRollingView alloc] initWithFrame:CGRectMake(15, announcementView.frame.origin.y+announcementView.frame.size.height+20, kScreenWidth-30, 30) title:@"生活不曾取悦于我，所以我创造了自己的生活！"];
[self.view addSubview:acrossRollingView];
```
