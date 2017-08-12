//
//  ViewController.m
//  DrawBezierPathWithPointArray
//
//  Created by 曲终叶落 on 2017/8/12.
//  Copyright © 2017年 曲终叶落. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 数组个数
    int count = 12;
    
    // 每个点之间的距离
    CGFloat gap = 30.0;
    
    NSMutableArray *pointsArray = [NSMutableArray array];
    
    for (int i = 0; i < count; i++ ) {
        
        [pointsArray addObject:[NSValue valueWithCGPoint:CGPointMake((i + 1) * gap, [self getRandomNumber:20 to:500])]];
        
        
    }
    NSLog(@"%@",pointsArray);
    [self drawPathWithPoints:pointsArray];
}


/**
 获取一个随机数

 @param from 最小值
 @param to 最大值
 @return int
 */
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}


/**
 画曲线
 
 @param points allPoints description
 */
- (void)drawPathWithPoints:(NSArray *)points{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint prePonit;
    for (int i =0; i<points.count; i++) {
        if (i==0) {
            // 起点
            [path moveToPoint:[points[0] CGPointValue]];
            
            prePonit = [points[0] CGPointValue];
        }else{
            
            CGPoint NowPoint = [points[i] CGPointValue];
            // 三次曲线
            [path addCurveToPoint:NowPoint controlPoint1:CGPointMake((prePonit.x+NowPoint.x)/2, prePonit.y) controlPoint2:CGPointMake((prePonit.x+NowPoint.x)/2, NowPoint.y)];
            
            prePonit = NowPoint;
        }
    }

    // 创建CAShapeLayer
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth =  1.0f;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.strokeColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:layer];
    layer.path = path.CGPath;
    
    // 创建Animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    layer.autoreverses = NO;
    animation.duration = 4.0;
    
    // 设置layer的animation
    [layer addAnimation:animation forKey:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
