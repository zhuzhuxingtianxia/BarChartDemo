//
//  ZJBarGraphView.m
//  BarChartDemo
//
//  Created by ZZJ on 2017/12/21.
//  Copyright © 2017年 Jion. All rights reserved.
//

#import "ZJBarGraphView.h"
#import "ZJBarChart.h"
@interface ZJBarGraphView()
/** 单价label */
@property(nonatomic,strong)UILabel *unitLabel;
/** 柱状图 */
@property(nonatomic,strong)ZJBarChart *barChart;

/** 保存item数组 */
@property(nonatomic,strong)NSMutableArray *itemsArray;
@end

@implementation ZJBarGraphView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemsArray = [NSMutableArray array];
        
        [self addSubview:self.unitLabel];
        
        [self addSubview:self.barChart];
    }
    return self;
}

#pragma mark Setter
-(void)setXLabels:(NSArray<NSString *> *)xLabels{
    _xLabels = xLabels;
    self.barChart.xLabels = _xLabels;
    
    [self loadItems];
}

-(void)setYLabels:(NSArray<NSNumber *> *)yLabels{
    _yLabels = yLabels;
    self.barChart.yLabels = _yLabels;
}


-(void)loadItems{
    if (self.itemsArray.count > 0) {
        [self.itemsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.itemsArray removeAllObjects];
    }
    
    for (NSInteger k = 0; k < self.xLabels.count; k ++) {
        NSString *title = self.xLabels[k];
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        [item setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [item setTitle:[NSString stringWithFormat:@" %@",title] forState:UIControlStateNormal];
        UIColor *color = self.barChart.barColors[k % self.barChart.barColors.count];
        UIImage *image = [self imageFromColor:color];
        [item setImage:image forState:UIControlStateNormal];
        [self.itemsArray addObject:item];
        [self addSubview:item];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.unitLabel sizeToFit];
    self.unitLabel.frame = CGRectMake(11, 10, self.unitLabel.bounds.size.width, self.unitLabel.bounds.size.height);
    
    CGFloat rightSpacing = 10;
    UIView *temp;
    for (NSInteger k = self.itemsArray.count - 1; k >= 0; k--) {
        UIButton *item = self.itemsArray[k];
        [item sizeToFit];
        CGFloat itemWidth = item.bounds.size.width + 10;
        CGFloat itemX;
        if (temp) {
            itemX = CGRectGetMinX(temp.frame) - itemWidth;
        }else{
            itemX = self.bounds.size.width - rightSpacing - itemWidth;
        }
        
        item.frame = CGRectMake(itemX, 10, itemWidth, item.bounds.size.height);
        temp = item;
    }
    
    self.barChart.frame = CGRectMake(0, CGRectGetMaxY(self.unitLabel.frame) + 20, self.bounds.size.width, self.bounds.size.height - CGRectGetMaxY(self.unitLabel.frame) - 10);
}

#pragma mark Prvite
-(UIImage *)imageFromColor:(UIColor*)color{
    CGRect rect = CGRectMake(0, 0, 8, 8);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark  Getter
-(ZJBarChart*)barChart{
    if (!_barChart) {
        _barChart = [[ZJBarChart alloc] initWithFrame:CGRectZero];
        _barChart.barWidth = 18.0;
        _barChart.barColors = @[[UIColor redColor],[UIColor orangeColor],[UIColor blueColor]];
    }
    return _barChart;
}

-(UILabel*)unitLabel{
    if (!_unitLabel) {
        _unitLabel = [UILabel new];
        _unitLabel.font = [UIFont systemFontOfSize:13.0];
        _unitLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _unitLabel.text = @"元/500g";
    }
    return _unitLabel;
}

@end
