//
//  GrawViewController.m
//  Onemind
//
//  Created by yinliping on 14-6-30.
//  Copyright (c) 2014年 LipingYin. All rights reserved.
//

#import "GrawViewController.h"
#import "SmoothLineView.h"

#define  RADIUS_REFERENCE 150
#define  SIDE_LEN_REFEREBCE 140

//参照物 圆&方
@implementation ReferenceView
-(void)drawRect:(CGRect)rect
{
    CAShapeLayer *line =  [CAShapeLayer layer];
    CGMutablePathRef   path =  CGPathCreateMutable();
    
    line.lineWidth = 1.0f ;
    line.strokeColor = [UIColor blackColor].CGColor;
    line.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(path, nil,CGRectMake((self.frame.size.width/2-RADIUS_REFERENCE)/2, (self.frame.size.height-RADIUS_REFERENCE)/2+15, RADIUS_REFERENCE, RADIUS_REFERENCE));
                           line.path = path;
                           CGPathRelease(path);
                           [self.layer addSublayer:line];
    
    
    
    line.lineDashPattern =  [NSArray arrayWithObjects:[NSNumber numberWithInt:10], [NSNumber numberWithInt:10], nil];
    line.lineDashPhase = 0.2;
    
    
    CAShapeLayer *line2 =  [CAShapeLayer layer];
    CGMutablePathRef   path2 =  CGPathCreateMutable();
    
    line2.lineWidth = 1.0f ;
    line2.strokeColor = [UIColor whiteColor].CGColor;
    line2.fillColor = [UIColor clearColor].CGColor;
    CGRect rectangle =  CGRectMake(self.frame.size.width/2+(self.frame.size.width/2-SIDE_LEN_REFEREBCE)/2, self.frame.size.height/2-SIDE_LEN_REFEREBCE/2+15, SIDE_LEN_REFEREBCE, SIDE_LEN_REFEREBCE);
    
   
    CGPathAddRects(path2, NULL, (const CGRect *)&rectangle,2);
    
    line2.path = path2;
    CGPathRelease(path2);
    [self.layer addSublayer:line2];
    
    
    
    line2.lineDashPattern =  [NSArray arrayWithObjects:[NSNumber numberWithInt:10], [NSNumber numberWithInt:10], nil];
    line2.lineDashPhase = 0.2;
    
}

@end

@interface GrawViewController ()

@end

@implementation GrawViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 [self setNeedsStatusBarAppearanceUpdate];
  
    //参照物
    ReferenceView *view = [[ReferenceView  alloc]initWithFrame:CGRectMake(0, 0, 480, 320)];
    UIView *rView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.height/2)];
    rView.backgroundColor = [UIColor whiteColor];
    [view addSubview:rView];
    UIView *lView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.height/2, 0,self.view.frame.size.height/2,self.view.frame.size.width)];
    lView.backgroundColor = [UIColor blackColor];
    [view addSubview:lView];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];

    //左右画布
    SmoothLineView *ringtView =  [[SmoothLineView alloc] initWithFrame:CGRectMake(0, 0, 240, 320)];
    ringtView.backgroundColor = [UIColor clearColor];
    ringtView.lineColor = [UIColor blackColor];
    SmoothLineView *leftView =  [[SmoothLineView alloc] initWithFrame:CGRectMake(240, 0, 240, 320)];
    leftView.backgroundColor = [UIColor clearColor];
    leftView.lineColor = [UIColor whiteColor];
    
    [self.view addSubview:ringtView];
    [self.view addSubview:leftView];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//失败界面
-(void)failViewDidLoad
{
    UIView *failView = [[UIView alloc]initWithFrame:self.view.frame];
    
    UIButton *displayBtn = [[UIButton alloc]initWithFrame:CGRectMake(120, 300, 40,30 )];
    [displayBtn setTitle:@"炫耀" forState:UIControlStateNormal];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(120+50, 300, 40,30 )];
    [displayBtn setTitle:@"返回" forState:UIControlStateNormal];
    UIButton *againBtn = [[UIButton alloc]initWithFrame:CGRectMake(120+50, 300, 40,30 )];
    [displayBtn setTitle:@"重来" forState:UIControlStateNormal];
    
    [failView addSubview:displayBtn];
    [failView addSubview:backBtn];
    [failView addSubview:againBtn];
    
}

//隐藏状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}

- (BOOL)prefersStatusBarHidden
{
    return NO; //返回NO表示要显示，返回YES将hiden
}

@end
