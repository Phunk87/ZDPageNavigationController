//
//  ZDPageNavigationBarTitleView.m
//  Pods
//
//  Created by 0day on 15/5/28.
//
//

#import "ZDPageNavigationBarTitleView.h"
#import "UIView+FadeTruncate.h"
#import "SMPageControl.h"

#define kFrame  CGRectMake(0, 0, 140, 40)
#define kPageControlFrame CGRectMake(0, 32, 160, 10)

@interface ZDPageNavigationBarTitleView ()

@property (nonatomic, strong) UIView            *maskView;
@property (nonatomic, strong) NSMutableArray    *titleLabels;
@property (nonatomic, strong) SMPageControl     *pageControl;

@end

@implementation ZDPageNavigationBarTitleView {
    NSUInteger  _n;
}

- (instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar {
    self = [super initWithFrame:kFrame];
    if (self) {
        self.navigationBar = navigationBar;
        self.titleLabels = [@[] mutableCopy];
        
        self.backgroundColor = [UIColor clearColor];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:kFrame];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.userInteractionEnabled = YES;
        scrollView.scrollEnabled = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIView *maskView = [[UIView alloc] initWithFrame:kFrame];
        maskView.backgroundColor = [UIColor clearColor];
        maskView.userInteractionEnabled = NO;
        
        [self addSubview:maskView];
        self.maskView = maskView;
        
        self.pageControl = [[SMPageControl alloc] initWithFrame:kPageControlFrame];
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        self.pageControl.indicatorDiameter = 5;
        self.pageControl.indicatorMargin = 5;
        [self addSubview:self.pageControl];
    }
    
    return self;
}

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    [self.maskView fadeHeadAndTailWithColor:maskColor];
}

- (void)updatePageControl:(NSUInteger)index {
    self.pageControl.currentPage = index;
}

- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    self.scrollView.contentOffset = (CGPoint){percent * (self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.bounds)), 0};
    CGFloat fIndex = (self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.bounds) * 0.5) / (CGRectGetWidth(self.scrollView.bounds));
    
    fIndex = fIndex < 0 ? 0 : fIndex;
    fIndex = fIndex > _n - 1 ? _n - 1 : fIndex;
    
    [self updatePageControl:(NSUInteger)fIndex];
}

- (void)setCurrentIndex:(NSUInteger)currentIndex {
    [self setCurrentIndex:currentIndex animated:NO];
}

- (void)setCurrentIndex:(NSUInteger)currentIndex animated:(BOOL)animated {
    _currentIndex = currentIndex;
    [self.scrollView setContentOffset:CGPointMake(currentIndex * CGRectGetWidth(kFrame), 0) animated:animated];
    _percent = self.scrollView.contentOffset.x / (self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.bounds));
    [self updatePageControl:currentIndex];
}

- (void)reloadData {
    [self.titleLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
        [label removeFromSuperview];
    }];
    [self.titleLabels removeAllObjects];
    
    NSUInteger n = [self.dataSource numberOfTitles];
    _n = n;
    self.scrollView.contentSize = (CGSize){n * CGRectGetWidth(kFrame), CGRectGetHeight(kFrame)};
    
    self.pageControl.numberOfPages = n;
    
    NSDictionary *titleTextAttributes = self.navigationBar.titleTextAttributes;
    BOOL usingTitleView = [self.dataSource shouldUsingTitleView];
    self.pageControl.hidden = usingTitleView;
    
    for (int i = 0; i < n; i++) {
        if (!usingTitleView) {
            NSString *title = [self.dataSource titleAtIndex:i];
            
            CGRect frame = kFrame;
            frame.origin.x = i * CGRectGetWidth(kFrame);
            frame.origin.y = -5;
            
            UILabel *label = [[UILabel alloc] initWithFrame:frame];
            label.attributedText = [[NSAttributedString alloc] initWithString:title attributes:titleTextAttributes];
            label.textAlignment = NSTextAlignmentCenter;
            [self.titleLabels addObject:label];
            [self.scrollView addSubview:label];
        } else {
            UIView *titleView = [self.dataSource titleViewAtIndex:i];
            CGRect frame = kFrame;
            frame.origin.x = i * CGRectGetWidth(kFrame);
            
            titleView.frame = frame;
            
            [self.scrollView addSubview:titleView];
        }
    }
    
    self.currentIndex = 0;
}

@end
