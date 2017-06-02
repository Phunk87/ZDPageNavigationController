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
@property (nonatomic, strong) UIColor   *maskColor; // default as white

- (void)setCurrentIndex:(NSUInteger)index animated:(BOOL)animated;

@end
