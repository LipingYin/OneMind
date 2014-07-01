//
//  SmoothLineView.h
//  Smooth Line View
//
//  Created by Levi Nunnink on 8/15/11.
//  Copyright 2011 culturezoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CurPointsDelegate <NSObject>
-(void)curLeftPoints:(CGPoint)mid1;
-(void)curRightPoints:(CGPoint)mid1;
@end

@interface SmoothLineView : UIView {
    @private
    CGPoint currentPoint;
    CGPoint previousPoint1;
    CGPoint previousPoint2;
    CGFloat lineWidth;
    UIColor *lineColor;
    UIImage *curImage;
    __weak id <CurPointsDelegate> _delegate;
}
@property (nonatomic, strong) UIColor *lineColor;
@property (readwrite) CGFloat lineWidth;
@property(assign,nonatomic)id<CurPointsDelegate> delegate;

@end
