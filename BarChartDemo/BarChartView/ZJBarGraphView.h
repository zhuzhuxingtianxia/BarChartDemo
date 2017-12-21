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
@property(nonatomic,strong)NSArray<NSNumber *> *numberData;
/** 图格说明 */
@property(nonatomic,strong)NSArray<NSString *> *labels;
/** 最大值 默认为数据源中的最大值*/
@property(nonatomic,assign)CGFloat  maxValue;

@end
