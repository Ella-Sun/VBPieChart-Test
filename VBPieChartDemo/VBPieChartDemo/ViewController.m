//
//  ViewController.m
//  VBPieChartDemo
//
//  Created by SunHong on 15/9/6.
//  Copyright (c) 2015年 Sunhong. All rights reserved.
//

#import "ViewController.h"

#import "VBPieChart.h"
#import "UIColor+HexColor.h"

@interface ViewController ()

@property (nonatomic, strong) VBPieChart * chart;

@property (nonatomic, strong) NSArray* chartValues;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setNeedsLayout];
    
    [self createChart];
    
}

- (void)createChart
{
    if (!_chart) {
        //在这里 我醉了  不能直接设置frame 否则不显示
        _chart = [[VBPieChart alloc] init];//WithFrame:CGRectMake(10, 50, 300, 300)];//
        [self.view addSubview:_chart];
    }
    [_chart setFrame:CGRectMake(10, 50, 300, 300)];
    [_chart setEnableStrokeColor:YES];//
    /* hole inside of chart */
    [_chart setHoleRadiusPrecent:.3];//
    
    [_chart.layer setShadowOffset:CGSizeMake(2, 2)];
    [_chart.layer setShadowRadius:3];
    [_chart.layer setShadowColor:[UIColor blackColor].CGColor];
    [_chart.layer setShadowOpacity:.7];
    
    [_chart setLabelsPosition:VBLabelsPositionOnChart];
    
    //EXAMPLE for custom label position
//    [_chart setLabelsPosition:VBLabelsPositionCustom];
//    [_chart setLabelBlock:^CGPoint( CALayer *layer) {
//        NSInteger ind = [layer.superlayer.sublayers indexOfObject:layer]+2;
//        return CGPointMake(sin(-ind/10.0*M_PI)*50+50, ind*30);
//    }];
//    self.chartValues = @[
//                         @{@"name":@"37%", @"value":@65, @"color":[UIColor colorWithHex:0x5677fcaa], @"labelColor":[UIColor blackColor]},
//                         @{@"name":@"13%", @"value":@23, @"color":[UIColor colorWithHex:0x2baf2baa], @"labelColor":[UIColor blackColor]},
//                         @{@"name":@"19.3%", @"value":@34, @"color":[UIColor colorWithHex:0xb0bec5aa], @"labelColor":[UIColor blackColor]},
//                         @{@"name":@"30.7%", @"value":@54, @"color":[UIColor colorWithHex:0xf57c00aa], @"labelColor":[UIColor blackColor]}
//                         ];
    
    self.chartValues = @[
                         @{@"name":@"first", @"value":@50, @"color":[UIColor colorWithHex:0xdd191daa]},
                         @{@"name":@"sec", @"value":@20, @"color":[UIColor colorWithHex:0xd81b60aa]},
                         @{@"name":@"third", @"value":@40, @"color":[UIColor colorWithHex:0x8e24aaaa]},
                         @{@"name":@"fourth", @"value":@70, @"color":[UIColor colorWithHex:0x3f51b5aa]},
                         @{@"name":@"some", @"value":@65, @"color":[UIColor colorWithHex:0x5677fcaa]},
                         @{@"name":@"new", @"value":@23, @"color":[UIColor colorWithHex:0x2baf2baa]},
                         @{@"name":@"label", @"value":@34, @"color":[UIColor colorWithHex:0xb0bec5aa]},
                         @{@"name":@"here", @"value":@54, @"color":[UIColor colorWithHex:0xf57c00aa]}
                         ];//
    

    [_chart setChartValues:_chartValues animation:YES];//
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)growthAll:(id)sender {
    
    [_chart setChartValues:_chartValues animation:YES options:VBPieChartAnimationGrowthAll | VBPieChartAnimationTimingEaseInOut];
}
- (IBAction)grow:(id)sender {
    
    [_chart setChartValues:_chartValues animation:YES duration:1.0 options:VBPieChartAnimationGrowth];
}


- (IBAction)growthBackAll:(id)sender {
    
    [_chart setChartValues:_chartValues animation:YES options:VBPieChartAnimationGrowthBackAll | VBPieChartAnimationTimingEaseInOut];
}
- (IBAction)growthBack:(id)sender {
    
    [_chart setChartValues:_chartValues animation:YES duration:1.0 options:VBPieChartAnimationGrowthBack];
}


- (IBAction)fan:(id)sender {
    
    [_chart setChartValues:_chartValues animation:YES duration:0.35 options:VBPieChartAnimationFan];
}
- (IBAction)fanAll:(id)sender {
    [_chart setChartValues:_chartValues animation:YES options:VBPieChartAnimationFanAll];
}


- (IBAction)changeLength:(id)sender {
    
    if (_chart.length < M_PI*2-0.01) {
        _chart.length = M_PI*2;
        _chart.startAngle = 0;
    } else {
        _chart.length = M_PI;
        _chart.startAngle = M_PI;
    }
    
    [_chart setChartValues:_chart.chartValues animation:YES];
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *t = [[touches allObjects] lastObject];
    CGPoint p1 = [t previousLocationInView:self.view];
    CGPoint p2 = [t locationInView:self.view];

    CGPoint delta;
    delta.x = p1.x - p2.x;
    delta.y = p1.y - p2.y;

    _chart.layer.transform = CATransform3DRotate(_chart.layer.transform, delta.y * M_PI / 180.0f, 1, 0, 0);
//    self.layer.transform = CATransform3DRotate(self.layer2.transform, delta.y * M_PI / 180.0f, 1, 0, 0);

    _chart.layer.transform = CATransform3DRotate(_chart.layer.transform, delta.x * M_PI / 180.0f, 0, -1, 0);
//    self.layer2.transform = CATransform3DRotate(self.layer2.transform, delta.x * M_PI / 180.0f, 0, -1, 0);
}


@end
