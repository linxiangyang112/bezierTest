//
//  LGDMapViewController.m
//  LearnNew
//
//  Created by jysd on 2019/1/16.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "LGDMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface LGDMapViewController ()<MAMapViewDelegate>{
    //高德地图
    MAMapView *mapView_;
}

@end

@implementation LGDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGDMap];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    
    [mapView_ addAnnotation:pointAnnotation];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"这是一个alert" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"this is a alert");
    }];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)  
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"1.jpeg"];
        
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorGreen;
        
        return annotationView;
    }
    return nil;
}

//初始化高德地图
- (void)initGDMap{
    mapView_ = [[MAMapView alloc]initWithFrame:self.view.frame];
    //进入地图就显示定位，需下边两行代码
    mapView_.showsUserLocation = YES;
    mapView_.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    mapView_.delegate = self;
    //logo高德地图字样显示位置 , 必须在mapView.bounds之内，否则会被忽略
    mapView_.logoCenter = CGPointMake(CGRectGetWidth(self.view.bounds)-55, 450);
    //是否显示指南针 默认yes  显示
    mapView_.showsCompass = YES;
    //指南针位置
//    mapView_.compassOrigin
    [self.view addSubview:mapView_];
    
    [self GDMapSetting];
//    MAAnnotationView
}


- (void)GDMapSetting{
    //自定义x定位小蓝点
    MAUserLocationRepresentation * r = [[MAUserLocationRepresentation alloc]init];
    //是否显示精度圈
    r.showsAccuracyRing = YES;
    //是否显示方向指向
    r.showsHeadingIndicator = NO;
    //精度圈填充颜色
    r.fillColor = [UIColor greenColor];
    //精度圈边线颜色
    r.strokeColor = [UIColor orangeColor];
    //精度圈边线宽度
    r.lineWidth = 2;
    
    [mapView_ updateUserLocationRepresentation:r];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
