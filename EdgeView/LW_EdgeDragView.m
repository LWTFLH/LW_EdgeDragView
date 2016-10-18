//
//  DO_EdgeDragView.m
//  DO_EdgeDragAnimation_Demo
//
//  Created by lanou on 16/7/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LW_EdgeDragView.h"
#define H [UIScreen mainScreen].bounds.size.width
#define W [UIScreen mainScreen].bounds.size.height
@implementation LW_EdgeDragView
  CGFloat x;
  CGFloat y;

-(instancetype)initWithFrame:(CGRect)frame EdgeType:(EdgeType)edgetype
{
    self = [super initWithFrame:frame];
    if (self) {
        _edgetype = edgetype;
        _movePath = [UIBezierPath bezierPath];
        _originPath = [UIBezierPath bezierPath];
        self.alpha = 0.3;
    }
    return self;
}

#pragma mark   根据跟踪触摸获取的movepath刷新shapelayer
-(void)setNeedsDisplayView
{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
    }else{
        [_shapeLayer removeFromSuperlayer];
    }
    _shapeLayer.frame = self.bounds;
    _shapeLayer.fillColor = self.color.CGColor;
    _shapeLayer.lineWidth = 1.0f;
    _shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    _shapeLayer.path = _movePath.CGPath;
    [self.layer addSublayer:_shapeLayer];
}
//根据跟踪触摸获取movepath/originPath
-(void)configMovePathWith:(CGPoint)point
{
    [_movePath removeAllPoints];
    [_originPath removeAllPoints];
    switch (_edgetype) {
        case top: {
            if (point.y>160) {
                point.y = 160;
            }
            [_movePath moveToPoint:CGPointMake(0, 0)];
            [_movePath addLineToPoint:CGPointMake(W, 0)];
            [_movePath addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:point];
            point.y = 0;
            [_originPath moveToPoint:CGPointMake(0, 0)];
            [_originPath addLineToPoint:CGPointMake(W, 0)];
            [_originPath addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:point];
            
            break;
        }
        case left: {
            if (point.x>160) {
                point.x = 160;
            }
            [_movePath moveToPoint:CGPointMake(0, 0)];
            [_movePath addLineToPoint:CGPointMake(0, H)];
            [_movePath addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:point];
            point.x = 0;
            [_originPath moveToPoint:CGPointMake(0, 0)];
            [_originPath addLineToPoint:CGPointMake(0, H)];
            [_originPath addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:point];
            break;
        }
        case down: {
            if (point.y < H-160) {
                point.y = H-160;
            }
            [_movePath moveToPoint:CGPointMake(0, H)];
            [_movePath addLineToPoint:CGPointMake(W, H)];
            [_movePath addQuadCurveToPoint:CGPointMake(0, H) controlPoint:point];
            point.y = H;
            [_originPath moveToPoint:CGPointMake(0, H)];
            [_originPath addLineToPoint:CGPointMake(W, H)];
            [_originPath addQuadCurveToPoint:CGPointMake(0, H) controlPoint:point];
            break;
        }
        case right: {
            if (point.x < W-160) {
                point.x = W-160;
            }
            [_movePath moveToPoint:CGPointMake(W, 0)];
            [_movePath addLineToPoint:CGPointMake(W, H)];
            [_movePath addQuadCurveToPoint:CGPointMake(W,0) controlPoint:point];
            point.x = W;
            [_originPath moveToPoint:CGPointMake(W, 0)];
            [_originPath addLineToPoint:CGPointMake(W, H)];
            [_originPath addQuadCurveToPoint:CGPointMake(W,0) controlPoint:point];
            break;
        }
    }
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [touches.anyObject locationInView:self];
    [self configMovePathWith:point];
    [self setNeedsDisplayView];
    
    NSLog(@"子类");
    
}
//手指离开动画隐藏view
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self animation];
}
#pragma mark 用户移开手指后动画消除
-(void)animation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 0.5;
    animation.fromValue = (__bridge id _Nullable)(_movePath.CGPath);
    animation.toValue = (__bridge id _Nullable)(_originPath.CGPath);
    animation.delegate = self;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_shapeLayer addAnimation:animation forKey:nil];
}
#pragma mark 动画结束后路径靠边
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _movePath.CGPath = _originPath.CGPath;
    [self setNeedsDisplayView];
    [_shapeLayer removeAllAnimations];
}
//外界事件更改path，通过point 注意最后需要point靠边隐藏此view   
-(void)setControllpoint:(CGPoint)controllpoint
{
    _controllpoint = controllpoint;
    [self configMovePathWith:controllpoint];
    [self setNeedsDisplayView];
}





@end
