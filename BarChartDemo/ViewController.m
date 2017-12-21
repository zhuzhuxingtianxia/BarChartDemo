//
//  ViewController.m
//  BarChartDemo
//
//  Created by ZZJ on 2017/12/21.
//  Copyright © 2017年 Jion. All rights reserved.
//

#import "ViewController.h"
#import "ZJBarGraphView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ZJBarGraphView *barChart = [[ZJBarGraphView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 250)];
    //barChart.backgroundColor = [UIColor groupTableViewBackgroundColor];
    barChart.numberData = @[@10,@20,@25,@15,@20];
    barChart.labels = @[@"本店",@"天天果园",@"百果园",@"每日优鲜",@"爱鲜蜂"];
    barChart.maxValue = 30.0;
    
    [self.view addSubview:barChart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
