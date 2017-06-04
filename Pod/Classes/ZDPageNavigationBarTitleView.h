//
//  ZDPageNavigationBarTitleView.h
//  Pods
//
//  Created by 0day on 15/5/28.
//
//

#import <UIKit/UIKit.h>

@class ZDPageNavigationBarTitleView;
@protocol ZDPageNavigationBarTitleViewDataSource <NSObject>

@required
- (NSUInteger)numberOfTitles;
- (NSString *)titleAtIndex:(NSUInteger)index;
- (UIView *)titleViewAtIndex:(NSUInteger)index;
- (BOOL)shouldUsingTitleView;

@end

@interface ZDPageNavigationBarTitleView : UIView

@property (nonatomic, weak) UINavigationBar *navigationBar;

@property (nonatomic, strong) UIColor       *maskColor;
@property (nonatomic, assign) NSUInteger    currentIndex;
@property (nonatomic, assign) CGFloat       percent;
@property (nonatomic, weak) id<ZDPageNavigationBarTitleViewDataSource> dataSource;
@property (nonatomic, assign) CGRect    titleViewBounds;


- (instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar titleViewBounds:(CGRect)bounds;

- (void)setCurrentIndex:(NSUInteger)currentIndex animated:(BOOL)animated;
- (void)reloadData;

@end
