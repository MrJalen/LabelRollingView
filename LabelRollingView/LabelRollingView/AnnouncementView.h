//
//  AnnouncementView.h
//  onion
//
//  Created by MrJalen on 2018/9/6.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnouncementView : UIView

@property (nonatomic, copy) void(^selectRollingIndex)(NSInteger index);
@property (nonatomic, strong) NSMutableArray *textArray;

@end
