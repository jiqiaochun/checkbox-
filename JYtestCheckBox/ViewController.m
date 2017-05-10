//
//  ViewController.m
//  JYtestCheckBox
//
//  Created by 姬巧春 on 2016/11/4.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "ViewController.h"

#import "JYTenQuestionsController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnClick:(UIButton *)sender{
    JYTenQuestionsController *vc = [[JYTenQuestionsController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
