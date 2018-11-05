//
//  ViewController.m
//  LearnNew
//
//  Created by jysd on 2018/10/22.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+testBtn.h"
#import "NSArray+CrashCL.h"

@interface ViewController ()

@property (nonatomic, strong)UIButton *  btn;
@property (nonatomic, strong)CAShapeLayer * shapeLayer;
@property (nonatomic, strong)CAShapeLayer * secShapeLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
//    [self creatBtn];
//    [self testArr];
//    [self cashapelayer];
//    [self secondCashapeLayer];
    [self creatARect];
    [self creatATY];
    [self creatCorRect];
    [self creatTwoCorRect];
    [self twoBezier];
    [self erBezier];
    [self creatLeftCircle];
    [self creatRightCircle];
    [self creatSJ];
    [self creatMouth];
    // Do any additional setup after loading the view, typically from a nib.
}

//创建3次折线图
- (void)cashapelayer{
    self.shapeLayer = [CAShapeLayer layer];
    
    self.shapeLayer.bounds = CGRectMake(0, 0, 300, 300);
    
    self.shapeLayer.position = self.view.center;//位置
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色
    
    self.shapeLayer.lineWidth = 5;//线条宽度
    self.shapeLayer.strokeColor = [UIColor greenColor].CGColor;//颜色
    
    self.shapeLayer.lineCap = kCALineCapRound;
    //圆形贝塞尔曲线
//    UIBezierPath * circleBezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 300, 300)];
    
    //rect 表示相对于shapeLayer的位置  corners表示h哪个方向弧度 cornerRadii表示椭圆的X Y轴半径
    UIBezierPath * circleBezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 50, 300, 200) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(150, 100)];
    //radius 表示弧度所在正园的半径
//    UIBezierPath * circleBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:150 startAngle: -M_PI_2 endAngle:M_PI clockwise:YES];
    self.shapeLayer.path = circleBezierPath.CGPath;
    [self.view.layer addSublayer:self.shapeLayer];
}

//创建一个两对角带弧度的矩形
- (void)creatTwoCorRect{
    UIBezierPath * tCorRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(245, 50, 80, 50) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(40, 25)];
    
    CAShapeLayer * tCorRectLayer = [CAShapeLayer layer];
    tCorRectLayer.fillColor = [UIColor greenColor].CGColor;
    tCorRectLayer.strokeColor = [UIColor whiteColor].CGColor;
    tCorRectLayer.lineWidth = 2;
    tCorRectLayer.path = tCorRect.CGPath;
    [self.view.layer addSublayer:tCorRectLayer];
}

//创建一个带圆角的矩形
- (void)creatCorRect{
    UIBezierPath * corRectPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(155, 50, 80, 50) cornerRadius:10];
    CAShapeLayer * corRectLayer = [CAShapeLayer layer];
    corRectLayer.fillColor = [UIColor yellowColor].CGColor;
    corRectLayer.strokeColor = [UIColor whiteColor].CGColor;
    corRectLayer.lineWidth = 2;
    corRectLayer.path = corRectPath.CGPath;
    [self.view.layer addSublayer:corRectLayer];
}

//创建一个矩形
- (void)creatARect{
    UIBezierPath * rectPath = [UIBezierPath bezierPathWithRect:CGRectMake(5, 50, 50, 50)];
    CAShapeLayer * rectLayer = [CAShapeLayer layer];
    rectLayer.fillColor = [UIColor redColor].CGColor;
    rectLayer.strokeColor = [UIColor whiteColor].CGColor;
    rectLayer.lineWidth = 2;
    rectLayer.path = rectPath.CGPath;
    [self.view.layer addSublayer:rectLayer];
}

//创建一个椭圆
- (void)creatATY{
    UIBezierPath * tyPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(65, 50, 80, 50)];
    CAShapeLayer * tyLayer = [CAShapeLayer layer];
    tyLayer.fillColor = [UIColor cyanColor].CGColor;
    tyLayer.strokeColor = [UIColor whiteColor].CGColor;
    tyLayer.lineWidth = 2;
    tyLayer.path = tyPath.CGPath;
    [self.view.layer addSublayer:tyLayer];
}

//创建第二个layer
- (void)secondCashapeLayer{
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 150)];
    [path addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(150, 50) controlPoint2:CGPointMake(150, 200)];
    self.secShapeLayer = [CAShapeLayer layer];
    self.secShapeLayer.path = path.CGPath;
    
    self.secShapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.secShapeLayer.lineWidth = 3;
    self.secShapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    self.secShapeLayer.lineCap = kCALineCapRound;
    self.secShapeLayer.lineJoin = kCALineJoinRound;
    
    [self.view.layer addSublayer:self.secShapeLayer];
}

//创建一条2此贝塞尔曲线
- (void)twoBezier{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 200)];
    [path addQuadCurveToPoint:CGPointMake(170, 200) controlPoint:CGPointMake(30, 130)];
    
    CAShapeLayer * spLayer = [CAShapeLayer layer];
    spLayer.path = path.CGPath;
    spLayer.fillColor = [UIColor clearColor].CGColor;
    spLayer.strokeColor = [UIColor whiteColor].CGColor;
    spLayer.lineWidth = 5;
    
    [self.view.layer addSublayer:spLayer];
}

//第二条二次贝塞尔曲线
- (void)erBezier{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(180, 200)];
    [path addQuadCurveToPoint:CGPointMake(330, 200) controlPoint:CGPointMake(320, 130)];
    CAShapeLayer * spLayer = [CAShapeLayer layer];
    spLayer.path = path.CGPath;
    spLayer.fillColor = [UIColor clearColor].CGColor;
    spLayer.strokeColor = [UIColor whiteColor].CGColor;
    spLayer.lineWidth = 5;
    
    [self.view.layer addSublayer:spLayer];
}

//创建一个圆形
- (void)creatLeftCircle{
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(45, 220, 80, 80) cornerRadius:40];
    CAShapeLayer * spLayer = [CAShapeLayer layer];
    spLayer.path = path.CGPath;
    spLayer.fillColor = [UIColor purpleColor].CGColor;
    spLayer.strokeColor = [UIColor whiteColor].CGColor;
    spLayer.lineWidth = 5;
    [self.view.layer addSublayer:spLayer];
}

//创建第二个圆形

- (void)creatRightCircle{
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(215, 220, 80, 80) cornerRadius:40];
    CAShapeLayer * spLayer = [CAShapeLayer layer];
    spLayer.path = path.CGPath;
    spLayer.fillColor = [UIColor purpleColor].CGColor;
    spLayer.strokeColor = [UIColor whiteColor].CGColor;
    spLayer.lineWidth = 5;
    [self.view.layer addSublayer:spLayer];
}

//创建一个三角
- (void)creatSJ{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(170, 310)];
    [path addLineToPoint:CGPointMake(140, 400)];
    [path addLineToPoint:CGPointMake(200, 400)];
    [path addLineToPoint:CGPointMake(170, 310)];
    
    CAShapeLayer * spLayer = [CAShapeLayer layer];
    spLayer.path = path.CGPath;
    spLayer.fillColor = [UIColor orangeColor].CGColor;
    spLayer.strokeColor = [UIColor whiteColor].CGColor;
    spLayer.lineWidth = 3;
    [self.view.layer addSublayer:spLayer];
}

//创建嘴
- (void)creatMouth{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 420)];
    [path addQuadCurveToPoint:CGPointMake(320, 420) controlPoint:CGPointMake(170, 500)];
    
    CAShapeLayer * spLayer = [CAShapeLayer layer];
    spLayer.path = path.CGPath;
    spLayer.fillColor = [UIColor clearColor].CGColor;
    spLayer.strokeColor = [UIColor whiteColor].CGColor;
    spLayer.lineWidth = 4;
    [self.view.layer addSublayer:spLayer];
}

- (void)testArr{
    NSArray * arr = @[@"1"];
    [arr objectAtIndex:3];
}

//贝塞尔曲线测试
- (void)bezierTest{
    
}

- (UIButton *)btn{
    if (!_btn) {
        [self creatBtn];
    }
    return _btn;
}

- (void)creatBtn{
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.bounds =  CGRectMake(0, 0, 100, 100);
    _btn.center = self.view.center;
    _btn.backgroundColor = [UIColor redColor];
    [_btn addTarget:self action:@selector(testClickArea:) forControlEvents:UIControlEventTouchUpInside];
    [_btn  enlargeBtnClickAreaWith:ClickSizeMake(100, 100, 200, 200)];

    //kvo
    [_btn addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [self.view addSubview:_btn];
}

- (void)testClickArea:(UIButton *)sender{
    NSLog(@"测试下点击范围");
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"highlighted"]) {
        UIButton * btn = (UIButton *)object;
        if (btn.isHighlighted) {
            [self kvoTest];
        }
        else{
            self.view.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void)kvoTest{
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)dealloc{
    [_btn removeObserver:self forKeyPath:@"highlighted"];
}

@end
