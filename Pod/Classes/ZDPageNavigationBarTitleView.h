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

@end

@interface ZDPageNavigationBarTitleView : UIView

@property (nonatomic, weak) UINavigationBar *navigationBar;

@property (nonatomic, assign) NSUInteger    currentIndex;
@property (nonatomic, assign) CGFloat       percent;
@property (nonatomic, weak) id<ZDPageNavigationBarTitleViewDataSource> dataSource;


- (instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar;

- (void)setCurrentIndex:(NSUInteger)currentIndex animated:(BOOL)animated;
- (void)reloadData;

@end
