//
//  ZDPageNavigationController.h
//  Pods
//
//  Created by 0day on 15/5/28.
//
//

#import <UIKit/UIKit.h>

@interface ZDPageNavigationController : UINavigationController

@property (nonatomic, strong) NSArray<UIViewController*> *pageViewControllers;
@property (nonatomic, assign) BOOL usingTitleView;  // default as NO
@property (nonatomic, assign) CGRect    titleViewBounds;    // default is {0, 0, 140, 40}
@property (nonatomic, strong) UIColor   *maskColor; // default as white

- (void)setCurrentIndex:(NSUInteger)index animated:(BOOL)animated;

@end
