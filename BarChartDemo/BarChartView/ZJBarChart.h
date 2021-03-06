//
//  ZJBarChart.h
//  BarChartDemo
//
//  Created by ZZJ on 2017/12/21.
//  Copyright © 2017年 Jion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJBarChart : UIView
/** 柱状图数据源 */
@property(nonatomic,strong)NSArray<NSNumber *> *yLabels;
/** 图格说明 */
@property(nonatomic,strong)NSArray<NSString *> *xLabels;
/** 图格颜色 默认红色*/
@property(nonatomic)NSArray<UIColor *> *barColors;


/** 图格背景颜色 */
@property (nonatomic)UIColor *barBackgroundColor;

/** 图柱宽 默认20*/
@property(nonatomic,assign)CGFloat barWidth;
/** 图表间隔 默认均分但不小于10*/
@property(nonatomic,assign)NSInteger barSpacing;

@end
