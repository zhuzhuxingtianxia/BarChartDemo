//
//  ZJBarGraphView.h
//  BarChartDemo
//
//  Created by ZZJ on 2017/12/21.
//  Copyright © 2017年 Jion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJBarGraphView : UIView
/** 柱状图数据源 */
@property(nonatomic,strong)NSArray<NSNumber *> *yLabels;
/** 图格说明 */
@property(nonatomic,strong)NSArray<NSString *> *xLabels;

@end
