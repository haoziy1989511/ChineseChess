//
//  ViewController.m
//  MyChineseChess
//
//  Created by laomi on 16/4/12.
//  Copyright © 2016年 LAOMI. All rights reserved.
//

#import "ViewController.h"
#import "ChessBoard.h"
#import "GameViewController.h"

//@interface ViewController ()
//{
//    ChessBoard *gameChessBoard;
//}
//@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, 60, 44)];
    [btn setTitle:@"开战" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
//    [self.view addSubview:gameChessBoard];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)test:(UIButton*)b
{
    ChessBoard *gameChessBoard = [[ChessBoard alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width)];
    gameChessBoard.backgroundColor = [UIColor whiteColor];
    GameViewController *game = [[GameViewController alloc]initWithChessBoard:gameChessBoard];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:game animated:YES];
    });
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
