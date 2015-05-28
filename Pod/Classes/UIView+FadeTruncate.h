//
//  UIView+FadeTruncate.h
//  Pods
//
//  Created by 0day on 15/5/28.
//
//

#import <UIKit/UIKit.h>

@interface UIView (FadeTruncate)

- (void)fadeHeadAndTailWithColor:(UIColor *)color;

- (void)fadeWithColors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
