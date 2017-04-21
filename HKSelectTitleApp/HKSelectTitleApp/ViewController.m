//
//  ViewController.m
//  HKSelectTitleApp
//
//  Created by zhaoke.hzk on 2017/4/22.
//  Copyright © 2017年 TSAPP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<KSSelectTitleViewDelegate>

@property (nonatomic , strong)KSSelectTitleView* selectTitleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.selectTitleView = [[KSSelectTitleView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 40)];
    [self.selectTitleView updateTitles:@[@"test1",@"testttttt1",@"teseeee",@"testttttt2",@"testttttt3",@"testttttt4",@"testttttt5"]];
    [self.view addSubview:self.selectTitleView];
}

-(void)selectTitleView:(KSSelectTitleView* )selectTitleView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger )toIndex{
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
