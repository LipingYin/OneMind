//
//  GrawViewController.h
//  Onemind
//
//  Created by yinliping on 14-6-30.
//  Copyright (c) 2014年 LipingYin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmoothLineView.h"

@interface GrawViewController : UIViewController<CurPointsDelegate>
{
    UIView *failView;
    
    UILabel *disTipLeft;
    UILabel *disTipRingt;
}

@end
@interface ReferenceView : UIView

@end

