//
//  SmoothLineView.h
//  Smooth Line View
//
//  Created by Levi Nunnink on 8/15/11.
//  Copyright 2011 culturezoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CurPointsDelegate <NSObject>
-(void)curLeftPoints:(CGPoint)point status:(NSString *)status;
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
    NSString *status;//判断左右 
}
@property (nonatomic, strong) UIColor *lineColor;
@property (readwrite) CGFloat lineWidth;
@property(assign,nonatomic)id<CurPointsDelegate> delegate;
@property (nonatomic, strong) NSString *status;

@end
