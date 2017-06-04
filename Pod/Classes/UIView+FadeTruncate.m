//
//  UIView+FadeTruncate.m
//  Pods
//
//  Created by 0day on 15/5/28.
//
//

#import "UIView+FadeTruncate.h"

@implementation UIView (FadeTruncate)

- (void)fadeHeadAndTailWithColor:(UIColor *)color {
    NSArray *colors = @[(id)color.CGColor,
                        (id)CFBridgingRelease(CGColorCreateCopyWithAlpha(color.CGColor, 0)),
                        (id)CFBridgingRelease(CGColorCreateCopyWithAlpha(color.CGColor, 0)),
                        (id)color.CGColor];
    NSArray *locations = @[@(0),
                           @(0.1),
                           @(0.9),
                           @(1)];
    CGPoint startPoint = (CGPoint){0, 0.5};
    CGPoint endPoint = (CGPoint){1, 0.5};
    [self fadeWithColors:colors locations:locations startPoint:startPoint endPoint:endPoint];
}

- (void)fadeWithColors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = colors;
    gradient.locations = locations;
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    
    [self.layer addSublayer:gradient];
}

@end
