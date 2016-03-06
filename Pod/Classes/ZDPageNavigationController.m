//
//  ZDPageNavigationController.m
//  Pods
//
//  Created by 0day on 15/5/28.
//
//

#import "ZDPageNavigationController.h"
#import "ZDPageNavigationBarTitleView.h"

@interface ZDPageNavigationController ()
<
UIPageViewControllerDataSource,
UIPageViewControllerDelegate,
ZDPageNavigationBarTitleViewDataSource,
UIScrollViewDelegate
>

@property (nonatomic, strong) ZDPageNavigationBarTitleView  *titleView;
@property (nonatomic, strong) UIPageViewController  *pageViewController;

@end

@implementation ZDPageNavigationController

- (void)_init {
    NSAssert([self.topViewController isKindOfClass:[UIPageViewController class]], @"RootViewController should be a UIPageViewController instance.");
    self.pageViewController = (UIPageViewController *)self.topViewController;
    self.pageViewController.view.backgroundColor = [UIColor whiteColor];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.navigationBar.translucent = NO;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self _init];
    }
    
    return self;
}

- (instancetype)initWithPageViewControllers:(NSArray *)pageViewControllers {
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self = [super initWithRootViewController:pageViewController];
    if (self) {
        [self _init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setDelegate:self];
        }
    }
}

- (void)setPageViewControllers:(NSArray *)pageViewControllers {
    _pageViewControllers = pageViewControllers;
    
    if (!_titleView) {
        self.titleView = [[ZDPageNavigationBarTitleView alloc] initWithNavigationBar:self.navigationBar];
        self.titleView.dataSource = self;
        self.pageViewController.navigationItem.titleView = self.titleView;
    }
    
    [self.pageViewController setViewControllers:@[pageViewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.titleView reloadData];
}

#pragma mark - <UIScrollViewDelegate>

static NSUInteger s_index = 0;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = CGRectGetWidth(scrollView.frame);
    CGFloat percent = (scrollView.contentOffset.x + width * s_index - width) / ((self.pageViewControllers.count - 1) * width);
    self.titleView.percent = percent;
}

#pragma mark - <ZDPageNavigationBarTitleViewDataSource>

- (NSUInteger)numberOfTitles {
    return self.pageViewControllers.count;
}

- (NSString *)titleAtIndex:(NSUInteger)index {
    return ((UIViewController *)self.pageViewControllers[index]).title;
}

#pragma mark - <UIPageViewControllerDataSource>

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (pageViewController == self.pageViewController) {
        NSUInteger idx = [self.pageViewControllers indexOfObject:viewController];
        if (idx != NSNotFound && idx > 0) {
            return self.pageViewControllers[idx - 1];
        }
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (pageViewController == self.pageViewController) {
        NSUInteger idx = [self.pageViewControllers indexOfObject:viewController];
        if (idx != NSNotFound && idx < self.pageViewControllers.count - 1) {
            return self.pageViewControllers[idx + 1];
        }
    }
    
    return nil;
}

#pragma mark - <UIPageViewControllerDelegate>

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        UIViewController *selectedVC = [self.pageViewController.viewControllers lastObject];
        s_index = [self.pageViewControllers indexOfObject:selectedVC];
    }
}

@end
