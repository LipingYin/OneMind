//
//  GrawViewController.m
//  Onemind
//
//  Created by yinliping on 14-6-30.
//  Copyright (c) 2014年 LipingYin. All rights reserved.
//

#import "GrawViewController.h"


#define  RADIUS_REFERENCE 150 //直径
#define  SIDE_LEN_REFEREBCE 140
#define  LEFT_POINT_CENTER
#define  STATUS_LEFT @"status_left"
#define  STATUS_RIGHT @"status_right"
struct Line { int a; int b; int c; };

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
    
    NSLog(@"rectangle:%f y:%f w:%f h:%f",rectangle.origin.x,rectangle.origin.y,rectangle.size.width,rectangle.size.height);
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

//判断点是否在环内的算法
-(void)curLeftPoints:(CGPoint)curPoint status:(NSString *)status
{
    if ([status isEqualToString:STATUS_LEFT]) {
        
        CGPoint leftPointcenter  = CGPointMake(self.view.frame.size.height/4, self.view.frame.size.width/2+15);
        //点到圆心的距离
        double dist = sqrt ( pow((curPoint.x-leftPointcenter.x), 2) + pow((curPoint.y-leftPointcenter.y), 2) );
        NSLog(@"dist:%f",dist);
        if (curPoint.x!=0&&curPoint.y!=0) {
            if (dist<70||dist>80) {
                [self failViewDidLoad];
            }else
            {
                if (dist -RADIUS_REFERENCE/2>0) {
                     disTipLeft.text = [NSString stringWithFormat:@"+%.2f",dist -RADIUS_REFERENCE/2];
                }else
                    disTipLeft.text = [NSString stringWithFormat:@"%.2f",dist -RADIUS_REFERENCE/2];
            }
            
        }

    }else if([status isEqualToString:STATUS_RIGHT])
    {
        CGRect bigRect = CGRectMake((self.view.frame.size.width-SIDE_LEN_REFEREBCE)/2+15-5,(self.view.frame.size.height/2+(self.view.frame.size.height/2-SIDE_LEN_REFEREBCE)/2-5),SIDE_LEN_REFEREBCE+10,SIDE_LEN_REFEREBCE+10);
        
        CGRect smallRect = CGRectMake((self.view.frame.size.width-SIDE_LEN_REFEREBCE)/2+15+5,(self.view.frame.size.height/2+(self.view.frame.size.height/2-SIDE_LEN_REFEREBCE)/2+5),SIDE_LEN_REFEREBCE-10,SIDE_LEN_REFEREBCE-10);
        
        NSLog(@"smallx:%f y:%f w:%f h:%f",smallRect.origin.x,smallRect.origin.y,smallRect.size.width,smallRect.size.height);
        NSLog(@"big:%f y:%f w:%f h:%f",bigRect.origin.x,bigRect.origin.y,bigRect.size.width,bigRect.size.height);
        
        if ([self inRect:curPoint Rect:smallRect]||![self inRect:curPoint Rect:bigRect]) {
            [self failViewDidLoad];
        }
        
    }
}
//判断是否在矩形内
-(BOOL)inRect:(CGPoint)point Rect:(CGRect )rect
{
    CGPoint changePoint = CGPointMake(point.y, point.x+self.view.frame.size.height/2);
    double dis1,dis2,dis3,dis4;

    if (changePoint.x>=rect.origin.x&&changePoint.x<=rect.origin.x+rect.size.width&&changePoint.y>=rect.origin.y&&changePoint.y<=rect.origin.y+rect.size.height)
    {
        if (changePoint.x>=rect.origin.x) {
            dis1 = changePoint.x - rect.origin.x;
        }
        if(changePoint.x<=rect.origin.x+rect.size.width)
        {
            dis2 = rect.origin.x+rect.size.width - changePoint.x;
        }
        if(changePoint.y>=rect.origin.y)
        {
            dis3 = changePoint.y- rect.origin.y;
        }
        if(changePoint.y<=rect.origin.y+rect.size.height)
        {
            dis4 = rect.origin.y+rect.size.height- changePoint.y;
        }
        disTipRingt.text = [NSString stringWithFormat:@"%.2f",5-[self minDist:dis1 dist:dis2 dist:dis3 dist:dis4]];
        if (5-[self minDist:dis1 dist:dis2 dist:dis3 dist:dis4]>0) {
            disTipRingt.text = [NSString stringWithFormat:@"+ %@",disTipRingt.text];
        }
        return true;
    }else
    {
        return false;
    }
    
}
//取mo最小数
-(double)minDist:(double)d1 dist:(double)d2 dist:(double)d3 dist:(double)d4
{
    d1 = abs(d1);
    d2 = abs(d2);
    d3 = abs(d3);
    d4 = abs(d4);
    double min = d1<d2?d1:d2;
    
    min =  min<d3?min:d3;
    min =  min<d4?min:d4;
    
    return  min;
    
}

//点到线的距离
-(double)distPointToLine:(CGPoint)point Line:(struct Line)line
{
    double s;
    s=(line.a*point.x+line.b*point.y+line.c)/sqrt(line.a*line.a+line.b*line.b);
    return s;
}

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
    SmoothLineView *leftView =  [[SmoothLineView alloc] initWithFrame:CGRectMake(0, 0, 240, 320)];
    leftView.delegate = self;
    leftView.status = STATUS_LEFT;
    leftView.backgroundColor = [UIColor clearColor];
    leftView.lineColor = [UIColor blackColor];
    SmoothLineView *ringtView =  [[SmoothLineView alloc] initWithFrame:CGRectMake(240, 0, 240, 320)];
    ringtView.backgroundColor = [UIColor clearColor];
    ringtView.lineColor = [UIColor whiteColor];
    ringtView.status = STATUS_RIGHT;
    ringtView.delegate = self;
    [self.view addSubview:ringtView];
    [self.view addSubview:leftView];
    
    disTipLeft = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    disTipLeft.center = CGPointMake(leftView.frame.size.width/2, leftView.frame.size.height/2+15);
    disTipLeft.backgroundColor = [UIColor  clearColor];
    disTipLeft.text = @"+ 0.00";
    [self.view addSubview:disTipLeft];
    
    disTipRingt = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    disTipRingt.center = CGPointMake(ringtView.frame.size.width/2+self.view.frame.size.height/2, ringtView.frame.size.height/2+15);
    disTipRingt.backgroundColor = [UIColor  clearColor];
    disTipRingt.text = @"+ 0.00";
    disTipRingt.textColor = [UIColor whiteColor];
    [self.view addSubview:disTipRingt];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//失败界面
-(void)failViewDidLoad
{
    if (failView==nil) {
        failView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    }
    
    failView.hidden = NO;
    failView.backgroundColor = [UIColor redColor];
    UIButton *displayBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 250, 40,30 )];
    [displayBtn setTitle:@"炫耀" forState:UIControlStateNormal];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(225, 250, 40,30 )];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
     [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *againBtn = [[UIButton alloc]initWithFrame:CGRectMake(350, 250, 40,30 )];
    
    [againBtn setTitle:@"重来" forState:UIControlStateNormal];
    [againBtn addTarget:self action:@selector(againAction) forControlEvents:UIControlEventTouchUpInside];
    [failView addSubview:displayBtn];
    [failView addSubview:backBtn];
    [failView addSubview:againBtn];
    
    [self.view addSubview:failView];
    
}
//重来
-(void)againAction
{
    
}
//返回
-(void)backAction
{
    failView.hidden = YES;
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
