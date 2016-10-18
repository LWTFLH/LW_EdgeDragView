//
//  DO_EdgeDragView.h
//  DO_EdgeDragAnimation_Demo
//
//  Created by lanou on 16/7/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,EdgeType) {
    top,
    left,
    down,
    right
};
@interface LW_EdgeDragView : UIView{
    CAShapeLayer *_shapeLayer;
    UIBezierPath *_movePath;
    UIBezierPath *_originPath;
}
@property (nonatomic,assign)EdgeType edgetype;
@property (nonatomic,strong)UIColor *color;
@property (nonatomic,assign)CGPoint controllpoint; //  供外界drag
-(instancetype)initWithFrame:(CGRect)frame EdgeType:(EdgeType)edgetype;
-(void)animation;  //  外界drag结束动画
@end
