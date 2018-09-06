//
//  LabelRollingView.m
//  onion
//
//  Created by MrJalen on 2018/9/6.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import "LabelRollingView.h"

static NSInteger const labelRollingViewTitleFont = 13;


@interface LabelRollingViewNormalCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LabelRollingViewNormalCell

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor clearColor];
		
		self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		self.titleLabel.textColor = [UIColor whiteColor];
		self.titleLabel.font = [UIFont systemFontOfSize:labelRollingViewTitleFont];
		[self.contentView addSubview:self.titleLabel];
	}
	return self;
}

@end


@interface LabelRollingView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSArray *bottomImageArr;
@property (nonatomic, strong) NSArray *bottomTitleArr;

@end

@implementation LabelRollingView

static NSInteger const labelRollingViewMaxSections = 100;
static NSString *const labelRollingViewNormalCell = @"labelRollingViewNormalCell";

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self initialization];
		[self setupSubviews];
	}
	return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	if (!newSuperview) {
		[self removeTimer];
	}
}

- (void)dealloc {
	_collectionView.delegate = nil;
	_collectionView.dataSource = nil;
}

- (void)initialization {
	_rollingTimeInterval = 3.0;
	[self addTimer];
}

- (void)setupSubviews {
	UIView *tempView = [[UIView alloc] initWithFrame:CGRectZero];
	[self addSubview:tempView];
	[self addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		_flowLayout = [[UICollectionViewFlowLayout alloc] init];
		_flowLayout.minimumLineSpacing = 0;
		
		_collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.scrollsToTop = NO;
		_collectionView.scrollEnabled = NO;
		_collectionView.pagingEnabled = YES;
		_collectionView.showsVerticalScrollIndicator = NO;
		_collectionView.backgroundColor = [UIColor clearColor];
		[_collectionView registerClass:[LabelRollingViewNormalCell class] forCellWithReuseIdentifier:labelRollingViewNormalCell];
	}
	return _collectionView;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	_flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
	_collectionView.frame = self.bounds;
	
	if (self.titleArr.count > 1) {
		[self defaultSelectedScetion];
	}
}

- (void)defaultSelectedScetion {
	[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0.5 * labelRollingViewMaxSections] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

#pragma mark - UICollectionViewdataSource、delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return labelRollingViewMaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	LabelRollingViewNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:labelRollingViewNormalCell forIndexPath:indexPath];
	cell.titleLabel.text = self.titleArr[indexPath.item];
	
	if (self.textAlignment) {
		cell.titleLabel.textAlignment = self.textAlignment;
	}
	if (self.titleFont) {
		cell.titleLabel.font = self.titleFont;
	}
	if (self.titleColor) {
		cell.titleLabel.textColor = self.titleColor;
	}
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if (self.delegate && [self.delegate respondsToSelector:@selector(clickLabelRolling:didSelectedItemAtIndex:)]) {
		[self.delegate clickLabelRolling:self didSelectedItemAtIndex:indexPath.item];
	}
}

#pragma mark - - - NSTimer
- (void)addTimer {
	[self removeTimer];
	
	self.timer = [NSTimer timerWithTimeInterval:self.rollingTimeInterval target:self selector:@selector(beginUpdateUI) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
	[_timer invalidate];
	_timer = nil;
}

- (void)beginUpdateUI {
	if (self.titleArr.count == 0) return;
	
	// 1、当前正在展示的位置
	NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
	
	// 马上显示回最中间那组的数据
	NSIndexPath *resetCurrentIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0.5 * labelRollingViewMaxSections];
	[self.collectionView scrollToItemAtIndexPath:resetCurrentIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
	
	// 2、计算出下一个需要展示的位置
	NSInteger nextItem = resetCurrentIndexPath.item + 1;
	NSInteger nextSection = resetCurrentIndexPath.section;
	if (nextItem == self.titleArr.count) {
		nextItem = 0;
		nextSection++;
	}
	
	NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
	
	// 3、通过动画滚动到下一个位置
	[self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

#pragma mark - - - setting
- (void)setTitles:(NSMutableArray *)titles {
	_titles = titles;
	if (titles.count > 1) {
		[self addTimer];
	} else {
		[self removeTimer];
	}
	
	self.titleArr = [NSMutableArray arrayWithArray:titles];
	[self.collectionView reloadData];
}

- (void)setTitleFont:(UIFont *)titleFont {
	_titleFont = titleFont;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
	_textAlignment = textAlignment;
}

- (void)setRollingTimeInterval:(CFTimeInterval)rollingTimeInterval {
	_rollingTimeInterval = rollingTimeInterval;
	if (rollingTimeInterval) {
		[self addTimer];
	}
}

@end
