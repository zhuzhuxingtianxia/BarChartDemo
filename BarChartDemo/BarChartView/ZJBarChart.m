//
//  ZJBarChart.m
//  BarChartDemo
//
//  Created by ZZJ on 2017/12/21.
//  Copyright © 2017年 Jion. All rights reserved.
//

#import "ZJBarChart.h"
@interface ZJBarChart()
{
    ///最小间隔
    CGFloat _minBarSpacing;
    ///到左右两边的距离
    CGFloat _leftSpacing;
    CGFloat _rightSpacing;
    
    ///到底部的距离
    CGFloat _bottomSpacing;
}
@end

@implementation ZJBarChart

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupDefaultsValue];
    }
    return self;
}

/**
 设置默认值
 */
-(void)setupDefaultsValue{
    _leftSpacing = 40;
    _rightSpacing = 20;
    _bottomSpacing = 40;
    _barWidth = 20;
    _minBarSpacing = 10;
    _barColors = @[[UIColor redColor]];
}

#pragma mark drawRect
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    //获取数据最大值
    CGFloat metaMaxValue = [[self.numberData valueForKeyPath:@"@max.self"] floatValue];
    self.maxValue = self.maxValue > metaMaxValue ? self.maxValue: metaMaxValue;
    //检查间隔合理值
    CGFloat barSpacing = (CGRectGetWidth(rect) - _leftSpacing - _rightSpacing - _barWidth * self.numberData.count)/(self.numberData.count + 1);
    self.barSpacing = self.barSpacing >= barSpacing ? self.barSpacing : barSpacing;
    
    CGFloat viewMaxHeight = CGRectGetHeight(rect);
    CGFloat barMaxHeight = viewMaxHeight - _bottomSpacing;
    CGFloat viewWidth = CGRectGetWidth(rect);
    //设置边框
    [self drawEdgeViewWidth:viewWidth barHeight:barMaxHeight];
    
    //设置标尺
    [self lineOfRulerViewWidth:viewWidth barHeight:barMaxHeight];
    
    //设置参照信息
    [self drawBottomTextBarHeight:barMaxHeight];
    
    //填充柱状图
    [self drawBarHeight:barMaxHeight];
    
}


/**
 绘制边框
 
 @param viewWidth 当前视图的宽
 @param barMaxHeight 柱图的最大高度（视图总高 - 底部文字的高度）
 */
-(void)drawEdgeViewWidth:(CGFloat)viewWidth barHeight:(CGFloat)barMaxHeight {
    
    //draw
    CGContextRef context = UIGraphicsGetCurrentContext();
    //绘制外框
    UIColor *horizontalLineColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:0.5];
    [horizontalLineColor setFill];
    CGRect hLineRect = CGRectMake(_leftSpacing, barMaxHeight, viewWidth - _leftSpacing - 20, 1.0);
    CGContextFillRect(context, hLineRect);
    
    UIColor *verticalLineColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:0.5];
    [verticalLineColor setFill];
    CGRect vLineRect = CGRectMake(_leftSpacing, 0, 1.0, barMaxHeight);
    CGContextFillRect(context, vLineRect);
    
}

/**
 绘制标尺和标尺线
 
 @param viewWidth 当前视图的宽
 @param barMaxHeight 柱图的最大高度（视图总高 - 底部文字的高度）
 */
-(void)lineOfRulerViewWidth:(CGFloat)viewWidth barHeight:(CGFloat)barMaxHeight{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置等分数量
    CGFloat cout = 5.0;
    for (NSInteger j = 0; j < cout; j ++) {
        UIFont *font = [UIFont systemFontOfSize:13.0];
        CGFloat grade = self.maxValue * (1.0 - j/cout);
        NSString *gradeString = [NSString stringWithFormat:@"%.2f",grade];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        //计算字体大小
        NSDictionary *attrs = @{NSFontAttributeName : font};
        CGSize lableSize = [gradeString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        
        CGFloat labelY = barMaxHeight / cout * j;
        
        [gradeString drawInRect:CGRectMake(0, labelY, _leftSpacing, lableSize.height) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithWhite:0.56 alpha:1.0],NSParagraphStyleAttributeName:paragraphStyle}];
        
        //虚线
        // 设置线条的样式
        CGContextSetLineCap(context, kCGLineCapRound);
        // 绘制线的宽度
        CGContextSetLineWidth(context, 1.0);
        // 线的颜色
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.3].CGColor);
        
        // 设置虚线绘制起点
        CGContextMoveToPoint(context, _leftSpacing, labelY + lableSize.height / 2.0);
        // lengths的值｛3,2｝表示先绘制3个点，再跳过2个点，如此反复
        CGFloat lengths[] = {3,2};
        // 虚线的起始点
        CGContextSetLineDash(context, 0, lengths,2);
        // 绘制虚线的终点
        CGContextAddLineToPoint(context, viewWidth - _rightSpacing,labelY + lableSize.height / 2.0);
        // 绘制
        CGContextStrokePath(context);
        
    }
}

/**
 绘制底部文字
 
 @param barMaxHeight 柱图的最大高度（视图总高 - 底部文字的高度）
 */
-(void)drawBottomTextBarHeight:(CGFloat)barMaxHeight{
    if (self.labels) {
        UIFont *font = [UIFont systemFontOfSize:13.0];
        
        [self.labels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            //计算字体大小
            NSDictionary *attrs = @{NSFontAttributeName : font};
            CGSize lableSize = [obj boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
            
            CGFloat labelX = _leftSpacing + _barSpacing / 2.0 + idx * (_barWidth + _barSpacing);
            CGFloat labelY = barMaxHeight + (_bottomSpacing - lableSize.height) / 2.0;
            
            [obj drawInRect:CGRectMake(labelX, labelY, _barWidth + _barSpacing, _bottomSpacing) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor colorWithWhite:0.56 alpha:1.0],NSParagraphStyleAttributeName:paragraphStyle}];
            
        }];
    }
}

-(void)drawBarHeight:(CGFloat)barMaxHeight{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSInteger k = 0; k < self.numberData.count; k++) {
        CGFloat barHeight = barMaxHeight * [self.numberData[k] floatValue] / self.maxValue;
        barHeight = barHeight > 0.5 ? barHeight : 0.5;
        
        CGFloat x = _leftSpacing + _barSpacing + k * (_barWidth + _barSpacing);
        
        if (self.barBackgroundColor) {
            [self.barBackgroundColor setFill];
            CGRect backgrounRect = CGRectMake(x, 0, _barWidth, barMaxHeight);
            CGContextFillRect(context, backgrounRect);
        }
        
        UIColor *barColor = self.barColors[k % self.barColors.count];
        [barColor setFill];
        CGRect barRect = CGRectMake(x, barMaxHeight - barHeight, _barWidth, barHeight);
        CGContextFillRect(context, barRect);
        
    }
}

#pragma mark Setter
-(void)setNumberData:(NSArray<NSNumber *> *)numberData{
    _numberData = numberData;
    [self setNeedsDisplay];
}

-(void)setLabels:(NSArray *)labels{
    _labels = labels;
    [self setNeedsDisplay];
}

- (void)setBarColors:(NSArray<UIColor *> *)barColors{
    _barColors = barColors;
    [self setNeedsDisplay];
}

- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor{
    _barBackgroundColor = barBackgroundColor;
    [self setNeedsDisplay];
}

-(void)setMaxValue:(CGFloat)maxValue{
    _maxValue = maxValue;
    [self setNeedsDisplay];
}

- (void)setBarSpacing:(NSInteger)barSpacing{
    _barSpacing = barSpacing;
    [self setNeedsDisplay];
}


@end
