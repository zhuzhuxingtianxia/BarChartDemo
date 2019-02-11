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
    barChart.yLabels = @[@10,@20,@25,@15,@20];
    barChart.xLabels = @[@"本店",@"天天果园",@"百果园",@"每日优鲜",@"爱鲜蜂"];
    
    [self.view addSubview:barChart];
}


-(NSArray*)getStoryboardFiles {
    //storyboard在Bundle里面以“*.storyboardc”文件存在
    NSArray *array = [[NSBundle mainBundle] pathsForResourcesOfType:@"storyboardc" inDirectory:nil];
    NSMutableArray * __array = [NSMutableArray array];
    for (NSString *path in array) {
        NSString *file = [path lastPathComponent];
        NSLog(@"%@",file);
        
        NSString *fileName = [file stringByDeletingPathExtension];
        
        if (![fileName isEqualToString:@"Main"] && !([fileName containsString:@"Launch"]||[fileName containsString:@"~"])) {
            //这里设置忽略加载的Storyboard
            if ([fileName rangeOfString:@"ignore"].length == 0)
                [__array addObject:[UIStoryboard storyboardWithName:fileName bundle:nil]];
        }
        
    }
    
    //延迟加载，开发过程中优选加载编辑中的storyboard
    [__array addObject:[UIStoryboard storyboardWithName:@"Main" bundle:nil]];
    
    return __array;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
