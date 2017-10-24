//
//  ViewController.m
//  NSOperation两个子类的基本应用
//
//  Created by YiGuo on 2017/10/24.
//  Copyright © 2017年 tbb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self blockOperation];
}
//不开新线程，在主线程执行，任务要加入队列才开启线程
-(void)invocationOperation{
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:@"test"];
    [op start];
}
-(void)blockOperation{
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 在主线程
        NSLog(@"1-run-%@",[NSThread currentThread]);
    }];
    // 添加额外的任务(在子线程执行)
    [op addExecutionBlock:^{
        NSLog(@"-2-run-%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"-3--run-%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"-4---run-%@",[NSThread currentThread]);
    }];
    [op start];
}
-(void)run{
    NSLog(@"--run--%@",[NSThread currentThread]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
