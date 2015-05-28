//
//  ZDPageNavigationController.h
//  Pods
//
//  Created by 0day on 15/5/28.
//
//

#import <UIKit/UIKit.h>

@interface ZDPageNavigationController : UINavigationController

@property (nonatomic, strong) NSArray *pageViewControllers;

- (instancetype)initWithPageViewControllers:(NSArray *)pageViewControllers;

@end
