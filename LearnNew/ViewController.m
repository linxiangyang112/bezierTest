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
#import "IGTestViewController.h"
#import "MyViewController.h"
#import "LGDMapViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSInteger index_;
    NSTimer * timer_;
}

@property (nonatomic, strong)UIButton *  btn;
@property (nonatomic, strong)CAShapeLayer * shapeLayer;
@property (nonatomic, strong)CAShapeLayer * secShapeLayer;
@property (nonatomic, strong)UILabel * gradientLabel;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)CAGradientLayer * gradientLayer;
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
    [self creatPushBtn];
    index_ = 0;
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 550, [UIScreen mainScreen].bounds.size.width, 40) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.pagingEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    [self.view addSubview:_tableView];
    [self creatTimer];
    [self jbsLabel];
    [self creatImg];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)dealloc{
    [timer_ invalidate];
    timer_ = nil;
     [_btn removeObserver:self forKeyPath:@"highlighted"];
}

- (void)creatImg{
    
    UIImageView * imageView = [[UIImageView alloc]init];
    NSString * x = [[NSUserDefaults standardUserDefaults]objectForKey:@"xPoint"];
    NSString * y = [[NSUserDefaults standardUserDefaults]objectForKey:@"yPoint"];
    if (x.length > 0) {
        imageView.center = CGPointMake([x floatValue], [y floatValue]);
        imageView.bounds = CGRectMake(0, 0, 100, 100);
    }
    else{
        imageView.frame = CGRectMake(0, 0, 100, 100);
    }
    imageView.image = [UIImage imageNamed:@"1-1"];
    imageView.userInteractionEnabled = YES;
    UILongPressGestureRecognizer * longGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self.view addSubview:imageView];
    [imageView addGestureRecognizer:longGes];
    UIPanGestureRecognizer * panges = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panpress:)];
    [imageView addGestureRecognizer:panges];
}

- (void)panpress:(UIPanGestureRecognizer *)rec{
    //返回在横坐标上、纵坐标上拖动了多少像素
    CGPoint point=[rec translationInView:self.view];
    NSLog(@"%f,%f",point.x,point.y);
    rec.view.center=CGPointMake(rec.view.center.x+point.x, rec.view.center.y+point.y);
    //拖动完之后，每次都要用setTranslation:方法制0这样才不至于不受控制般滑动出视图
    [rec setTranslation:CGPointMake(0, 0) inView:self.view];
    NSLog(@"x坐标%@",[NSString stringWithFormat:@"%f",rec.view.center.x]);
    //记录图片中心点 x y坐标
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",rec.view.center.x] forKey:@"xPoint"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",rec.view.center.y] forKey:@"yPoint"];
}

//长按手势操作
- (void)longPress:(UILongPressGestureRecognizer *)ges{
    NSLog(@"长按");
    UIImageView * imgView = (UIImageView *)[ges view];
    UIAlertController * alertC= [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(imgView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }];
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertC addAction:cancleAction];
    [alertC addAction:sureAction];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(void*)contextInfo{
    NSString*message;
    
    if(!error) {
        message =@"成功保存到相册";
        [SVProgressHUD showSuccessWithStatus:message];
    }else
    {
        message = [error description];
        [SVProgressHUD showErrorWithStatus:message];
    }
}

//渐变色label
- (void)jbsLabel{
    if (!_gradientLabel) {
        _gradientLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 600, [UIScreen mainScreen].bounds.size.width, 40)];
        _gradientLabel.backgroundColor = [UIColor clearColor];
        _gradientLabel.text = @"这是一个渐变色标签";
        _gradientLabel.font = [UIFont systemFontOfSize:25];
    }
   UIView *bgView = [[UIView alloc]initWithFrame:_gradientLabel.frame];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:_gradientLabel];
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = _gradientLabel.bounds;
    _gradientLayer.colors = @[(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor];
    _gradientLayer.startPoint = CGPointMake(0, 1);
    _gradientLayer.endPoint = CGPointMake(1, 0);
     [bgView.layer addSublayer:_gradientLayer];
    _gradientLayer.mask = _gradientLabel.layer;
    _gradientLabel.frame = _gradientLayer.bounds;
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(textColorChange)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.view addSubview:bgView];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"name"]) {
        
    }
}

-(UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

-(void)textColorChange {
    _gradientLayer.colors = @[(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor];
}

- (void)creatTimer{
    timer_ = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(circleScroll) userInfo:nil repeats:YES];
    [timer_ fireDate];
}

- (void)circleScroll{
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index_ inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    index_ ++;
    if (index_ >= 10) {
        index_ = 0;
    }
}

#pragma mark - circleTableView

//尝试实现滚动播放效果
- (void)creatTableView{
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"滚动位置%f",scrollView.contentOffset.y);
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [timer_ setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    index_ = _tableView.contentOffset.y/40;
    [timer_ setFireDate:[NSDate date]];
}
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是%ld",(long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LGDMapViewController * vc = [[LGDMapViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)creatPushBtn{
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 450, 50, 50)];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)pushNext{
    MyViewController * vc = [[MyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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


@end
