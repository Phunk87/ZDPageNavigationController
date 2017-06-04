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
@property (nonatomic, assign) NSUInteger    index;

@end

@implementation ZDPageNavigationController

- (void)_init {
    NSAssert([self.topViewController isKindOfClass:[UIPageViewController class]], @"RootViewController should be a UIPageViewController instance.");
    self.pageViewController = (UIPageViewController *)self.topViewController;
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.navigationBar.translucent = NO;
    self.usingTitleView = NO;
    self.maskColor = [UIColor whiteColor];
    self.titleViewBounds = CGRectMake(0, 0, 140, 40);
    _index = 0;
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

- (instancetype)initWithPageViewControllers:(NSArray<UIViewController *> *)pageViewControllers {
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self = [super initWithRootViewController:pageViewController];
    if (self) {
        [self _init];
        self.pageViewControllers = pageViewControllers;
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
    
    [self _updateNavigationItemsToViewController:[self.pageViewController.viewControllers lastObject]
                                        animated:NO];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController.navigationItem.leftBarButtonItem && [UIImage imageNamed:@"btn-back"]) {
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
        viewController.navigationItem.leftBarButtonItem = back;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back:(id)sender {
    [self popViewControllerAnimated:YES];
}


- (void)setPageViewControllers:(NSArray<UIViewController *> *)pageViewControllers {
    _pageViewControllers = pageViewControllers;
    
    if (!_titleView) {
        self.titleView = [[ZDPageNavigationBarTitleView alloc] initWithNavigationBar:self.navigationBar titleViewBounds:self.titleViewBounds];
        self.titleView.dataSource = self;
        self.pageViewController.navigationItem.titleView = self.titleView;
        self.titleView.maskColor = self.maskColor;
    }
    
    [self.pageViewController setViewControllers:@[pageViewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.titleView reloadData];
}

- (void)_updateNavigationItemsToViewController:(UIViewController *)vc animated:(BOOL)animated {
    [self.pageViewController.navigationItem setLeftBarButtonItem:vc.navigationItem.leftBarButtonItem
                                                        animated:animated];
    [self.pageViewController.navigationItem setLeftBarButtonItems:vc.navigationItem.leftBarButtonItems
                                                         animated:animated];
    [self.pageViewController.navigationItem setRightBarButtonItem:vc.navigationItem.rightBarButtonItem
                                                         animated:animated];
    [self.pageViewController.navigationItem setRightBarButtonItems:vc.navigationItem.rightBarButtonItems
                                                          animated:animated];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = CGRectGetWidth(scrollView.frame);
    CGFloat percent = (scrollView.contentOffset.x + width * self.index - width) / ((self.pageViewControllers.count - 1) * width);
    self.titleView.percent = percent;
}

#pragma mark - <ZDPageNavigationBarTitleViewDataSource>

- (NSUInteger)numberOfTitles {
    return self.pageViewControllers.count;
}

- (NSString *)titleAtIndex:(NSUInteger)index {
    return ((UIViewController *)self.pageViewControllers[index]).title;
}

- (UIView *)titleViewAtIndex:(NSUInteger)index {
    return self.pageViewControllers[index].navigationItem.titleView;
}

- (BOOL)shouldUsingTitleView {
    return self.usingTitleView;
}

#pragma mark - <UIPageViewControllerDataSource>

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (pageViewController == self.pageViewController) {
        NSUInteger idx = [self.pageViewControllers indexOfObject:(UIViewController *)viewController];
        if (idx != NSNotFound && idx > 0) {
            return self.pageViewControllers[idx - 1];
        }
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (pageViewController == self.pageViewController) {
        NSUInteger idx = [self.pageViewControllers indexOfObject:(UIViewController *)viewController];
        if (idx != NSNotFound && idx < self.pageViewControllers.count - 1) {
            return self.pageViewControllers[idx + 1];
        }
    }
    
    return nil;
}

#pragma mark - <UIPageViewControllerDelegate>

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    [self _updateNavigationItemsToViewController:nil animated:YES];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        UIViewController *selectedVC = [self.pageViewController.viewControllers lastObject];
        self.index = [self.pageViewControllers indexOfObject:selectedVC];
    }
    
    [self _updateNavigationItemsToViewController:[self.pageViewController.viewControllers lastObject]
                                        animated:YES];
}

- (void)setCurrentIndex:(NSUInteger)index animated:(BOOL)animated {
    if (self.index == index) {
        return;
    }
    
    __weak typeof(self) wself = self;
    [self.pageViewController setViewControllers:@[self.pageViewControllers[index]]
                                      direction:index > self.index ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse
                                       animated:animated
                                     completion:^(BOOL finished) {
                                         _index = index;
                                         [wself _updateNavigationItemsToViewController:[wself.pageViewController.viewControllers lastObject]
                                                                             animated:animated];
                                     }];
    
    [wself.titleView setCurrentIndex:index animated:animated];
}

@end
